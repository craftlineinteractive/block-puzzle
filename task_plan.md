# Phase 04A: Immersive Arcade Gameplay Screen & Responsive 10x10 Board UI Plan

**Goal:** Build a premium, arcade-styled 10x10 puzzle gameplay screen featuring an anti-aliased glossy CustomPainter board, compact game HUD with score display, three-piece preview tray ("YOUR NEXT BLOCKS"), and game-styled pause overlay, wired to `/classic`.

**Status:** Completed & Live Verified on Emulator (`emulator-5554`)

**Architecture:** Presentation-only gameplay UI layered under `lib/features/game/`. CustomPainter-based board rendering with `RepaintBoundary` isolation. Decoupled presentation preview data model `GameScreenPreviewData`. Seamless GoRouter integration replacing the `/classic` placeholder.

**Tech Stack:** Flutter 3.44.9, Dart 3.12.2, Riverpod 3.4.3, GoRouter 18.1.2, CustomPainter, Material 3 Dark Arcade Design System.

---

## 1. Visual & Layout Architecture
- **Root Screen**: `GameScreen` with dark immersive backdrop, subtle radial ambient glow, and `SafeArea`.
- **Top HUD**: Compact row with Pause button (left, 48x48dp target), centralized `ScoreDisplay` ("SCORE" / "0000"), and Best Score indicator ("BEST" / "—").
- **10x10 Board**: `BoardWidget` utilizing `BoardPainter` with `RepaintBoundary`. 10x10 grid (100 cells) with uniform spacing, subtle cell bevels, and glossy block rendering (`BlockTilePainter`).
- **Piece Tray**: `BlockTrayPreview` titled "YOUR NEXT BLOCKS" displaying 3 distinct preview pieces (4-cell horizontal line, 2x2 square, 3x2 L-shape) using `PreviewBlockWidget`.
- **Pause Overlay**: `PauseOverlay` with dark translucent barrier, glowing arcade modal panel, "RESUME" (dismiss) and "HOME" (`context.go('/home')`).
- **Routing**: Updated `/classic` in `app_router.dart` to render `const GameScreen()`.

---

## 2. Directory & File Inventory
```
lib/features/game/
├── presentation/
│   ├── game_screen.dart
│   ├── models/
│   │   └── game_screen_preview_data.dart
│   └── painters/
│       ├── board_painter.dart
│       └── block_tile_painter.dart
└── widgets/
    ├── game_hud.dart
    ├── score_display.dart
    ├── board_widget.dart
    ├── block_tray_preview.dart
    ├── preview_block_widget.dart
    └── pause_overlay.dart
```

---

## 3. Implementation Checklist & Verification Status

- [x] **Task 1: Presentation Preview Data Model**
  - Created `lib/features/game/presentation/models/game_screen_preview_data.dart` (`PreviewPiece`, `GameScreenPreviewData.empty()`, `GameScreenPreviewData.samplePreview()`).
- [x] **Task 2: Glossy Tile & Board Custom Painters**
  - Created `lib/features/game/presentation/painters/block_tile_painter.dart` with dual-stop gradients, top specular sheen, and bevel shadows.
  - Created `lib/features/game/presentation/painters/board_painter.dart` drawing 100 anti-aliased cells with uniform 3.0px gaps and inset frame shadow.
- [x] **Task 3: Board Widget**
  - Created `lib/features/game/widgets/board_widget.dart` with `RepaintBoundary`, `AspectRatio(1.0)`, and accessible semantics.
- [x] **Task 4: Game HUD & Score Display**
  - Created `lib/features/game/widgets/score_display.dart` with Fredoka tabular numerals and glowing text shadow.
  - Created `lib/features/game/widgets/game_hud.dart` with 48x48dp pause button, centered score, and best score.
- [x] **Task 5: Three-Piece Tray Preview**
  - Created `lib/features/game/widgets/preview_block_widget.dart` and `lib/features/game/widgets/block_tray_preview.dart` with "YOUR NEXT BLOCKS" header and 3 glossy preview slots.
- [x] **Task 6: Pause Overlay**
  - Created `lib/features/game/widgets/pause_overlay.dart` with translucent modal barrier, glowing panel, and 48dp RESUME / HOME actions.
- [x] **Task 7: Game Screen Integration & Route Wiring**
  - Created `lib/features/game/presentation/game_screen.dart`.
  - Wired `/classic` in `lib/app/router/app_router.dart` to `const GameScreen()`.
- [x] **Task 8: Comprehensive Automated Tests**
  - `test/features/game/board_rendering_test.dart`
  - `test/features/game/game_hud_test.dart`
  - `test/features/game/block_tray_test.dart`
  - `test/features/game/pause_overlay_test.dart`
  - `test/features/game/game_screen_responsive_test.dart`
  - Total tests: 75/75 passing.
- [x] **Task 9: Code Quality Verification**
  - `dart format .`: 0 unformatted files.
  - `flutter analyze`: 0 issues.
  - `flutter test`: 75/75 passed.
  - `flutter build apk --debug`: Built `app-debug.apk` in 77.2s.
- [x] **Task 10: Live Emulator Deployment & Verification**
  - Deployed build to `emulator-5554`.
  - Verified Home -> Classic screen transition.
  - Verified 10x10 board, top HUD, and bottom piece tray.
  - Verified Pause modal overlay activation, Resume, and return to Home.
