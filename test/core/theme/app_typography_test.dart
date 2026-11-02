import 'package:flutter_test/flutter_test.dart';

import 'package:blockpuzzle/core/theme/app_typography.dart';

void main() {
  group('AppTypography Design System Tests', () {
    test('Font family names match pubspec declarations', () {
      expect(AppTypography.fontFredoka, equals('Fredoka'));
      expect(AppTypography.fontNunito, equals('Nunito'));
    });

    test('Display styles are mapped to Fredoka display family', () {
      expect(AppTypography.displayLarge.fontFamily, equals('Fredoka'));
      expect(AppTypography.displayMedium.fontFamily, equals('Fredoka'));
      expect(AppTypography.displaySmall.fontFamily, equals('Fredoka'));
      expect(AppTypography.scoreDisplay.fontFamily, equals('Fredoka'));
      expect(AppTypography.buttonLarge.fontFamily, equals('Fredoka'));
    });

    test('Content and body styles are mapped to Nunito family', () {
      expect(AppTypography.titleLarge.fontFamily, equals('Nunito'));
      expect(AppTypography.bodyLarge.fontFamily, equals('Nunito'));
      expect(AppTypography.bodyMedium.fontFamily, equals('Nunito'));
      expect(AppTypography.bodySmall.fontFamily, equals('Nunito'));
    });

    test('TextTheme synthesizes all typography roles without nulls', () {
      final theme = AppTypography.textTheme;
      expect(theme.displayLarge, isNotNull);
      expect(theme.displayMedium, isNotNull);
      expect(theme.displaySmall, isNotNull);
      expect(theme.headlineLarge, isNotNull);
      expect(theme.headlineMedium, isNotNull);
      expect(theme.titleLarge, isNotNull);
      expect(theme.bodyLarge, isNotNull);
      expect(theme.bodyMedium, isNotNull);
      expect(theme.labelLarge, isNotNull);
    });
  });
}

