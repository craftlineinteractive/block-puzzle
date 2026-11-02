import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radii.dart';
import 'app_spacing.dart';
import 'app_typography.dart';

/// Centralized application theme engine for Block Puzzle.
///
/// Synthesizes design tokens into a cohesive, responsive Material 3 dark arcade theme
/// with accessible typography and touch targets.
abstract final class AppTheme {
  const AppTheme._();

  // Backward compatibility aliases for Phase 01 references
  static const Color primaryColor = AppColors.primaryAccent;
  static const Color secondaryColor = AppColors.secondaryAccent;
  static const Color scaffoldBackground = AppColors.background;
  static const Color surfaceColor = AppColors.elevatedSurface;

  /// Returns the configured dark [ThemeData] for Block Puzzle.
  static ThemeData get darkTheme {
    const colorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.primaryAccent,
      onPrimary: Colors.white,
      secondary: AppColors.secondaryAccent,
      onSecondary: Colors.white,
      error: AppColors.error,
      onError: Colors.white,
      surface: AppColors.elevatedSurface,
      onSurface: AppColors.textPrimary,
      surfaceContainerHighest: AppColors.boardSurface,
      outline: AppColors.emptyCellBorder,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: AppTypography.textTheme,

      // AppBar Styling
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppTypography.headlineLarge,
        iconTheme: IconThemeData(color: AppColors.textPrimary, size: 24),
      ),

      // Card / Panel Styling
      cardTheme: const CardThemeData(
        color: AppColors.elevatedSurface,
        elevation: 2,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadii.borderMedium,
          side: BorderSide(color: AppColors.emptyCellBorder, width: 1),
        ),
      ),

      // ElevatedButton Styling (Minimum 48px touch target)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryAccent,
          foregroundColor: Colors.white,
          elevation: 2,
          minimumSize: AppRadii.minTouchTargetSize,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: AppRadii.borderMedium,
          ),
          textStyle: AppTypography.buttonLarge,
        ),
      ),

      // OutlinedButton Styling (Minimum 48px touch target)
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textPrimary,
          minimumSize: AppRadii.minTouchTargetSize,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          side: const BorderSide(color: AppColors.emptyCellBorder, width: 1.5),
          shape: const RoundedRectangleBorder(
            borderRadius: AppRadii.borderMedium,
          ),
          textStyle: AppTypography.buttonLarge,
        ),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(color: AppColors.textPrimary, size: 24),

      // Dialog Styling
      dialogTheme: const DialogThemeData(
        backgroundColor: AppColors.secondaryBackground,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadii.borderLarge,
          side: BorderSide(color: AppColors.emptyCellBorder, width: 1.5),
        ),
        titleTextStyle: AppTypography.headlineLarge,
        contentTextStyle: AppTypography.bodyMedium,
      ),

      // InputDecoration Styling
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.elevatedSurface,
        border: const OutlineInputBorder(
          borderRadius: AppRadii.borderMedium,
          borderSide: BorderSide(color: AppColors.emptyCellBorder),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: AppRadii.borderMedium,
          borderSide: BorderSide(color: AppColors.emptyCellBorder),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: AppRadii.borderMedium,
          borderSide: BorderSide(color: AppColors.primaryAccent, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        hintStyle: AppTypography.bodyMedium.copyWith(
          color: AppColors.textTertiary,
        ),
      ),
    );
  }
}
