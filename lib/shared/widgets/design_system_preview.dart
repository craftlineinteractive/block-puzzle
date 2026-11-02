import 'package:flutter/material.dart';

import '../../core/constants/asset_paths.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radii.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

/// Development and verification component showcasing the Block Puzzle Design System.
///
/// Intended strictly for design verification, testing, and developer previews.
class DesignSystemPreview extends StatelessWidget {
  const DesignSystemPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Design System Preview')),
      body: SingleChildScrollView(
        padding: AppSpacing.paddingMd,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('1. Color Palette & Surfaces'),
            _buildSurfaceShowcase(),
            const SizedBox(height: AppSpacing.lg),

            _buildSectionHeader('2. Polyomino Block Colors'),
            _buildBlockColorGrid(),
            const SizedBox(height: AppSpacing.lg),

            _buildSectionHeader('3. Typography Hierarchy'),
            _buildTypographyShowcase(),
            const SizedBox(height: AppSpacing.lg),

            _buildSectionHeader('4. Buttons & Interactive Targets (Min 48px)'),
            _buildButtonShowcase(),
            const SizedBox(height: AppSpacing.lg),

            _buildSectionHeader('5. Corner Radii & Panels'),
            _buildRadiiShowcase(),
            const SizedBox(height: AppSpacing.lg),

            _buildSectionHeader('6. Imported Game Icons'),
            _buildIconShowcase(),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Text(
        title,
        style: AppTypography.headlineMedium.copyWith(
          color: AppColors.primaryAccent,
        ),
      ),
    );
  }

  Widget _buildSurfaceShowcase() {
    final surfaces = [
      ('Background', AppColors.background),
      ('Secondary Surface', AppColors.secondaryBackground),
      ('Elevated Surface', AppColors.elevatedSurface),
      ('Board Surface', AppColors.boardSurface),
      ('Empty Cell', AppColors.emptyCell),
    ];

    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: surfaces.map((item) {
        return Container(
          width: 140,
          padding: AppSpacing.paddingSm,
          decoration: BoxDecoration(
            color: item.$2,
            borderRadius: AppRadii.borderMedium,
            border: Border.all(color: AppColors.emptyCellBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.$1,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                '#${item.$2.toARGB32().toRadixString(16).substring(2).toUpperCase()}',
                style: AppTypography.labelSmall,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildBlockColorGrid() {
    final blocks = [
      ('Blue', AppColors.blockBlue),
      ('Purple', AppColors.blockPurple),
      ('Orange', AppColors.blockOrange),
      ('Green', AppColors.blockGreen),
      ('Pink', AppColors.blockPink),
      ('Red', AppColors.blockRed),
      ('Yellow', AppColors.blockYellow),
      ('Cyan', AppColors.blockCyan),
    ];

    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: blocks.map((b) {
        return Container(
          width: 76,
          height: 76,
          decoration: BoxDecoration(
            color: b.$2,
            borderRadius: AppRadii.borderMedium,
            boxShadow: [
              BoxShadow(
                color: b.$2.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            b.$1,
            style: AppTypography.buttonMedium.copyWith(
              color: b.$1 == 'Yellow' ? Colors.black87 : Colors.white,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTypographyShowcase() {
    return Container(
      padding: AppSpacing.paddingMd,
      decoration: const BoxDecoration(
        color: AppColors.secondaryBackground,
        borderRadius: AppRadii.borderLarge,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Score: 12,480', style: AppTypography.scoreDisplay),
          const SizedBox(height: AppSpacing.sm),
          const Text(
            'Display Large (Fredoka)',
            style: AppTypography.displayLarge,
          ),
          const SizedBox(height: AppSpacing.xs),
          const Text(
            'Display Medium (Fredoka)',
            style: AppTypography.displayMedium,
          ),
          const SizedBox(height: AppSpacing.xs),
          const Text(
            'Headline Large (Fredoka)',
            style: AppTypography.headlineLarge,
          ),
          const Divider(
            color: AppColors.emptyCellBorder,
            height: AppSpacing.lg,
          ),
          const Text(
            'Title Large (Nunito Bold)',
            style: AppTypography.titleLarge,
          ),
          const SizedBox(height: AppSpacing.xs),
          const Text(
            'Body Large: High-contrast descriptive body text for puzzle rules and achievements.',
            style: AppTypography.bodyLarge,
          ),
          const SizedBox(height: AppSpacing.xs),
          const Text(
            'Body Medium: Secondary statistics and settings explanations.',
            style: AppTypography.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildButtonShowcase() {
    return Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.sm,
      children: [
        ElevatedButton(onPressed: () {}, child: const Text('PLAY NOW')),
        OutlinedButton(onPressed: () {}, child: const Text('SETTINGS')),
      ],
    );
  }

  Widget _buildRadiiShowcase() {
    final radii = [
      ('Small (6px)', AppRadii.borderSmall),
      ('Medium (12px)', AppRadii.borderMedium),
      ('Large (16px)', AppRadii.borderLarge),
      ('Pill (999px)', AppRadii.borderPill),
    ];

    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: radii.map((r) {
        return Container(
          width: 76,
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.elevatedSurface,
            borderRadius: r.$2,
            border: Border.all(color: AppColors.emptyCellBorder),
          ),
          alignment: Alignment.center,
          child: Text(
            r.$1,
            style: AppTypography.bodySmall.copyWith(fontSize: 10),
            textAlign: TextAlign.center,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildIconShowcase() {
    final icons = [
      ('Home', AssetPaths.iconHome),
      ('Play', AssetPaths.iconPlay),
      ('Pause', AssetPaths.iconPause),
      ('Settings', AssetPaths.iconSettings),
      ('Sound', AssetPaths.iconSoundOn),
      ('Music', AssetPaths.iconMusicOn),
      ('Trophy', AssetPaths.iconTrophy),
      ('Board', AssetPaths.iconLeaderboard),
      ('Stats', AssetPaths.iconStatistics),
      ('Medal', AssetPaths.iconMedal),
      ('Star', AssetPaths.iconStar),
      ('Shop', AssetPaths.iconShop),
      ('Back', AssetPaths.iconBack),
      ('Restart', AssetPaths.iconRestart),
      ('Check', AssetPaths.iconCheckmark),
      ('Close', AssetPaths.iconClose),
      ('Info', AssetPaths.iconInfo),
      ('Help', AssetPaths.iconHelp),
    ];

    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: icons.map((icon) {
        return Container(
          width: 72,
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          decoration: BoxDecoration(
            color: AppColors.elevatedSurface,
            borderRadius: AppRadii.borderMedium,
            border: Border.all(color: AppColors.emptyCellBorder),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                icon.$2,
                width: 28,
                height: 28,
                color: AppColors.textPrimary,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(icon.$1, style: AppTypography.labelSmall),
            ],
          ),
        );
      }).toList(),
    );
  }
}
