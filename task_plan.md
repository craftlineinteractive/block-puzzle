# Task Plan: Block Puzzle - Phase 01A (Project Foundation, Codebase Audit and Architecture Setup)

## Phase 01 Objective
Establish a clean, scalable architectural foundation for the Block Puzzle project. This includes auditing the existing Flutter environment, documenting project structure, installing Flutter Riverpod for global state management, creating the folder hierarchy according to Clean Architecture / Feature-First principles with strict Game Engine isolation, establishing application bootstrap with portrait lock, providing a foundation Dark Material 3 theme, displaying a temporary verification screen, and delivering architectural documentation.

## Current Project Architecture
- **Framework**: Flutter 3.44.9 (Channel stable)
- **Dart SDK**: 3.12.2 (Environment sdk: ^3.12.2)
- **Platform Targets**: Android (namespace `com.craftlineinteractive.blockpuzzle`, AGP 9.0.1, Kotlin 2.3.20), iOS (Runner `blockpuzzle`)
- **Dependencies**: `flutter`, `cupertino_icons: ^1.0.8`, `flutter_riverpod: ^3.4.3`
- **Dev Dependencies**: `flutter_test`, `flutter_lints: ^6.0.0`
- **Asset Repositories**:
  - `BlockPuzzle_Asset_Library/`: External raw asset source containing Downloads, Extracted, and Fonts. Untouched.
  - `assets/`: Production-curated assets destination (empty in Phase 01).

## Implementation Status

### 1. Planning & Audit Documentation
- [x] Inspect Flutter & Dart SDK versions.
- [x] Inspect `pubspec.yaml`, `pubspec.lock`, and `analysis_options.yaml`.
- [x] Inspect existing code (`lib/main.dart`, `test/widget_test.dart`).
- [x] Inspect Android (`build.gradle.kts`, `app/build.gradle.kts`) and iOS (`Info.plist`) configuration.
- [x] Audit `assets/` and `BlockPuzzle_Asset_Library/` directories.
- [x] Verify baseline tests pass (`flutter test` & `flutter analyze`).
- [x] Create `task_plan.md` and `progress.md` in project root.

### 2. Dependency Management
- [x] Run `flutter pub add flutter_riverpod` to resolve stable Riverpod version for Dart 3.12.2.
- [x] Verify `pubspec.yaml` updates without manual version forcing or unnecessary code generation packages.
- [x] Retain existing `flutter_lints` and `flutter_test`.

### 3. Folder Architecture Setup
- [x] Create directory structure under `lib/`:
  - `lib/app/`
  - `lib/core/constants/`
  - `lib/core/theme/`
  - `lib/core/utils/`
  - `lib/core/errors/`
  - `lib/game_engine/models/`
  - `lib/game_engine/board/`
  - `lib/game_engine/blocks/`
  - `lib/game_engine/generator/`
  - `lib/game_engine/scoring/`
  - `lib/game_engine/rules/`
  - `lib/features/splash/`
  - `lib/features/home/`
  - `lib/features/game/`
  - `lib/features/levels/`
  - `lib/features/challenge/`
  - `lib/features/statistics/`
  - `lib/features/achievements/`
  - `lib/features/boosters/`
  - `lib/features/themes/`
  - `lib/features/settings/`
  - `lib/features/auth/`
  - `lib/features/leaderboard/`
  - `lib/services/storage/`
  - `lib/services/audio/`
  - `lib/services/ads/`
  - `lib/services/supabase/`
  - `lib/shared/widgets/`
  - `lib/shared/animations/`

### 4. Core Theme Foundation
- [x] Create `lib/core/theme/app_theme.dart`:
  - Material 3 dark theme foundation.
  - Vibrant deep palette tailored for casual block puzzle gameplay.
  - Centralized theme tokens and ThemeData configuration.

### 5. Application Bootstrap
- [x] Create `lib/features/home/temporary_foundation_screen.dart`:
  - Centered screen showing:
    - "BLOCK PUZZLE"
    - "Project foundation ready."
  - No premature game logic, boards, counters, coins, or animations.
- [x] Create `lib/app/block_puzzle_app.dart`:
  - Root `MaterialApp` widget.
  - `title: 'Block Puzzle'`.
  - `debugShowCheckedModeBanner: false`.
  - Dark theme integrated from `AppTheme`.
  - Home pointing to `TemporaryFoundationScreen`.
- [x] Update `lib/main.dart`:
  - `WidgetsFlutterBinding.ensureInitialized()`
  - Portrait orientation lock (`SystemChrome.setPreferredOrientations`).
  - Wrapped in `ProviderScope`.
  - Minimal and clean bootstrap.

### 6. Testing & Quality Verification
- [x] Update `test/widget_test.dart` to smoke test `BlockPuzzleApp` with `ProviderScope`.
- [x] Run `flutter test` to ensure all tests pass.
- [x] Run `flutter analyze` to verify zero static analysis errors/warnings.

### 7. Documentation
- [x] Create `docs/architecture.md` covering:
  1. Application architecture.
  2. Folder responsibilities.
  3. Dependency decisions.
  4. Riverpod usage strategy.
  5. Game engine separation.
  6. Asset management policy.
  7. Offline-first development strategy.
  8. Future Supabase integration boundaries.
  9. Testing structure.

### 8. Progress Update & Final Review
- [x] Confirm `BlockPuzzle_Asset_Library/` is 100% untouched.
- [x] Update `task_plan.md` and `progress.md`.

## Files Created
- `task_plan.md`
- `progress.md`
- `lib/core/theme/app_theme.dart`
- `lib/features/home/temporary_foundation_screen.dart`
- `lib/app/block_puzzle_app.dart`
- `docs/architecture.md`

## Files Modified
- `pubspec.yaml` (addition of `flutter_riverpod: ^3.4.3`)
- `pubspec.lock` (resolved dependency lockfile)
- `lib/main.dart` (clean application entrypoint with portrait lock & Riverpod ProviderScope)
- `test/widget_test.dart` (updated foundation smoke test for BlockPuzzleApp)

## Phase 01 Acceptance Criteria Verification
1. [x] Project audit completed and documented.
2. [x] `flutter_riverpod` added and resolved cleanly without version conflicts (`^3.4.3`).
3. [x] Folder architecture created cleanly across `app`, `core`, `game_engine`, `features`, `services`, and `shared`.
4. [x] `main.dart` initialized with portrait lock and `ProviderScope`.
5. [x] `BlockPuzzleApp` configured with Material 3 and dark theme.
6. [x] Temporary foundation screen displays "BLOCK PUZZLE" and "Project foundation ready." without extra clutter.
7. [x] `docs/architecture.md` comprehensively documents architecture rules and boundaries.
8. [x] Original `BlockPuzzle_Asset_Library/` remains untouched.
9. [x] `flutter analyze` (0 issues) and `flutter test` (1/1 passed) both completed cleanly.
