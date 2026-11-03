import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../presentation/painters/board_painter.dart';

/// Responsive, isolated 10x10 puzzle board widget.
///
/// Ensures a strict 1:1 aspect ratio, high-performance rendering via [RepaintBoundary],
/// full accessibility semantics, and premium arcade depth shadow.
class BoardWidget extends StatelessWidget {
  const BoardWidget({
    required this.grid,
    super.key,
    this.gap = 3.0,
    this.cellRadius = 4.0,
  });

  /// 10x10 matrix of block tile colors.
  final List<List<Color?>> grid;

  /// Spacing between individual cells.
  final double gap;

  /// Corner radius of each cell.
  final double cellRadius;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '10 by 10 puzzle board',
      container: true,
      child: Center(
        child: AspectRatio(
          aspectRatio: 1.0,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(AppRadii.large),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.40),
                  blurRadius: 16.0,
                  offset: const Offset(0, 6),
                ),
                BoxShadow(
                  color: AppColors.primaryAccent.withValues(alpha: 0.08),
                  blurRadius: 24.0,
                  spreadRadius: 2.0,
                ),
              ],
            ),
            child: RepaintBoundary(
              child: CustomPaint(
                painter: BoardPainter(
                  grid: grid,
                  gap: gap,
                  cellRadius: cellRadius,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
