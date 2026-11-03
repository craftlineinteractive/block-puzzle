import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../presentation/models/game_screen_preview_data.dart';
import 'preview_block_widget.dart';

/// Bottom piece preview tray displaying the next available playable blocks.
///
/// Features a stylized arcade header ("YOUR NEXT BLOCKS") and three
/// translucent elevated staging slots.
class BlockTrayPreview extends StatelessWidget {
  const BlockTrayPreview({
    required this.pieces,
    super.key,
    this.slotHeight = 84.0,
  });

  /// The list of preview pieces (typically 3 pieces).
  final List<PreviewPiece> pieces;

  /// Height allocated for each preview slot.
  final double slotHeight;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Piece preview tray',
      container: true,
      explicitChildNodes: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Tray Header
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 24.0,
                height: 1.0,
                color: AppColors.emptyCellBorder,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'YOUR NEXT BLOCKS',
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.textTertiary,
                  letterSpacing: 1.6,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Container(
                width: 24.0,
                height: 1.0,
                color: AppColors.emptyCellBorder,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),

          // Three Preview Slots
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < 3; i++) ...[
                if (i > 0) const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Container(
                    height: slotHeight,
                    decoration: BoxDecoration(
                      color: AppColors.boardSurface.withValues(alpha: 0.65),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(AppRadii.large),
                      ),
                      border: Border.all(
                        color: AppColors.emptyCellBorder.withValues(
                          alpha: 0.75,
                        ),
                        width: 1.0,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 8.0,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: i < pieces.length
                          ? PreviewBlockWidget(piece: pieces[i])
                          : const SizedBox.shrink(),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
