# Task Plan: Block Puzzle - Phase 02B (Asset Validation, Design System Audit & Systematic Debugging)

## Phase 02B Objective
Perform an exhaustive audit and verification of all Phase 02 assets, license documents, design system tokens, typography configurations, asset bundle loading via `rootBundle`, and emulator deployments. Ensure that the original `BlockPuzzle_Asset_Library` remains strictly pristine, all 38 production assets pass cryptographic verification, WCAG AAA accessibility targets are strictly enforced, interactive touch targets maintain >= 48dp dimensions, and the full test suite and debug APK build complete with fresh reproducible evidence.

## Current Project Architecture
- **Framework**: Flutter 3.44.9 (Channel stable)
- **Dart SDK**: 3.12.2 (Environment sdk: ^3.12.2)
- **Dependencies**: `flutter`, `cupertino_icons: ^1.0.8`, `flutter_riverpod: ^3.4.3`
- **Dev Dependencies**: `flutter_test`, `flutter_lints: ^6.0.0`
- **Production Asset Count**: 38 files across `fonts/`, `images/ui/icons/`, `images/effects/particles/`, and `audio/`.
- **Standing Requirement**: Auto-compile and install updated build onto active emulator (`emulator-5554`) upon phase completion.

## Implementation & Audit Plan

### 1. Pre-Audit Review & Integrity Check
- [x] Inspect `pubspec.yaml`, `pubspec.lock`, `asset_paths.dart`, and design tokens.
- [x] Compare implementation against Phase 02A specifications.
- [x] Verify `BlockPuzzle_Asset_Library/` has 0 modifications, deletions, or moves.

### 2. Production Asset & Tooling Audit
- [x] Verify `assets/` structure and confirm no stray ZIPs, previews, or duplicates.
- [x] Audit `tooling/verify_assets.py` and enhance validation routines if needed.
- [x] Run `python tooling/verify_assets.py` to confirm all 38 assets match expected hashes and paths.

### 3. Font & Asset Bundle Loading Tests
- [x] Verify font definitions in `pubspec.yaml` (Fredoka and Nunito).
- [x] Implement `rootBundle` asset loading tests in `test/core/constants/asset_bundle_load_test.dart` to verify that every registered image, audio, and font file successfully loads from the Flutter AssetBundle.

### 4. Design System & Accessibility Review
- [x] Audit `AppColors` for contrast against dark navy backgrounds.
- [x] Audit `AppSpacing` and `AppRadii` for 4px scale consistency and minimum 48x48px touch targets.
- [x] Audit `AppTypography` for correct font-family assignment (Fredoka for scores/CTAs, Nunito for body/details).
- [x] Review `DesignSystemPreview` across various viewport dimensions to verify zero RenderFlex overflow.

### 5. Verification Commands Execution
- [x] Run `flutter pub get`.
- [x] Run `dart format .`.
- [x] Run `python tooling/verify_assets.py`.
- [x] Run `flutter analyze`.
- [x] Run `flutter test`.
- [x] Run `flutter build apk --debug`.

### 6. Emulator Deployment
- [x] Stream install updated debug APK to `emulator-5554`.
- [x] Launch application and verify live execution.

### 7. Documentation & Catalog Updates
- [x] Update `docs/ASSET_CATALOG.md`.
- [x] Update `task_plan.md` and `progress.md`.

## Phase 02 Final Acceptance Criteria
1. Original assets in `BlockPuzzle_Asset_Library/` remain untouched.
2. Only approved 38 production assets are bundled with lowercase snake_case naming.
3. License documentation (`docs/ASSET_LICENSES.md`, `docs/licenses/`) is accurate and complete.
4. `tooling/verify_assets.py` passes with 0 errors.
5. All assets (fonts, icons, particles, audio) load cleanly via `rootBundle`.
6. Contrast ratios exceed 4.5:1 (normal text) and 3:1 (large text).
7. Interactive touch targets are >= 48dp.
8. `flutter analyze` reports 0 issues.
9. All unit, widget, and bundle tests pass.
10. Android debug build succeeds and is installed on the emulator.
