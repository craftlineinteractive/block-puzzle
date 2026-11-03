import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

/// Arcade-styled centralized score display widget.
///
/// Features tabular numerals with the Fredoka display font, subtle neon glow,
/// and uppercase sub-label.
class ScoreDisplay extends StatelessWidget {
  const ScoreDisplay({required this.score, super.key, this.label = 'SCORE'});

  /// The current integer score to display.
  final int score;

  /// Header label text above the score counter.
  final String label;

  @override
  Widget build(BuildContext context) {
    // Format 0 as '0000' for retro-arcade style, or regular formatted integer
    final formattedScore = score == 0 ? '0000' : score.toString();

    return Semantics(
      label: '$label: $score',
      container: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: AppTypography.labelSmall.copyWith(
              color: AppColors.textSecondary,
              letterSpacing: 1.6,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2.0),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              formattedScore,
              style: AppTypography.scoreDisplay.copyWith(
                fontSize: 34.0,
                height: 1.1,
                fontFeatures: const [FontFeature.tabularFigures()],
                shadows: [
                  Shadow(
                    color: AppColors.primaryAccent.withValues(alpha: 0.45),
                    blurRadius: 10.0,
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
