import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_routes.dart';
import '../../../core/constants/asset_paths.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radii.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

/// Distinctive game hero card encouraging the player to jump into Classic mode.
class HomeHeroCard extends StatelessWidget {
  const HomeHeroCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.elevatedSurface, AppColors.secondaryBackground],
        ),
        borderRadius: AppRadii.borderLarge,
        border: Border.all(
          color: AppColors.primaryAccent.withValues(alpha: 0.35),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryAccent.withValues(alpha: 0.12),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative background geometric motif (top-right)
          Positioned(
            right: -10,
            top: -10,
            child: Opacity(opacity: 0.08, child: _buildDecorativeBlockMatrix()),
          ),

          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top subtitle label
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryAccent,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        'READY FOR A CHALLENGE?',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: AppTypography.fontNunito,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.2,
                          color: AppColors.primaryAccent,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.smMd),

                // Main Title & Mini Illustration Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'MAKE YOUR\nNEXT MOVE\nCOUNT',
                          style: AppTypography.displayMedium.copyWith(
                            height: 1.15,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    _buildHeroGeometricBlocks(),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),

                // Supporting Text
                Text(
                  'Place colorful blocks, clear lines and challenge your mind.',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),

                // Primary CTA: PLAY CLASSIC (Min 48dp target)
                Semantics(
                  button: true,
                  label: 'Play Classic Mode',
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryAccent,
                        foregroundColor: Colors.white,
                        elevation: 4,
                        shadowColor: AppColors.primaryAccent.withValues(
                          alpha: 0.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: AppRadii.borderMedium,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.lg,
                        ),
                      ),
                      onPressed: () => context.push(AppRoutes.classic),
                      icon: Image.asset(
                        AssetPaths.iconPlay,
                        width: 20,
                        height: 20,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'PLAY CLASSIC',
                        style: TextStyle(
                          fontFamily: AppTypography.fontFredoka,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Compact colorful polyomino blocks illustration for the hero card.
  Widget _buildHeroGeometricBlocks() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.boardSurface,
        borderRadius: AppRadii.borderMedium,
        border: Border.all(
          color: AppColors.emptyCellBorder.withValues(alpha: 0.6),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildMiniBlock(AppColors.blockBlue),
              const SizedBox(width: 3),
              _buildMiniBlock(AppColors.blockCyan),
            ],
          ),
          const SizedBox(height: 3),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildMiniBlock(AppColors.blockPurple),
              const SizedBox(width: 3),
              _buildMiniBlock(AppColors.blockOrange),
            ],
          ),
          const SizedBox(height: 3),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildMiniBlock(AppColors.blockGreen),
              const SizedBox(width: 3),
              _buildMiniBlock(AppColors.blockPink),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiniBlock(Color color) {
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.3),
          width: 0.8,
        ),
      ),
    );
  }

  Widget _buildDecorativeBlockMatrix() {
    return SizedBox(
      width: 140,
      height: 140,
      child: GridView.count(
        crossAxisCount: 4,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
          16,
          (i) => Container(
            margin: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ),
    );
  }
}
