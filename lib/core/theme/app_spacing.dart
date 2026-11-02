import 'package:flutter/material.dart';

/// Centralized 4-logical-pixel spacing scale for Block Puzzle.
abstract final class AppSpacing {
  const AppSpacing._();

  /// 4.0 logical pixels
  static const double xs = 4.0;

  /// 8.0 logical pixels
  static const double sm = 8.0;

  /// 12.0 logical pixels
  static const double smMd = 12.0;

  /// 16.0 logical pixels
  static const double md = 16.0;

  /// 24.0 logical pixels
  static const double lg = 24.0;

  /// 32.0 logical pixels
  static const double xl = 32.0;

  /// 48.0 logical pixels
  static const double xxl = 48.0;

  /// 64.0 logical pixels
  static const double xxxl = 64.0;

  // Convenient EdgeInsets presets
  static const EdgeInsets paddingXs = EdgeInsets.all(xs);
  static const EdgeInsets paddingSm = EdgeInsets.all(sm);
  static const EdgeInsets paddingMd = EdgeInsets.all(md);
  static const EdgeInsets paddingLg = EdgeInsets.all(lg);
  static const EdgeInsets paddingXl = EdgeInsets.all(xl);

  static const EdgeInsets horizontalSm = EdgeInsets.symmetric(horizontal: sm);
  static const EdgeInsets horizontalMd = EdgeInsets.symmetric(horizontal: md);
  static const EdgeInsets horizontalLg = EdgeInsets.symmetric(horizontal: lg);

  static const EdgeInsets verticalSm = EdgeInsets.symmetric(vertical: sm);
  static const EdgeInsets verticalMd = EdgeInsets.symmetric(vertical: md);
  static const EdgeInsets verticalLg = EdgeInsets.symmetric(vertical: lg);
}
