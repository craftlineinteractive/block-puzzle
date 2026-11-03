import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_spacing.dart';
import 'block_tile_painter.dart';

/// Highly optimized custom painter that renders the 10x10 puzzle board grid.
///
/// Paints:
/// 1. Outer arcade board frame with double-bordered bevel and subtle inner shadow.
/// 2. Exactly 100 cells (10 rows x 10 columns) with uniform pixel-perfect gaps.
/// 3. Empty cells with subtle inset shading.
/// 4. Occupied cells with glossy arcade-styled specular gradients.
class BoardPainter extends CustomPainter {
  const BoardPainter({
    required this.grid,
    this.gap = 3.0,
    this.cellRadius = 4.0,
    this.outerPadding = AppSpacing.sm,
  });

  /// 10x10 matrix of cell colors (null if empty).
  final List<List<Color?>> grid;

  /// Gap between adjacent cells in logical pixels.
  final double gap;

  /// Corner radius of individual block tiles.
  final double cellRadius;

  /// Inner padding between the outer board frame and the 10x10 cell grid.
  final double outerPadding;

  static const int rows = 10;
  static const int cols = 10;
  static const int totalCells = rows * cols;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;

    final side = size.shortestSide;
    final boardRect = Rect.fromLTWH(0, 0, side, side);
    final boardRRect = RRect.fromRectAndRadius(
      boardRect,
      const Radius.circular(AppRadii.large),
    );

    // 1. Draw Board Outer Container Background
    final framePaint = Paint()
      ..color = AppColors.boardSurface
      ..isAntiAlias = true;
    canvas.drawRRect(boardRRect, framePaint);

    // 2. Draw Frame Inset Shadow (Subtle arcade bevel depth)
    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..isAntiAlias = true;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(1, 1, side - 2, side - 2),
        const Radius.circular(AppRadii.large - 1),
      ),
      shadowPaint,
    );

    // 3. Draw Outer Frame Border
    final borderPaint = Paint()
      ..color = AppColors.emptyCellBorder
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..isAntiAlias = true;
    canvas.drawRRect(boardRRect, borderPaint);

    // 4. Calculate 10x10 Grid Metrics
    final gridAvailableWidth = side - (outerPadding * 2);
    final totalGaps = (cols - 1) * gap;
    final cellSize = (gridAvailableWidth - totalGaps) / cols;

    final startX = outerPadding;
    final startY = outerPadding;

    // 5. Draw Exactly 100 Grid Cells (10x10)
    for (int r = 0; r < rows; r++) {
      final y = startY + r * (cellSize + gap);
      final rowColors = r < grid.length ? grid[r] : null;

      for (int c = 0; c < cols; c++) {
        final x = startX + c * (cellSize + gap);
        final cellRect = Rect.fromLTWH(x, y, cellSize, cellSize);

        final cellColor = (rowColors != null && c < rowColors.length)
            ? rowColors[c]
            : null;

        if (cellColor != null) {
          BlockTilePainter.paintTile(
            canvas,
            cellRect,
            cellColor,
            radius: cellRadius,
          );
        } else {
          BlockTilePainter.paintEmptyCell(canvas, cellRect, radius: cellRadius);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant BoardPainter oldDelegate) {
    if (oldDelegate.gap != gap ||
        oldDelegate.cellRadius != cellRadius ||
        oldDelegate.outerPadding != outerPadding) {
      return true;
    }

    if (identical(oldDelegate.grid, grid)) {
      return false;
    }

    if (oldDelegate.grid.length != grid.length) {
      return true;
    }

    for (int r = 0; r < grid.length; r++) {
      final oldRow = oldDelegate.grid[r];
      final newRow = grid[r];
      if (oldRow.length != newRow.length) return true;
      for (int c = 0; c < newRow.length; c++) {
        if (oldRow[c] != newRow[c]) return true;
      }
    }

    return false;
  }
}
