import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Highly optimized static canvas painter for arcade-style puzzle block tiles.
///
/// Implements glossy dual-stop gradients, top-edge specular highlights,
/// dimensional inner bevels, and subtle outer outlines for premium visual punch.
abstract final class BlockTilePainter {
  const BlockTilePainter._();

  /// Paints a glossy arcade block tile within [rect].
  static void paintTile(
    Canvas canvas,
    Rect rect,
    Color color, {
    double radius = 4.0,
    double opacity = 1.0,
  }) {
    if (rect.isEmpty) return;

    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));

    // 1. Base Gradient Fill (rich dimensional arcade gradient)
    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.lerp(color, Colors.white, 0.18)!.withValues(alpha: opacity),
        color.withValues(alpha: opacity),
        Color.lerp(color, Colors.black, 0.22)!.withValues(alpha: opacity),
      ],
      stops: const [0.0, 0.45, 1.0],
    );

    final fillPaint = Paint()
      ..shader = gradient.createShader(rect)
      ..isAntiAlias = true;

    canvas.drawRRect(rrect, fillPaint);

    // 2. Specular Top Highlight (Glossy arcade glass reflection)
    final highlightRect = Rect.fromLTWH(
      rect.left + 1.0,
      rect.top + 1.0,
      rect.width - 2.0,
      (rect.height * 0.42).clamp(1.0, rect.height),
    );
    final highlightRRect = RRect.fromRectAndRadius(
      highlightRect,
      Radius.circular(radius > 2.0 ? radius - 1.0 : 1.0),
    );

    final highlightGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.white.withValues(alpha: 0.40 * opacity),
        Colors.white.withValues(alpha: 0.05 * opacity),
      ],
    );

    final highlightPaint = Paint()
      ..shader = highlightGradient.createShader(highlightRect)
      ..isAntiAlias = true;

    canvas.drawRRect(highlightRRect, highlightPaint);

    // 3. Crisp Inner Edge Outline (Bevel definition)
    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = Color.lerp(
        color,
        Colors.white,
        0.3,
      )!.withValues(alpha: 0.65 * opacity)
      ..isAntiAlias = true;

    final innerRRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        rect.left + 0.5,
        rect.top + 0.5,
        rect.width - 1.0,
        rect.height - 1.0,
      ),
      Radius.circular(radius),
    );
    canvas.drawRRect(innerRRect, borderPaint);

    // 4. Subtle Bottom Shadow (Dimensional inset lip)
    final shadowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = Colors.black.withValues(alpha: 0.35 * opacity)
      ..isAntiAlias = true;

    final shadowPath = Path()
      ..moveTo(rect.left + radius, rect.bottom - 0.6)
      ..lineTo(rect.right - radius, rect.bottom - 0.6);

    canvas.drawPath(shadowPath, shadowPaint);
  }

  /// Paints an empty, unoccupied board grid cell with subtle inset depth.
  static void paintEmptyCell(Canvas canvas, Rect rect, {double radius = 4.0}) {
    if (rect.isEmpty) return;

    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));

    // Base cell background
    final backgroundPaint = Paint()
      ..color = AppColors.emptyCell
      ..isAntiAlias = true;
    canvas.drawRRect(rrect, backgroundPaint);

    // Subtle inner depth fill
    final innerPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.12)
      ..isAntiAlias = true;
    final innerRRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        rect.left + 1.0,
        rect.top + 1.0,
        rect.width - 2.0,
        rect.height - 2.0,
      ),
      Radius.circular(radius > 1.5 ? radius - 1.0 : 1.0),
    );
    canvas.drawRRect(innerRRect, innerPaint);

    // Subtle cell border
    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = AppColors.emptyCellBorder
      ..isAntiAlias = true;
    canvas.drawRRect(rrect, borderPaint);
  }
}
