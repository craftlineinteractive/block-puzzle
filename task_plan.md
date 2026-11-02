# Task Plan: Block Puzzle - Phase 02A (Asset Integration & Reusable Game Design System)

## Phase 02A Objective
Safely curate, vendor, and organize game assets from `BlockPuzzle_Asset_Library` into the production `assets/` directory without touching original download archives. Implement a centralized, scalable, premium dark arcade Game Design System in Flutter (`AppColors`, `AppSpacing`, `AppRadii`, `AppTypography`, `AppTheme`), register offline-capable fonts (Fredoka and Nunito), configure centralized asset constants (`AssetPaths`), establish license provenance (`docs/ASSET_LICENSES.md`, `docs/ASSET_CATALOG.md`, `docs/asset_manifest.json`), implement automated asset integrity validation (`tooling/verify_assets.py`), and deliver a responsive development design preview component (`DesignSystemPreview`) with automated test coverage.

## Current Project Architecture
- **Framework**: Flutter 3.44.9 (Channel stable)
- **Dart SDK**: 3.12.2 (Environment sdk: ^3.12.2)
- **Dependencies**: `flutter`, `cupertino_icons: ^1.0.8`, `flutter_riverpod: ^3.4.3`
- **Dev Dependencies**: `flutter_test`, `flutter_lints: ^6.0.0`
- **Asset Sources**:
  - `BlockPuzzle_Asset_Library/`: Read-only source containing Downloads, Extracted, and Fonts. Strictly untouched.
  - `assets/`: Destination for selected, optimized, semantic production assets (38 production files).

## Implementation Status

### 1. Planning & Pre-Modification Audit
- [x] Inspect existing Phase 01 architecture (`lib/`, `test/`, `pubspec.yaml`, `docs/architecture.md`).
- [x] Recursively inventory `BlockPuzzle_Asset_Library/` (archives, fonts, images, sounds, licenses).
- [x] Create and maintain `task_plan.md` and `progress.md`.

### 2. Asset Selection & Safe Copying
- [x] Fonts: Copied `Fredoka.ttf` and `Nunito.ttf` (Variable TTF, OFL 1.1) to `assets/fonts/`.
- [x] Icons: Selected 18 transparent white 2x standalone PNGs from `kenney_game-icons` and copied to `assets/images/ui/icons/`.
- [x] VFX Particles: Selected 6 transparent particle PNGs (sparks, stars, flares, glow circle) from `kenney_particle-pack` and copied to `assets/images/effects/particles/`.
- [x] Audio: Selected 10 semantic OGG sound effects (UI click, placement, clear, combo, jingles) to `assets/audio/`.
- [x] Verified zero files in `BlockPuzzle_Asset_Library/` were moved, modified, or deleted (`git status` clean).

### 3. Asset Tracking, Licensing & Tooling
- [x] Copied license documents to `docs/licenses/` (Kenney CC0, SIL OFL 1.1).
- [x] Created `docs/ASSET_LICENSES.md`.
- [x] Created `docs/ASSET_CATALOG.md` with full origin-to-production mapping, purposes, and SHA256 checksums.
- [x] Generated `docs/asset_manifest.json` with structured metadata.
- [x] Implemented `tooling/verify_assets.py` (Python stdlib) validating manifest integrity, SHA256 hashes, path containment, and category-extension alignment (all 6 checks passed).

### 4. Flutter Asset Registration & Constants
- [x] Updated `pubspec.yaml` to declare font families (`Fredoka`, `Nunito`) and production asset directories.
- [x] Ran `flutter pub get` (exit code 0).
- [x] Created `lib/core/constants/asset_paths.dart` with strongly-typed, logically grouped constants.

### 5. Game Design System & Theme Engine
- [x] Created `lib/core/theme/app_colors.dart` with premium dark arcade palette (Navy `#101A2B`, board surface `#1B2940`, empty cell `#2B3D57`, and 8 vibrant block colors).
- [x] Created `lib/core/theme/app_spacing.dart` (4-pixel grid multiples: xs, sm, md, lg, xl, xxl).
- [x] Created `lib/core/theme/app_radii.dart` (small, medium, large, extraLarge, pill, and 48px minimum touch targets).
- [x] Created `lib/core/theme/app_typography.dart` (TextTheme mapping Fredoka to display/headlines/score and Nunito to body/labels).
- [x] Updated `lib/core/theme/app_theme.dart` to synthesize design tokens into Material 3 `ThemeData`.

### 6. Development Design System Preview
- [x] Created `lib/shared/widgets/design_system_preview.dart` displaying color palette, typography hierarchy, button styles, cards, spacing/radius tokens, and imported icon assets.

### 7. Automated Testing & Verification
- [x] Created `test/core/theme/app_colors_test.dart` (including WCAG contrast calculations: normal text >= 4.5:1, large text >= 3:1).
- [x] Created `test/core/theme/app_typography_test.dart`.
- [x] Created `test/core/constants/asset_paths_test.dart`.
- [x] Created `test/shared/widgets/design_system_preview_test.dart`.
- [x] Ran `python tooling/verify_assets.py` (Passed, 0 errors).
- [x] Ran `dart format .` (All files formatted cleanly).
- [x] Ran `flutter analyze` (Passed, 0 issues).
- [x] Ran `flutter test` (All 19 tests passed).

## Phase 02A Acceptance Criteria Verification
1. [x] Asset library is strictly untouched (`BlockPuzzle_Asset_Library/` clean).
2. [x] Only genuinely useful assets are copied to `assets/` with snake_case naming (38 files total).
3. [x] Licenses and catalogs are documented with SHA256 checksums.
4. [x] Python verification script passes with 0 errors.
5. [x] Fonts are declared in `pubspec.yaml` and load offline.
6. [x] Design tokens (`AppColors`, `AppSpacing`, `AppRadii`, `AppTypography`) are established and clean.
7. [x] Color palette meets WCAG contrast criteria (Primary text on background ratio > 15:1; secondary text > 8:1).
8. [x] `DesignSystemPreview` renders all tokens responsively without overflow.
9. [x] All unit, widget, and contrast tests pass with 0 failures (19/19 passed).
10. [x] `flutter analyze` reports 0 issues.
