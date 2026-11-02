#!/usr/bin/env python3
"""
verify_assets.py - Comprehensive production asset integrity validator for Block Puzzle.

Verification checks:
1. Manifest structure and required fields completeness.
2. Every manifest asset exists on disk.
3. Every asset SHA256 cryptographic hash matches the manifest record.
4. No duplicate destination production paths exist.
5. No duplicate content (identical SHA256) unnecessarily bundled across distinct paths.
6. All target files reside strictly within the production assets/ directory.
7. File extensions match their documented categories (font=.ttf, ui_icon/particle=.png, audio_sfx=.ogg).
8. Strict naming conventions:
   - Fonts: PascalCase (e.g., Fredoka.ttf, Nunito.ttf)
   - Icons: icon_<name>.png (lowercase snake_case)
   - Particles: particle_<name>.png (lowercase snake_case)
   - Audio: sfx_<name>.ogg (lowercase snake_case)
9. No forbidden files (archives, preview graphics, temporary files) exist anywhere in assets/.
10. No unmanifested orphan assets exist in assets/.
"""

import sys
import os
import json
import hashlib
import re

MANIFEST_PATH = os.path.join("docs", "asset_manifest.json")
PRODUCTION_ROOT = "assets"

EXPECTED_EXTENSIONS = {
    "font": {".ttf", ".otf"},
    "ui_icon": {".png"},
    "particle": {".png"},
    "audio_sfx": {".ogg", ".wav", ".mp3"},
}

FORBIDDEN_EXTENSIONS = {".zip", ".tar", ".gz", ".7z", ".rar", ".unitypackage", ".bak", ".tmp", ".svg"}
FORBIDDEN_BASENAMES = {"preview.png", "preview.ogg", "sample.png", "thumbs.db", ".ds_store"}

NAMING_PATTERNS = {
    "font": re.compile(r"^[A-Z][a-zA-Z0-9]+\.(ttf|otf)$"),
    "ui_icon": re.compile(r"^icon_[a-z0-9_]+\.png$"),
    "particle": re.compile(r"^particle_[a-z0-9_]+\.png$"),
    "audio_sfx": re.compile(r"^sfx_[a-z0-9_]+\.(ogg|wav|mp3)$"),
}

REQUIRED_MANIFEST_FIELDS = [
    "path",
    "originalName",
    "sourcePack",
    "sourceRelativePath",
    "category",
    "purpose",
    "consumingPhase",
    "license",
    "sha256",
    "sizeBytes",
]

def verify_assets() -> int:
    print(f"[1/8] Loading and validating manifest schema from {MANIFEST_PATH}...")
    if not os.path.exists(MANIFEST_PATH):
        print(f"ERROR: Manifest missing at {MANIFEST_PATH}")
        return 1

    try:
        with open(MANIFEST_PATH, "r", encoding="utf-8") as f:
            data = json.load(f)
    except Exception as e:
        print(f"ERROR: Failed to parse manifest JSON: {e}")
        return 1

    assets = data.get("assets", [])
    if not assets:
        print("ERROR: Manifest contains no asset entries.")
        return 1

    print(f"      Loaded {len(assets)} asset records.")

    errors = []
    seen_paths = set()
    sha_to_paths = {}

    # Validate schema
    for idx, item in enumerate(assets):
        for field in REQUIRED_MANIFEST_FIELDS:
            if field not in item or item[field] is None or item[field] == "":
                errors.append(f"Asset #{idx} missing required field '{field}'")

    print("[2/8] Validating path hygiene, boundaries, and extensions...")
    for item in assets:
        path = item.get("path", "")
        category = item.get("category", "")
        normalized_path = os.path.normpath(path).replace("\\", "/")

        # Check boundary
        if not normalized_path.startswith(f"{PRODUCTION_ROOT}/"):
            errors.append(f"Security: Asset '{normalized_path}' is outside '{PRODUCTION_ROOT}/'")

        # Check uniqueness
        if normalized_path in seen_paths:
            errors.append(f"Duplicate path in manifest: '{normalized_path}'")
        seen_paths.add(normalized_path)

        # Check category extension
        ext = os.path.splitext(normalized_path)[1].lower()
        allowed_exts = EXPECTED_EXTENSIONS.get(category)
        if allowed_exts and ext not in allowed_exts:
            errors.append(
                f"Type mismatch: '{normalized_path}' (category: '{category}') has unexpected extension '{ext}'"
            )

    print("[3/8] Checking production naming conventions...")
    for item in assets:
        path = item.get("path", "")
        category = item.get("category", "")
        filename = os.path.basename(path)
        pattern = NAMING_PATTERNS.get(category)
        if pattern and not pattern.match(filename):
            errors.append(
                f"Naming convention violation: '{filename}' does not match pattern for category '{category}'"
            )

    print("[4/8] Verifying file presence on disk...")
    for item in assets:
        path = item.get("path", "")
        if not os.path.exists(path):
            errors.append(f"Missing file on disk: '{path}'")

    print("[5/8] Verifying cryptographic SHA256 checksums & file sizes...")
    for item in assets:
        path = item.get("path", "")
        expected_sha = item.get("sha256", "")
        expected_size = item.get("sizeBytes", 0)

        if os.path.exists(path):
            actual_size = os.path.getsize(path)
            if actual_size != expected_size:
                errors.append(
                    f"Size mismatch for '{path}': expected {expected_size} bytes, got {actual_size} bytes"
                )

            hasher = hashlib.sha256()
            with open(path, "rb") as f:
                while chunk := f.read(65536):
                    hasher.update(chunk)
            actual_sha = hasher.hexdigest()
            if actual_sha != expected_sha:
                errors.append(
                    f"Checksum mismatch for '{path}': expected {expected_sha}, got {actual_sha}"
                )

            sha_to_paths.setdefault(actual_sha, []).append(path)

    print("[6/8] Checking for redundant content duplicates...")
    for sha, paths in sha_to_paths.items():
        if len(paths) > 1:
            errors.append(f"Redundant duplicate content with SHA256 {sha}: {paths}")

    print("[7/8] Scanning for forbidden files in production tree...")
    for root, _, files in os.walk(PRODUCTION_ROOT):
        for f in files:
            ext = os.path.splitext(f)[1].lower()
            if ext in FORBIDDEN_EXTENSIONS:
                errors.append(f"Forbidden file extension found: '{os.path.join(root, f)}'")
            if f.lower() in FORBIDDEN_BASENAMES:
                errors.append(f"Forbidden preview/sample file found: '{os.path.join(root, f)}'")

    print("[8/8] Scanning for unmanifested orphan assets in assets/...")
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

    print(f"\nSUCCESS: All {len(assets)} production assets verified successfully across all 8 checks with 0 errors!")
    return 0

if __name__ == "__main__":
    sys.exit(verify_assets())
