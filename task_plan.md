# Phase 04B: Gameplay Screen Visual Audit, Board Rendering Verification & Debugging Plan

**Goal:** Conduct an exhaustive visual and architectural audit of the newly implemented Phase 04A gameplay screen (`GameScreen`), verifying pixel-perfect 10x10 board geometry, CustomPainter efficiency, arcade aesthetic fidelity, accessibility compliance, responsive stability across device viewports, and deep test coverage.

**Status:** Completed & Live Verified on Emulator (`emulator-5554`)

---

## 1. Audit Dimensions & Objectives

| Dimension | Objectives & Verification Standards | Status |
|-----------|-------------------------------------|--------|
| **1. Code & Architecture** | Complete audit of `GameScreen`, `BoardPainter`, `BlockTilePainter`, `GameHUD`, `ScoreDisplay`, `BlockTrayPreview`, `PreviewBlockWidget`, `PauseOverlay`, and `AppRouter`. Ensure zero regressions in Phase 01–03 features. | Verified |
| **2. Board Geometry** | Verify exactly 10 rows, 10 columns, 100 cells. Uniform cell sizes, equal column widths and row heights. Verify corner cells `(0,0)`, `(0,9)`, `(9,0)`, `(9,9)` and edge boundaries. Strict 1:1 aspect ratio. | Verified |
| **3. CustomPainter Mechanics** | Verify painting coordinates, inner shadow and specular highlight positioning, shader bounds, clipping boundaries, anti-aliasing, and `shouldRepaint` memoization logic. | Verified |
| **4. Visual & Game Aesthetics** | Verify dark arcade atmosphere, subtle ambient glow, tabular Fredoka score numerals, vibrant glossy polyominoes, and clean tray staging. | Verified |
| **5. Responsive Viewports** | Comprehensive testing across 320dp, 360dp, 393dp, 430dp, and tablet viewports. Verify zero `RenderFlex` overflows and proper `SafeArea` insets. | Verified |
| **6. Pause & Navigation Lifecycle** | Verify pause activation, dismissal, home navigation, re-entry fresh state (pause closed on return), and system back-button (`PopScope`) handling. | Verified |
| **7. Accessibility & Touch Targets** | Verify `>= 48×48dp` touch targets, semantic labels for pause and board, high contrast ratios, and text scale resilience. | Verified |
| **8. Automated Test Coverage** | Build comprehensive, non-brittle tests covering `game_screen_test.dart`, `board_widget_test.dart`, `game_hud_test.dart`, `block_tray_preview_test.dart`, and `pause_overlay_test.dart`. | 80/80 Passing |
| **9. Device Validation & Screenshots** | Live emulator validation on `emulator-5554` with full screenshot capture of gameplay, board close-up, block tray, pause modal, and navigation recovery. | Verified |
| **10. Verification Commands** | `flutter pub get`, `dart format .`, `flutter analyze`, `flutter test`, `flutter build apk --debug`. | All Passed |

---

## 2. Step-by-Step Execution Plan

- [x] **Step 1: Code & Implementation Audit**
  - Inspected all gameplay files for clean abstractions, single responsibility, const optimizations, and resource hygiene.
- [x] **Step 2: Board Geometry & Mathematical Validation**
  - Enhanced `BoardPainter` with `offsetX`/`offsetY` canvas centering and `clipRRect` boundary protection.
  - Verified cell calculation formula: `cellSize = (side - 2*outerPadding - (cols-1)*gap) / cols`.
  - Added inner `Center` wrapper in `BoardWidget` to guarantee 1:1 square aspect ratio even when parent passes non-square constraints.
- [x] **Step 3: CustomPainter & Repaint Isolation Audit**
  - Confirmed `shouldRepaint` performs deep structural matrix comparisons to prevent unnecessary repaints.
  - Isolated board repaints from HUD and Tray with `RepaintBoundary`.
- [x] **Step 4: Systematic Refinement & Fixes**
  - Fixed `_handleHome()` to reset `_isPaused = false` so re-entering Classic mode always presents an active board.
  - Resolved `PopScope` test generic type matching in `game_screen_test.dart`.
- [x] **Step 5: Automated Test Suite Expansion**
  - Maintained dedicated, non-brittle test suite:
    - `test/features/game/game_screen_test.dart`
    - `test/features/game/board_widget_test.dart`
    - `test/features/game/game_hud_test.dart`
    - `test/features/game/block_tray_preview_test.dart`
    - `test/features/game/pause_overlay_test.dart`
  - Total test count: 80 passing tests (0 failures).
- [x] **Step 6: Real Device Visual Inspection & Screenshots**
  - Captured on `emulator-5554`:
    1. Full gameplay screen (`phase4b_full_gameplay.png`)
    2. Board close-up (`phase4b_board_closeup.png`)
    3. Block tray (`phase4b_block_tray.png`)
    4. Pause modal overlay (`phase4b_pause_overlay.png`)
    5. Re-entry clean state & Android back-button dismiss (`phase4b_reentry_classic.png`, `phase4b_back_dismiss.png`)
- [x] **Step 7: Verification Commands & Reporting**
  - `flutter pub get`: Dependencies resolved.
  - `dart format .`: 50 files formatted cleanly.
  - `flutter analyze`: 0 issues found.
  - `flutter test`: 80/80 passed.
  - `flutter build apk --debug`: Debug APK built cleanly.
