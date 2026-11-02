import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_routes.dart';
import '../../../core/constants/asset_paths.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radii.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../splash/widgets/puzzle_logo_mark.dart';

/// Top game header presenting branding and a quick settings action.
class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          // Left: Puzzle Logo Symbol + Brand Text
          const PuzzleLogoMark(size: 38),
          const SizedBox(width: AppSpacing.smMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'BLOCK PUZZLE',
                  style: AppTypography.headlineLarge.copyWith(
                    letterSpacing: 0.8,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  'ARCADE EDITION',
                  style: TextStyle(
                    fontFamily: AppTypography.fontNunito,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),

          // Right: Accessible Settings Action (Min 48x48dp)
          Semantics(
            button: true,
            label: 'Open Settings',
            child: Container(
              constraints: AppRadii.touchTargetConstraints,
              decoration: BoxDecoration(
                color: AppColors.elevatedSurface,
                borderRadius: AppRadii.borderMedium,
                border: Border.all(
                  color: AppColors.emptyCellBorder.withValues(alpha: 0.5),
                  width: 1,
                ),
              ),
              child: IconButton(
                iconSize: 22,
                tooltip: 'Settings',
                icon: Image.asset(
                  AssetPaths.iconSettings,
                  width: 22,
                  height: 22,
                  color: AppColors.textPrimary,
                ),
                onPressed: () => context.push(AppRoutes.settings),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
