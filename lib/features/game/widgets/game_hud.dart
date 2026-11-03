import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import 'score_display.dart';

/// Top game HUD containing the pause action, live score, and best score.
///
/// Designed with balanced triple-slot symmetry to ensure the main score
/// remains strictly centered across all screen widths.
class GameHUD extends StatelessWidget {
  const GameHUD({
    required this.score,
    required this.onPause,
    super.key,
    this.bestScore,
  });

  /// Current session score.
  final int score;

  /// High score / best score (null if no previous record).
  final int? bestScore;

  /// Invoked when the pause button is tapped.
  final VoidCallback onPause;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left: Pause Control (Strict >= 48x48dp touch target)
          Container(
            width: 72.0,
            alignment: Alignment.centerLeft,
            child: Tooltip(
              message: 'Pause game',
              child: SizedBox(
                width: AppRadii.minTouchTarget,
                height: AppRadii.minTouchTarget,
                child: Material(
                  color: AppColors.elevatedSurface,
                  shape: const RoundedRectangleBorder(
                    borderRadius: AppRadii.borderMedium,
                    side: BorderSide(
                      color: AppColors.emptyCellBorder,
                      width: 1.0,
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: onPause,
                    child: const Center(
                      child: Icon(
                        Icons.pause_rounded,
                        color: AppColors.textPrimary,
                        size: 24.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Center: Primary Score Display
          Expanded(
            child: Center(child: ScoreDisplay(score: score)),
          ),

          // Right: Best Score Indicator (Balanced with left pause slot)
          Container(
            width: 72.0,
            alignment: Alignment.centerRight,
            child: Semantics(
              label: 'Best score: ${bestScore ?? "none"}',
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.emoji_events_rounded,
                          size: 14.0,
                          color: AppColors.blockYellow,
                        ),
                        const SizedBox(width: 3.0),
                        Text(
                          'BEST',
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.textTertiary,
                            letterSpacing: 1.2,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      bestScore != null ? bestScore.toString() : '—',
                      style: AppTypography.titleMedium.copyWith(
                        fontFamily: AppTypography.fontFredoka,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
