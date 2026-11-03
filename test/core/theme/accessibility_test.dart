import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:blockpuzzle/app/block_puzzle_app.dart';
import 'package:blockpuzzle/app/router/app_router.dart';
import 'package:blockpuzzle/app/router/app_routes.dart';
import 'package:blockpuzzle/core/theme/app_colors.dart';
import 'package:blockpuzzle/core/theme/app_radii.dart';

void main() {
  group('Phase 03B Accessibility & Semantics Audit', () {
    testWidgets(
      'HomeScreen interactive elements enforce minimum 48dp touch targets',
      (tester) async {
        final router = createAppRouter(initialLocation: AppRoutes.home);

        await tester.pumpWidget(
          ProviderScope(child: BlockPuzzleApp(routerConfig: router)),
        );
        await tester.pumpAndSettle();

        // Check Settings Button touch target
        final settingsFinder = find.byTooltip('Settings');
        expect(settingsFinder, findsOneWidget);
        final settingsSize = tester.getSize(settingsFinder);
        expect(
          settingsSize.width,
          greaterThanOrEqualTo(AppRadii.minTouchTarget),
        );
        expect(
          settingsSize.height,
          greaterThanOrEqualTo(AppRadii.minTouchTarget),
        );

        // Check Play Classic CTA button touch target
        final playClassicFinder = find.text('PLAY CLASSIC');
        expect(playClassicFinder, findsOneWidget);
        final playClassicSize = tester.getSize(
          find.ancestor(
            of: playClassicFinder,
            matching: find.byType(ElevatedButton),
          ),
        );
        expect(
          playClassicSize.width,
          greaterThanOrEqualTo(AppRadii.minTouchTarget),
        );
        expect(
          playClassicSize.height,
          greaterThanOrEqualTo(AppRadii.minTouchTarget),
        );

        // Check Classic mode card touch target
        final classicCard = find.text('CLASSIC');
        final classicSize = tester.getSize(
          find.ancestor(of: classicCard, matching: find.byType(InkWell)).first,
        );
        expect(
          classicSize.width,
          greaterThanOrEqualTo(AppRadii.minTouchTarget),
        );
        expect(
          classicSize.height,
          greaterThanOrEqualTo(AppRadii.minTouchTarget),
        );
      },
    );

    testWidgets(
      'Placeholder screen Back to Home button enforces >= 48dp touch target',
      (tester) async {
        final router = createAppRouter(initialLocation: AppRoutes.levels);

        await tester.pumpWidget(
          ProviderScope(child: BlockPuzzleApp(routerConfig: router)),
        );
        await tester.pumpAndSettle();

        final backButton = find.text('Back to Home');
        expect(backButton, findsOneWidget);
        final backButtonSize = tester.getSize(
          find.ancestor(of: backButton, matching: find.byType(FilledButton)),
        );
        expect(
          backButtonSize.width,
          greaterThanOrEqualTo(AppRadii.minTouchTarget),
        );
        expect(
          backButtonSize.height,
          greaterThanOrEqualTo(AppRadii.minTouchTarget),
        );
      },
    );

    testWidgets('Semantic nodes exist for screen readers on HomeScreen', (
      tester,
    ) async {
      final router = createAppRouter(initialLocation: AppRoutes.home);

      await tester.pumpWidget(
        ProviderScope(child: BlockPuzzleApp(routerConfig: router)),
      );
      await tester.pumpAndSettle();

      expect(find.bySemanticsLabel('Open Settings'), findsOneWidget);
      expect(find.bySemanticsLabel('Play Classic Mode'), findsOneWidget);
      expect(
        find.bySemanticsLabel(
          RegExp(r'CLASSIC Game Mode: Endless puzzle gameplay.*'),
        ),
        findsOneWidget,
      );
      expect(
        find.bySemanticsLabel(RegExp(r'LEVELS Game Mode: Stage objectives.*')),
        findsOneWidget,
      );
    });

    test('WCAG contrast requirements are strictly met across palettes', () {
      double computeLuminance(Color color) {
        return color.computeLuminance();
      }

      double computeContrast(Color foreground, Color background) {
        final l1 = computeLuminance(foreground);
        final l2 = computeLuminance(background);
        final lighter = l1 > l2 ? l1 : l2;
        final darker = l1 > l2 ? l2 : l1;
        return (lighter + 0.05) / (darker + 0.05);
      }

      // Normal text contrast (>= 4.5:1 for WCAG AA)
      final primaryTextContrast = computeContrast(
        AppColors.textPrimary,
        AppColors.background,
      );
      expect(
        primaryTextContrast,
        greaterThanOrEqualTo(7.0),
      ); // Exceeds AAA (7:1)

      final secondaryTextContrast = computeContrast(
        AppColors.textSecondary,
        AppColors.background,
      );
      expect(
        secondaryTextContrast,
        greaterThanOrEqualTo(4.5),
      ); // Exceeds AA (4.5:1)

      final onSurfaceContrast = computeContrast(
        AppColors.textPrimary,
        AppColors.elevatedSurface,
      );
      expect(onSurfaceContrast, greaterThanOrEqualTo(7.0)); // Exceeds AAA (7:1)
    });
  });
}
