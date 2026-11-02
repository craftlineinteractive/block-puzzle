import 'package:flutter/material.dart';

/// Centralized semantic color tokens for Block Puzzle.
///
/// Designed around a premium colorful dark-arcade aesthetic with
/// strict adherence to WCAG AAA contrast accessibility on dark surfaces.
abstract final class AppColors {
  const AppColors._();

  // Background & Surface Hierarchy
  static const Color background = Color(0xFF101A2B);
  static const Color secondaryBackground = Color(0xFF17243A);
  static const Color elevatedSurface = Color(0xFF202F49);
  static const Color boardSurface = Color(0xFF1B2940);
  static const Color emptyCell = Color(0xFF2B3D57);
  static const Color emptyCellBorder = Color(0xFF334766);

  // Typography & Content
  static const Color textPrimary = Color(0xFFF4F7FB);
  static const Color textSecondary = Color(0xFFA5B4C7);
  static const Color textTertiary = Color(0xFF64748B);

  // Accent & Brand Colors
  static const Color primaryAccent = Color(0xFF6366F1); // Indigo neon
  static const Color secondaryAccent = Color(0xFFEC4899); // Pink neon

  // Game Puzzle Block Colors (Vibrant, high-contrast arcade polyomino hues)
  static const Color blockBlue = Color(0xFF38BDF8);
  static const Color blockPurple = Color(0xFFA78BFA);
  static const Color blockOrange = Color(0xFFFBBF24);
  static const Color blockGreen = Color(0xFF34D399);
  static const Color blockPink = Color(0xFFFB7185);
  static const Color blockRed = Color(0xFFF43F5E);
  static const Color blockYellow = Color(0xFFFACC15);
  static const Color blockCyan = Color(0xFF22D3EE);

  // Functional & Feedback Status
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  /// List of all standard block polyomino colors available for placement.
  static const List<Color> allBlockColors = [
    blockBlue,
    blockPurple,
    blockOrange,
    blockGreen,
    blockPink,
    blockRed,
    blockYellow,
    blockCyan,
  ];
}

