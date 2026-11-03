import 'package:flutter/material.dart';

import '../presentation/models/game_screen_preview_data.dart';
import '../presentation/painters/block_tile_painter.dart';

/// Renders a single polyomino preview piece using glossy [BlockTilePainter] tiles.
class PreviewBlockWidget extends StatelessWidget {
  const PreviewBlockWidget({
    required this.piece,
    super.key,
    this.maxCellSize = 20.0,
    this.gap = 2.0,
  });

  /// The preview piece data containing shape matrix and color.
  final PreviewPiece piece;

  /// Maximum tile size in logical pixels.
  final double maxCellSize;

  /// Gap between adjacent tiles in the piece.
  final double gap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Preview piece ${piece.id}',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final rows = piece.rows;
          final cols = piece.cols;
          if (rows == 0 || cols == 0) return const SizedBox.shrink();

          // Compute cell size that fits available slot bounds
          final availableWidth = constraints.maxWidth > 0
              ? constraints.maxWidth
              : maxCellSize * 4;
          final availableHeight = constraints.maxHeight > 0
              ? constraints.maxHeight
              : maxCellSize * 4;

          final cellW = (availableWidth - (cols - 1) * gap) / cols;
          final cellH = (availableHeight - (rows - 1) * gap) / rows;
          final cellSize = (cellW < cellH ? cellW : cellH).clamp(
            8.0,
            maxCellSize,
          );

          return CustomPaint(
            size: Size(
              cols * cellSize + (cols - 1) * gap,
              rows * cellSize + (rows - 1) * gap,
            ),
            painter: _PiecePainter(piece: piece, cellSize: cellSize, gap: gap),
          );
        },
      ),
    );
  }
}

class _PiecePainter extends CustomPainter {
  const _PiecePainter({
    required this.piece,
    required this.cellSize,
    required this.gap,
  });

  final PreviewPiece piece;
  final double cellSize;
  final double gap;

  @override
  void paint(Canvas canvas, Size size) {
    final rows = piece.rows;
    final cols = piece.cols;

    final pieceWidth = cols * cellSize + (cols - 1) * gap;
    final pieceHeight = rows * cellSize + (rows - 1) * gap;

    final offsetX = (size.width - pieceWidth) / 2.0;
    final offsetY = (size.height - pieceHeight) / 2.0;

    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < cols; c++) {
        if (piece.matrix[r][c]) {
          final rect = Rect.fromLTWH(
            offsetX + c * (cellSize + gap),
            offsetY + r * (cellSize + gap),
            cellSize,
            cellSize,
          );
          BlockTilePainter.paintTile(canvas, rect, piece.color, radius: 3.0);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _PiecePainter oldDelegate) {
    return oldDelegate.piece != piece ||
        oldDelegate.cellSize != cellSize ||
        oldDelegate.gap != gap;
  }
}
