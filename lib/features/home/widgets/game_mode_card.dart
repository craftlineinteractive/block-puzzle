import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radii.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

/// Interactive game mode selection card.
class GameModeCard extends StatelessWidget {
  const GameModeCard({
    super.key,
    required this.title,
    required this.description,
    required this.accentColor,
    required this.onTap,
    this.iconAsset,
    this.iconData,
    this.badgeText,
    this.isFeatured = false,
  });

  final String title;
  final String description;
  final Color accentColor;
  final VoidCallback onTap;
  final String? iconAsset;
  final IconData? iconData;
  final String? badgeText;
  final bool isFeatured;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: '$title Game Mode: $description',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppRadii.borderLarge,
          splashColor: accentColor.withValues(alpha: 0.15),
          highlightColor: accentColor.withValues(alpha: 0.08),
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: isFeatured
                  ? AppColors.elevatedSurface
                  : AppColors.secondaryBackground,
              borderRadius: AppRadii.borderLarge,
              border: Border.all(
                color: isFeatured
                    ? accentColor.withValues(alpha: 0.45)
                    : AppColors.emptyCellBorder.withValues(alpha: 0.5),
                width: isFeatured ? 1.5 : 1.0,
              ),
              boxShadow: [
                if (isFeatured)
                  BoxShadow(
                    color: accentColor.withValues(alpha: 0.12),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
              ],
            ),
            child: isFeatured ? _buildFeaturedLayout() : _buildStandardLayout(),
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedLayout() {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: accentColor.withValues(alpha: 0.15),
            borderRadius: AppRadii.borderMedium,
            border: Border.all(
              color: accentColor.withValues(alpha: 0.35),
              width: 1.0,
            ),
          ),
          alignment: Alignment.center,
          child: _buildIcon(),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      title,
                      style: AppTypography.titleLarge.copyWith(
                        letterSpacing: 0.5,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  if (badgeText != null) ...[
                    const SizedBox(width: AppSpacing.sm),
                    _buildBadge(),
                  ],
                ],
              ),
              const SizedBox(height: 4),
              Text(
                description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.25,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Icon(
          Icons.arrow_forward_ios_rounded,
          size: 16,
          color: accentColor.withValues(alpha: 0.7),
        ),
      ],
    );
  }

  Widget _buildStandardLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: accentColor.withValues(alpha: 0.15),
                borderRadius: AppRadii.borderMedium,
                border: Border.all(
                  color: accentColor.withValues(alpha: 0.35),
                  width: 1.0,
                ),
              ),
              alignment: Alignment.center,
              child: _buildIcon(),
            ),
            if (badgeText != null) Flexible(child: _buildBadge()),
          ],
        ),
        const SizedBox(height: AppSpacing.smMd),
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.titleMedium.copyWith(
            letterSpacing: 0.5,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.bodySmall.copyWith(
            fontSize: 11,
            color: AppColors.textSecondary,
            height: 1.2,
          ),
        ),
      ],
    );
  }

  Widget _buildBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: 0.18),
        borderRadius: AppRadii.borderPill,
        border: Border.all(color: accentColor.withValues(alpha: 0.4)),
      ),
      child: Text(
        badgeText!,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontFamily: AppTypography.fontNunito,
          fontSize: 9,
          fontWeight: FontWeight.w700,
          color: accentColor,
        ),
      ),
    );
  }

  Widget _buildIcon() {
    if (iconAsset != null) {
      return Image.asset(
        iconAsset!,
        width: 22,
        height: 22,
        fit: BoxFit.contain,
        color: accentColor,
      );
    }
    return Icon(
      iconData ?? Icons.grid_view_rounded,
      size: 22,
      color: accentColor,
    );
  }
}
