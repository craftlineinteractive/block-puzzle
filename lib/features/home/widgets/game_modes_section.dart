import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_routes.dart';
import '../../../core/constants/asset_paths.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import 'game_mode_card.dart';

/// Section showcasing all 5 Block Puzzle game modes with responsive intrinsic layout.
class GameModesSection extends StatelessWidget {
  const GameModesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Text(
            'GAME MODES',
            style: AppTypography.headlineMedium.copyWith(
              letterSpacing: 1.0,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // 1. Featured Classic Mode (Wide Horizontal Card)
          GameModeCard(
            title: 'CLASSIC',
            description:
                'Endless puzzle gameplay. Clear lines, build combos, and achieve your personal best.',
            accentColor: AppColors.blockBlue,
            iconAsset: AssetPaths.iconPlay,
            badgeText: 'PRIMARY',
            isFeatured: true,
            onTap: () => context.push(AppRoutes.classic),
          ),
          const SizedBox(height: AppSpacing.md),

          // 2. Secondary Modes Row 1: Levels & Time Attack
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: GameModeCard(
                    title: 'LEVELS',
                    description: 'Stage objectives and handcrafted puzzles.',
                    accentColor: AppColors.blockPurple,
                    iconAsset: AssetPaths.iconMedal,
                    badgeText: 'STAGES',
                    onTap: () => context.push(AppRoutes.levels),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: GameModeCard(
                    title: 'TIME ATTACK',
                    description: 'Race against the clock for quick clears.',
                    accentColor: AppColors.blockOrange,
                    iconData: Icons.timer_rounded,
                    badgeText: 'TIMED',
                    onTap: () => context.push(AppRoutes.timeAttack),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // 3. Secondary Modes Row 2: Daily Challenge & Zen Mode
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: GameModeCard(
                    title: 'DAILY',
                    description: 'New daily puzzle seed every 24 hours.',
                    accentColor: AppColors.blockGreen,
                    iconData: Icons.calendar_today_rounded,
                    badgeText: 'CHALLENGE',
                    onTap: () => context.push(AppRoutes.dailyChallenge),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: GameModeCard(
                    title: 'ZEN MODE',
                    description: 'Calm, timer-free peaceful block puzzle.',
                    accentColor: AppColors.blockCyan,
                    iconData: Icons.spa_rounded,
                    badgeText: 'RELAX',
                    onTap: () => context.push(AppRoutes.zen),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
