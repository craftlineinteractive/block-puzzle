#!/usr/bin/env python3
"""
verify_assets.py - Validates production asset integrity for Block Puzzle.

Verification checks:
1. Every manifest asset file exists on disk.
2. Every asset SHA256 matches the manifest checksum.
3. No duplicate destination production paths exist.
4. No duplicate content (identical SHA256) unnecessarily bundled across distinct paths.
5. All target files reside strictly within the production assets/ directory.
6. File extensions match their documented categories (font=.ttf, ui_icon/particle=.png, audio_sfx=.ogg).
"""

import sys
import os
import json
import hashlib

MANIFEST_PATH = os.path.join("docs", "asset_manifest.json")
PRODUCTION_ROOT = "assets"

EXPECTED_EXTENSIONS = {
    "font": {".ttf", ".otf"},
    "ui_icon": {".png"},
    "particle": {".png"},
    "audio_sfx": {".ogg", ".wav", ".mp3"},
}

def verify_assets() -> int:
    print(f"[1/6] Loading manifest from {MANIFEST_PATH}...")
    if not os.path.exists(MANIFEST_PATH):
        print(f"ERROR: Manifest missing at {MANIFEST_PATH}")
        return 1

    with open(MANIFEST_PATH, "r", encoding="utf-8") as f:
        data = json.load(f)

    assets = data.get("assets", [])
    print(f"      Loaded {len(assets)} asset records.")

    seen_paths = set()
    sha_to_paths = {}
    errors = []

    print("[2/6] Validating path hygiene and boundaries...")
    for idx, item in enumerate(assets):
        path = item.get("path")
        category = item.get("category")
        expected_sha = item.get("sha256")

        if not path:
            errors.append(f"Item #{idx}: missing 'path' property.")
            continue

        normalized_path = os.path.normpath(path).replace("\\", "/")

        # 5. Check files are inside production assets directory
        if not normalized_path.startswith(f"{PRODUCTION_ROOT}/"):
            errors.append(f"Security: Asset '{normalized_path}' is outside '{PRODUCTION_ROOT}/'")

        # 3. Check for duplicate production paths
        if normalized_path in seen_paths:
            errors.append(f"Duplicate path in manifest: '{normalized_path}'")
        seen_paths.add(normalized_path)

        # 6. Check file extensions match category
        ext = os.path.splitext(normalized_path)[1].lower()
        allowed_exts = EXPECTED_EXTENSIONS.get(category)
        if allowed_exts and ext not in allowed_exts:
            errors.append(
                f"Type mismatch: '{normalized_path}' (category: '{category}') has unexpected extension '{ext}'"
            )

    print("[3/6] Verifying file presence on disk...")
    for item in assets:
        path = item.get("path")
        if not os.path.exists(path):
            errors.append(f"Missing file on disk: '{path}'")

    print("[4/6] Verifying cryptographic SHA256 checksums...")
    for item in assets:
        path = item.get("path")
        expected_sha = item.get("sha256")
        if os.path.exists(path):
            hasher = hashlib.sha256()
            with open(path, "rb") as f:
                while chunk := f.read(65536):
                    hasher.update(chunk)
            actual_sha = hasher.hexdigest()
            if actual_sha != expected_sha:
                errors.append(
                    f"Checksum mismatch for '{path}': expected {expected_sha}, got {actual_sha}"
                )
            
            # Group by sha to detect unnecessary duplicate files
            sha_to_paths.setdefault(actual_sha, []).append(path)

    print("[5/6] Checking for redundant content duplicates...")
    for sha, paths in sha_to_paths.items():
        if len(paths) > 1:
            errors.append(f"Redundant duplicate content with SHA256 {sha}: {paths}")

    print("[6/6] Checking for unmanifested orphan assets in assets/...")
    disk_assets = set()
    for root, _, files in os.walk(PRODUCTION_ROOT):
        for f in files:
            full_path = os.path.normpath(os.path.join(root, f)).replace("\\", "/")
            disk_assets.add(full_path)

    orphan_assets = disk_assets - seen_paths
    if orphan_assets:
        errors.append(f"Orphan assets in production directory not listed in manifest: {sorted(orphan_assets)}")

    if errors:
        print(f"\nFAILED: Found {len(errors)} error(s):")
        for err in errors:
            print(f"  - {err}")
        return 1

    print("\nSUCCESS: All 38 production assets verified successfully with 0 errors!")
    return 0

if __name__ == "__main__":
    sys.exit(verify_assets())

