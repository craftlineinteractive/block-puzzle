import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:blockpuzzle/core/theme/app_colors.dart';

/// Calculates W3C WCAG relative luminance for a given Color.
double _relativeLuminance(Color color) {
  double channel(double value) {
    return value <= 0.03928
        ? value / 12.92
        : pow((value + 0.055) / 1.055, 2.4).toDouble();
  }

  final r = channel(color.r);
  final g = channel(color.g);
  final b = channel(color.b);

  return 0.2126 * r + 0.7152 * g + 0.0722 * b;
}

/// Calculates W3C WCAG contrast ratio between two colors (L1:L2).
double _contrastRatio(Color c1, Color c2) {
  final l1 = _relativeLuminance(c1);
  final l2 = _relativeLuminance(c2);
  final lighter = max(l1, l2);
  final darker = min(l1, l2);
  return (lighter + 0.05) / (darker + 0.05);
}

void main() {
  group('AppColors Semantic Palette Tests', () {
    test('All block colors are defined and unique', () {
      expect(AppColors.allBlockColors.length, equals(8));
      final uniqueHexes = AppColors.allBlockColors
          .map((c) => c.toARGB32())
          .toSet();
      expect(uniqueHexes.length, equals(8));
    });

    test(
      'Primary text meets WCAG AAA normal text contrast (>= 7.0:1) on dark background',
      () {
        final ratio = _contrastRatio(
          AppColors.textPrimary,
          AppColors.background,
        );
        // Requirement: normal text >= 4.5:1 (AA), >= 7.0:1 (AAA)
        expect(ratio, greaterThanOrEqualTo(7.0));
      },
    );

    test(
      'Primary text meets WCAG AAA contrast (>= 7.0:1) on elevated surface',
      () {
        final ratio = _contrastRatio(
          AppColors.textPrimary,
          AppColors.elevatedSurface,
        );
        expect(ratio, greaterThanOrEqualTo(7.0));
      },
    );

    test(
      'Secondary text meets WCAG AA normal text contrast (>= 4.5:1) on background',
      () {
        final ratio = _contrastRatio(
          AppColors.textSecondary,
          AppColors.background,
        );
        expect(ratio, greaterThanOrEqualTo(4.5));
      },
    );

    test(
      'Secondary text meets WCAG AA normal text contrast (>= 4.5:1) on elevated surface',
      () {
        final ratio = _contrastRatio(
          AppColors.textSecondary,
          AppColors.elevatedSurface,
        );
        expect(ratio, greaterThanOrEqualTo(4.5));
      },
    );

    test('Board empty cell and surface are distinct from main background', () {
      expect(AppColors.boardSurface, isNot(equals(AppColors.background)));
      expect(AppColors.emptyCell, isNot(equals(AppColors.boardSurface)));
    });
  });
}
