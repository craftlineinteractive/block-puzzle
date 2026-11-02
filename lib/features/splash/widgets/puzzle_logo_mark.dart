import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// Distinctive geometric polyomino logo mark for Block Puzzle.
///
/// Composes an arrangement of colorful rounded arcade tiles representing
/// interlocking puzzle blocks.
class PuzzleLogoMark extends StatelessWidget {
  const PuzzleLogoMark({super.key, this.size = 96.0});

  /// Overall bounding square dimension of the logo mark.
  final double size;

  @override
  Widget build(BuildContext context) {
    // 3x3 grid composed of polyomino block clusters
    final tileSize = (size - 8) / 3;

    return Semantics(
      label: 'Block Puzzle Logo Symbol',
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Ambient soft glow behind logo
            Container(
              width: size * 0.9,
              height: size * 0.9,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryAccent.withValues(alpha: 0.35),
                    blurRadius: size * 0.4,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),

            // Interlocking tiles
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTile(tileSize, AppColors.blockBlue),
                    const SizedBox(width: 4),
                    _buildTile(tileSize, AppColors.blockOrange),
                    const SizedBox(width: 4),
                    _buildTile(tileSize, AppColors.blockOrange),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTile(tileSize, AppColors.blockBlue),
                    const SizedBox(width: 4),
                    _buildTile(tileSize, AppColors.blockPurple),
                    const SizedBox(width: 4),
                    _buildTile(tileSize, AppColors.blockGreen),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTile(tileSize, AppColors.blockPink),
                    const SizedBox(width: 4),
                    _buildTile(tileSize, AppColors.blockPurple),
                    const SizedBox(width: 4),
                    _buildTile(tileSize, AppColors.blockGreen),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTile(double tileSize, Color color) {
    return Container(
      width: tileSize,
      height: tileSize,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(tileSize * 0.22),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.35),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.4),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );
  }
}
