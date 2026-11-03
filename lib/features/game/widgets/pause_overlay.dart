import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

/// Immersive arcade pause modal overlay.
///
/// Dimmed translucent background with a centered arcade panel featuring
/// high-contrast RESUME and HOME actions with compliant 48dp touch targets.
class PauseOverlay extends StatelessWidget {
  const PauseOverlay({required this.onResume, required this.onHome, super.key});

  /// Invoked when the user chooses to continue playing.
  final VoidCallback onResume;

  /// Invoked when the user chooses to return to the home screen.
  final VoidCallback onHome;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      namesRoute: true,
      scopesRoute: true,
      explicitChildNodes: true,
      label: 'Game paused dialog',
      child: Material(
        color: Colors.black.withValues(alpha: 0.78),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 340.0),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: AppColors.elevatedSurface,
                borderRadius: const BorderRadius.all(
                  Radius.circular(AppRadii.extraLarge),
                ),
                border: Border.all(
                  color: AppColors.emptyCellBorder,
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.6),
                    blurRadius: 24.0,
                    offset: const Offset(0, 10),
                  ),
                  BoxShadow(
                    color: AppColors.primaryAccent.withValues(alpha: 0.18),
                    blurRadius: 32.0,
                    spreadRadius: 2.0,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Top Pause Icon Badge
                  Center(
                    child: Container(
                      width: 56.0,
                      height: 56.0,
                      decoration: BoxDecoration(
                        color: AppColors.boardSurface,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.primaryAccent.withValues(alpha: 0.4),
                          width: 1.5,
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.pause_rounded,
                          color: AppColors.primaryAccent,
                          size: 32.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Pause Title
                  Center(
                    child: Text(
                      'GAME PAUSED',
                      textAlign: TextAlign.center,
                      style: AppTypography.displaySmall.copyWith(
                        letterSpacing: 0.5,
                        shadows: [
                          Shadow(
                            color: AppColors.primaryAccent.withValues(
                              alpha: 0.4,
                            ),
                            blurRadius: 12.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Center(
                    child: Text(
                      'Take a breath. Your board is waiting.',
                      textAlign: TextAlign.center,
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Resume Action Button (Primary CTA)
                  SizedBox(
                    height: AppRadii.minTouchTarget,
                    child: ElevatedButton(
                      onPressed: onResume,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryAccent,
                        foregroundColor: Colors.white,
                        elevation: 4.0,
                        shadowColor: AppColors.primaryAccent.withValues(
                          alpha: 0.5,
                        ),
                        shape: const RoundedRectangleBorder(
                          borderRadius: AppRadii.borderMedium,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.play_arrow_rounded, size: 22.0),
                          const SizedBox(width: AppSpacing.xs),
                          Text(
                            'RESUME',
                            style: AppTypography.buttonLarge.copyWith(
                              fontSize: 16.0,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),

                  // Home Action Button (Secondary Action)
                  SizedBox(
                    height: AppRadii.minTouchTarget,
                    child: OutlinedButton(
                      onPressed: onHome,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.textPrimary,
                        side: const BorderSide(
                          color: AppColors.emptyCellBorder,
                          width: 1.5,
                        ),
                        shape: const RoundedRectangleBorder(
                          borderRadius: AppRadii.borderMedium,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.home_rounded, size: 20.0),
                          const SizedBox(width: AppSpacing.xs),
                          Text(
                            'HOME',
                            style: AppTypography.buttonLarge.copyWith(
                              fontSize: 15.0,
                              letterSpacing: 0.8,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
