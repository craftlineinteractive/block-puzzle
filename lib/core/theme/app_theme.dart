import 'package:flutter/material.dart';

/// Centralized application theme foundation.
///
/// Configures a clean Material 3 dark theme tailored for casual puzzle gameplay.
abstract final class AppTheme {
  // Foundational palette colors
  static const Color primaryColor = Color(0xFF6366F1);
  static const Color secondaryColor = Color(0xFFEC4899);
  static const Color scaffoldBackground = Color(0xFF0F172A);
  static const Color surfaceColor = Color(0xFF1E293B);

  /// Returns the configured dark [ThemeData] for Block Puzzle.
  static ThemeData get darkTheme {
    final colorScheme =
        ColorScheme.fromSeed(
          seedColor: primaryColor,
          brightness: Brightness.dark,
        ).copyWith(
          primary: primaryColor,
          secondary: secondaryColor,
          surface: surfaceColor,
        );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: scaffoldBackground,
      appBarTheme: const AppBarTheme(
        backgroundColor: scaffoldBackground,
        elevation: 0,
        centerTitle: true,
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
          color: Colors.white,
        ),
        bodyLarge: TextStyle(fontSize: 16, color: Colors.white70),
      ),
    );
  }
}
