import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/router/app_routes.dart';
import '../../core/constants/asset_paths.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radii.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

/// Configuration model defining metadata for a feature placeholder screen.
class FeaturePlaceholderConfig {
  const FeaturePlaceholderConfig({
    required this.title,
    required this.description,
    required this.statusBadge,
    this.iconAsset,
    this.iconData,
    this.accentColor = AppColors.primaryAccent,
  });

  final String title;
  final String description;
  final String statusBadge;
  final String? iconAsset;
  final IconData? iconData;
  final Color accentColor;

  /// Resolves the placeholder configuration for a given route path.
  static FeaturePlaceholderConfig forRoute(String path) {
    switch (path) {
      case AppRoutes.classic:
        return const FeaturePlaceholderConfig(
          title: 'Classic Mode',
          description:
              'The core 10x10 puzzle board, polyomino block generation, and line-clearing mechanics are currently under active development for upcoming game-engine phases.',
          statusBadge: 'Core Gameplay In Development',
          iconAsset: AssetPaths.iconPlay,
          accentColor: AppColors.blockBlue,
        );
      case AppRoutes.levels:
        return const FeaturePlaceholderConfig(
          title: 'Levels & Progression',
          description:
              'Curated handcrafted puzzle stages, target objectives, and progression maps are scheduled for development in the progression phase.',
          statusBadge: 'Coming in Progression Phase',
          iconAsset: AssetPaths.iconMedal,
          accentColor: AppColors.blockPurple,
        );
      case AppRoutes.timeAttack:
        return const FeaturePlaceholderConfig(
          title: 'Time Attack',
          description:
              'Fast-paced arcade action with a countdown clock and dynamic time bonus rewards will be integrated in future game mode updates.',
          statusBadge: 'Coming Soon',
          iconData: Icons.timer_rounded,
          accentColor: AppColors.blockOrange,
        );
      case AppRoutes.dailyChallenge:
        return const FeaturePlaceholderConfig(
          title: 'Daily Challenge',
          description:
              'Unique daily calendar puzzle seeds with special streak rewards will arrive once persistent calendar mechanics are established.',
          statusBadge: 'Coming Soon',
          iconData: Icons.calendar_today_rounded,
          accentColor: AppColors.blockGreen,
        );
      case AppRoutes.zen:
        return const FeaturePlaceholderConfig(
          title: 'Zen Mode',
          description:
              'A relaxed, pressure-free puzzle experience without timer constraints or score tracking will be available in future releases.',
          statusBadge: 'Relaxed Mode In Planning',
          iconData: Icons.spa_rounded,
          accentColor: AppColors.blockCyan,
        );
      case AppRoutes.statistics:
        return const FeaturePlaceholderConfig(
          title: 'Player Statistics',
          description:
              'Comprehensive gameplay metrics, high score tracking, line clear counts, and combo history will be unlocked alongside local persistence.',
          statusBadge: 'Requires Persistence Engine',
          iconAsset: AssetPaths.iconStatistics,
          accentColor: AppColors.blockYellow,
        );
      case AppRoutes.themes:
        return const FeaturePlaceholderConfig(
          title: 'Themes & Visuals',
          description:
              'Alternative board palettes, vibrant block texture skins, and custom effects will become customizable in the personalization phase.',
          statusBadge: 'Personalization In Development',
          iconData: Icons.palette_rounded,
          accentColor: AppColors.blockPink,
        );
      case AppRoutes.achievements:
        return const FeaturePlaceholderConfig(
          title: 'Achievements',
          description:
              'Milestones, combo mastery badges, and trophy collections will be activated once achievement tracking is implemented.',
          statusBadge: 'Milestones In Planning',
          iconAsset: AssetPaths.iconTrophy,
          accentColor: AppColors.blockOrange,
        );
      case AppRoutes.settings:
        return const FeaturePlaceholderConfig(
          title: 'Settings',
          description:
              'Audio sliders, haptic feedback toggles, theme options, and app information will be fully configured in the dedicated settings phase.',
          statusBadge: 'Settings Hub In Development',
          iconAsset: AssetPaths.iconSettings,
          accentColor: AppColors.textSecondary,
        );
      default:
        return FeaturePlaceholderConfig(
          title: 'Feature In Progress',
          description:
              'This screen is reserved for upcoming functionality in the Block Puzzle roadmap.',
          statusBadge: 'In Development',
          iconData: Icons.construction_rounded,
          accentColor: AppColors.primaryAccent,
        );
    }
  }
}

/// Reusable temporary destination screen for routes under active development.
class FeaturePlaceholderScreen extends StatelessWidget {
  const FeaturePlaceholderScreen({super.key, required this.config});

  /// Factory constructor resolving configuration from route path.
  factory FeaturePlaceholderScreen.fromRoute(String routePath) {
    return FeaturePlaceholderScreen(
      config: FeaturePlaceholderConfig.forRoute(routePath),
    );
  }

  final FeaturePlaceholderConfig config;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Semantics(
          label: 'Navigate Back to Home',
          button: true,
          child: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            color: AppColors.textPrimary,
            tooltip: 'Back to Home',
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go(AppRoutes.home);
              }
            },
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon container with soft glow
                  Container(
                    width: 88,
                    height: 88,
                    decoration: BoxDecoration(
                      color: config.accentColor.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: config.accentColor.withValues(alpha: 0.4),
                        width: 2,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: _buildIcon(),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Status badge pill
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.xs + 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.elevatedSurface,
                      borderRadius: AppRadii.borderPill,
                      border: Border.all(
                        color: config.accentColor.withValues(alpha: 0.5),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      config.statusBadge.toUpperCase(),
                      style: TextStyle(
                        fontFamily: AppTypography.fontNunito,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.0,
                        color: config.accentColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Feature Title
                  Text(
                    config.title,
                    textAlign: TextAlign.center,
                    style: AppTypography.displayMedium.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Honest descriptive copy
                  Text(
                    config.description,
                    textAlign: TextAlign.center,
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),

                  // Back to Home Button
                  Semantics(
                    button: true,
                    label: 'Return to Home Screen',
                    child: SizedBox(
                      height: AppRadii.minTouchTarget,
                      child: FilledButton.icon(
                        style: FilledButton.styleFrom(
                          backgroundColor: config.accentColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: AppRadii.borderMedium,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.xl,
                          ),
                        ),
                        onPressed: () {
                          if (context.canPop()) {
                            context.pop();
                          } else {
                            context.go(AppRoutes.home);
                          }
                        },
                        icon: const Icon(Icons.home_rounded, size: 20),
                        label: const Text(
                          'Back to Home',
                          style: TextStyle(
                            fontFamily: AppTypography.fontFredoka,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
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

  Widget _buildIcon() {
    if (config.iconAsset != null) {
      return Image.asset(
        config.iconAsset!,
        width: 44,
        height: 44,
        fit: BoxFit.contain,
        color: config.accentColor,
      );
    }
    return Icon(
      config.iconData ?? Icons.extension_rounded,
      size: 44,
      color: config.accentColor,
    );
  }
}
