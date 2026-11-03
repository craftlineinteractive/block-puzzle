import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../widgets/block_tray_preview.dart';
import '../widgets/board_widget.dart';
import '../widgets/game_hud.dart';
import '../widgets/pause_overlay.dart';
import 'models/game_screen_preview_data.dart';

/// Immersive, arcade-styled gameplay screen for Classic Block Puzzle mode.
///
/// Composes:
/// 1. Top HUD with Pause trigger, tabular score, and best score.
/// 2. Responsive 10x10 CustomPainter puzzle board with glossy tiles.
/// 3. Bottom tray preview ("YOUR NEXT BLOCKS") with three upcoming pieces.
/// 4. Modal pause overlay with resume and home actions.
class GameScreen extends StatefulWidget {
  const GameScreen({super.key, this.previewData});

  /// Optional preview data override for testing and visual previews.
  /// Defaults to [GameScreenPreviewData.samplePreview] in Phase 04.
  final GameScreenPreviewData? previewData;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late GameScreenPreviewData _data;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    _data = widget.previewData ?? GameScreenPreviewData.samplePreview();
  }

  @override
  void didUpdateWidget(covariant GameScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.previewData != oldWidget.previewData &&
        widget.previewData != null) {
      _data = widget.previewData!;
    }
  }

  void _handlePause() {
    setState(() => _isPaused = true);
  }

  void _handleResume() {
    setState(() => _isPaused = false);
  }

  void _handleHome() {
    setState(() => _isPaused = false);
    context.go(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_isPaused,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop && _isPaused) {
          _handleResume();
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(
          children: [
            // 1. Subtle Radial Arcade Ambient Lighting
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: const Alignment(0.0, -0.2),
                    radius: 0.95,
                    colors: [
                      AppColors.primaryAccent.withValues(alpha: 0.09),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: 240.0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: const Alignment(0.0, 1.0),
                    radius: 1.0,
                    colors: [
                      AppColors.secondaryAccent.withValues(alpha: 0.05),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // 2. Primary Gameplay Interface
            SafeArea(
              child: Column(
                children: [
                  // Top Arcade HUD
                  GameHUD(
                    score: _data.score,
                    bestScore: _data.bestScore,
                    onPause: _handlePause,
                  ),

                  // Center 10x10 Game Board (Responsive, zero-overflow)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.xs,
                      ),
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: SizedBox(
                            width: 360.0,
                            height: 360.0,
                            child: BoardWidget(grid: _data.grid),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Bottom Next Blocks Preview Tray
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.md,
                      0,
                      AppSpacing.md,
                      AppSpacing.md,
                    ),
                    child: BlockTrayPreview(pieces: _data.previewPieces),
                  ),
                ],
              ),
            ),

            // 3. Pause Modal Overlay
            if (_isPaused)
              Positioned.fill(
                child: PauseOverlay(
                  onResume: _handleResume,
                  onHome: _handleHome,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
