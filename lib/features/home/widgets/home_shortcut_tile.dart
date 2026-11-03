import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_routes.dart';
import '../../../core/constants/asset_paths.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radii.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

/// Single interactive shortcut tile for secondary game hubs.
class HomeShortcutTile extends StatelessWidget {
  const HomeShortcutTile({
    super.key,
    required this.label,
    required this.onTap,
    this.iconAsset,
    this.iconData,
  });

  final String label;
  final VoidCallback onTap;
  final String? iconAsset;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Open $label Hub',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppRadii.borderMedium,
          child: Container(
            constraints: const BoxConstraints(minHeight: 48),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xs + 2,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: AppColors.secondaryBackground,
              borderRadius: AppRadii.borderMedium,
              border: Border.all(
                color: AppColors.emptyCellBorder.withValues(alpha: 0.5),
                width: 1.0,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildIcon(),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: AppTypography.fontNunito,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    if (iconAsset != null) {
      return Image.asset(
        iconAsset!,
        width: 18,
        height: 18,
        fit: BoxFit.contain,
        color: AppColors.textSecondary,
      );
    }
    return Icon(
      iconData ?? Icons.widgets_rounded,
      size: 18,
      color: AppColors.textSecondary,
    );
  }
}

/// Secondary shortcuts bar organizing quick navigation to Statistics, Themes, and Achievements.
class HomeShortcutsBar extends StatelessWidget {
  const HomeShortcutsBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'QUICK HUBS',
            style: TextStyle(
              fontFamily: AppTypography.fontNunito,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.5,
              color: AppColors.textTertiary,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: HomeShortcutTile(
                  label: 'Stats',
                  iconAsset: AssetPaths.iconStatistics,
                  onTap: () => context.push(AppRoutes.statistics),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: HomeShortcutTile(
                  label: 'Themes',
                  iconData: Icons.palette_outlined,
                  onTap: () => context.push(AppRoutes.themes),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: HomeShortcutTile(
                  label: 'Trophies',
                  iconAsset: AssetPaths.iconTrophy,
                  onTap: () => context.push(AppRoutes.achievements),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
