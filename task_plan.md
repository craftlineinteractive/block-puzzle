# Task Plan: Block Puzzle - Phase 03A (Splash Screen, Home Screen and Navigation Implementation)

## Phase 03A Objective
Implement the animated Splash Screen, arcade puzzle-styled Home Screen with mode cards and secondary shortcuts, and declarative GoRouter navigation architecture with feature placeholders.

## Current Project Architecture
- **Framework**: Flutter 3.44.9 (Channel stable)
- **Dart SDK**: 3.12.2 (Environment sdk: ^3.12.2)
- **Dependencies**: `flutter`, `cupertino_icons: ^1.0.8`, `flutter_riverpod: ^3.4.3`, `go_router: ^18.1.2`
- **Dev Dependencies**: `flutter_test`, `flutter_lints: ^6.0.0`
- **Design Tokens**: `AppColors`, `AppSpacing`, `AppRadii`, `AppTypography`, `AssetPaths`
- **Standing Requirement**: Auto-compile and install updated build onto active emulator (`emulator-5554`) upon phase completion.

## Navigation Route Table
| Path | Route Name | Screen Component | Status |
| :--- | :--- | :--- | :--- |
| `/` | `splash` | `SplashScreen` | Completed & Verified |
| `/home` | `home` | `HomeScreen` | Completed & Verified |
| `/classic` | `classic` | `FeaturePlaceholderScreen` | Completed & Verified |
| `/levels` | `levels` | `FeaturePlaceholderScreen` | Completed & Verified |
| `/time-attack` | `timeAttack` | `FeaturePlaceholderScreen` | Completed & Verified |
| `/daily-challenge` | `dailyChallenge` | `FeaturePlaceholderScreen` | Completed & Verified |
| `/zen` | `zen` | `FeaturePlaceholderScreen` | Completed & Verified |
| `/statistics` | `statistics` | `FeaturePlaceholderScreen` | Completed & Verified |
| `/themes` | `themes` | `FeaturePlaceholderScreen` | Completed & Verified |
| `/achievements` | `achievements` | `FeaturePlaceholderScreen` | Completed & Verified |
| `/settings` | `settings` | `FeaturePlaceholderScreen` | Completed & Verified |
| `/design-preview` | `designPreview` | `DesignSystemPreview` | Completed & Verified |

## Implementation Tasks
- [x] Task 1: Package Installation & Pubspec Setup (`go_router: ^18.1.2` installed via `flutter pub add`).
- [x] Task 2: Route Definitions & Declarative Routing Architecture (`app_routes.dart`, `app_router.dart`, and `block_puzzle_app.dart`).
- [x] Task 3: Feature Placeholder Screen (`feature_placeholder_screen.dart` with route-specific honest metadata).
- [x] Task 4: Animated Splash Screen (`puzzle_logo_mark.dart`, `splash_tile_animation.dart`, `splash_screen.dart` with reduced-motion support).
- [x] Task 5: Home Screen & Reusable Game Mode Widgets (`home_header.dart`, `home_hero_card.dart`, `game_mode_card.dart`, `game_modes_section.dart`, `home_shortcut_tile.dart`, `home_background_decoration.dart`, `home_screen.dart`).
- [x] Task 6: Comprehensive Automated Tests (41 unit, widget, and routing tests passing; `flutter analyze` 0 issues).
- [x] Task 7: Build & Emulator Deployment (Debug APK built and installed on `emulator-5554`; screens captured and visually verified).
