import 'package:flutter/material.dart';

/// Centralized corner radius and minimum touch target tokens for Block Puzzle.
abstract final class AppRadii {
  const AppRadii._();

  // Raw scalar corner radii
  static const double small = 6.0;
  static const double medium = 12.0;
  static const double large = 16.0;
  static const double extraLarge = 24.0;
  static const double pill = 999.0;

  // BorderRadius geometry
  static const BorderRadius borderSmall = BorderRadius.all(
    Radius.circular(small),
  );
  static const BorderRadius borderMedium = BorderRadius.all(
    Radius.circular(medium),
  );
  static const BorderRadius borderLarge = BorderRadius.all(
    Radius.circular(large),
  );
  static const BorderRadius borderExtraLarge = BorderRadius.all(
    Radius.circular(extraLarge),
  );
  static const BorderRadius borderPill = BorderRadius.all(
    Radius.circular(pill),
  );

  // Mobile touch target guidelines (minimum 48x48 logical pixels)
  static const double minTouchTarget = 48.0;
  static const Size minTouchTargetSize = Size(minTouchTarget, minTouchTarget);
  static const BoxConstraints touchTargetConstraints = BoxConstraints(
    minWidth: minTouchTarget,
    minHeight: minTouchTarget,
  );
}
