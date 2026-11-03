import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:blockpuzzle/core/theme/app_radii.dart';
import 'package:blockpuzzle/features/game/widgets/game_hud.dart';
import 'package:blockpuzzle/features/game/widgets/score_display.dart';

void main() {
  group('Game HUD & Score Display Tests', () {
    testWidgets('ScoreDisplay displays 0000 for zero score', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: ScoreDisplay(score: 0))),
      );
      await tester.pumpAndSettle();

      expect(find.text('0000'), findsOneWidget);
      expect(find.text('SCORE'), findsOneWidget);
    });

    testWidgets('ScoreDisplay displays non-zero score accurately', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: ScoreDisplay(score: 1420))),
      );
      await tester.pumpAndSettle();

      expect(find.text('1420'), findsOneWidget);
    });

    testWidgets(
      'GameHUD renders pause button with >= 48dp touch target and triggers callback',
      (tester) async {
        bool pauseTapped = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: GameHUD(
                score: 550,
                bestScore: 2400,
                onPause: () => pauseTapped = true,
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('550'), findsOneWidget);
        expect(find.text('2400'), findsOneWidget);
        expect(find.text('BEST'), findsOneWidget);

        final pauseFinder = find.byTooltip('Pause game');
        expect(pauseFinder, findsOneWidget);

        final pauseSize = tester.getSize(pauseFinder);
        expect(
          pauseSize.width,
          greaterThanOrEqualTo(AppRadii.minTouchTarget),
          reason: 'Pause button width must be at least 48dp',
        );
        expect(
          pauseSize.height,
          greaterThanOrEqualTo(AppRadii.minTouchTarget),
          reason: 'Pause button height must be at least 48dp',
        );

        await tester.tap(pauseFinder);
        await tester.pumpAndSettle();

        expect(pauseTapped, isTrue);
      },
    );

    testWidgets('GameHUD displays dash when bestScore is null', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GameHUD(score: 0, bestScore: null, onPause: () {}),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('—'), findsOneWidget);
    });
  });
}
