import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Centralized typography system for Block Puzzle.
///
/// Pairs Fredoka (expressive, rounded display font) for game headings, scores,
/// and buttons with Nunito (clean, highly legible grotesque) for body,
/// descriptions, statistics, and sub-labels.
abstract final class AppTypography {
  const AppTypography._();

  static const String fontFredoka = 'Fredoka';
  static const String fontNunito = 'Nunito';

  // Game Score & Display Styles (Fredoka)
  static const TextStyle scoreDisplay = TextStyle(
    fontFamily: fontFredoka,
    fontSize: 54,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    color: AppColors.textPrimary,
  );

  static const TextStyle displayLarge = TextStyle(
    fontFamily: fontFredoka,
    fontSize: 40,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    color: AppColors.textPrimary,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: fontFredoka,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static const TextStyle displaySmall = TextStyle(
    fontFamily: fontFredoka,
    fontSize: 26,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static const TextStyle headlineLarge = TextStyle(
    fontFamily: fontFredoka,
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontFamily: fontFredoka,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontFamily: fontFredoka,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // Content, Navigation, and Descriptive Styles (Nunito)
  static const TextStyle titleLarge = TextStyle(
    fontFamily: fontNunito,
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static const TextStyle titleMedium = TextStyle(
    fontFamily: fontNunito,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle titleSmall = TextStyle(
    fontFamily: fontNunito,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontNunito,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontNunito,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontNunito,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textTertiary,
  );

  // Action / Button Typography (Fredoka for punchy CTA feel)
  static const TextStyle buttonLarge = TextStyle(
    fontFamily: fontFredoka,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    color: Colors.white,
  );

  static const TextStyle buttonMedium = TextStyle(
    fontFamily: fontFredoka,
    fontSize: 15,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.4,
    color: Colors.white,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: fontNunito,
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
    color: AppColors.textTertiary,
  );

  /// Material 3 compliant [TextTheme] synthesizing all typography tiers.
  static TextTheme get textTheme => const TextTheme(
    displayLarge: displayLarge,
    displayMedium: displayMedium,
    displaySmall: displaySmall,
    headlineLarge: headlineLarge,
    headlineMedium: headlineMedium,
    headlineSmall: headlineSmall,
    titleLarge: titleLarge,
    titleMedium: titleMedium,
    titleSmall: titleSmall,
    bodyLarge: bodyLarge,
    bodyMedium: bodyMedium,
    bodySmall: bodySmall,
    labelLarge: buttonLarge,
    labelMedium: buttonMedium,
    labelSmall: labelSmall,
  );
}
