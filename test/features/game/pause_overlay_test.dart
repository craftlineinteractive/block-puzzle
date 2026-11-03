import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:blockpuzzle/core/theme/app_radii.dart';
import 'package:blockpuzzle/features/game/widgets/pause_overlay.dart';

void main() {
  group('Pause Overlay Tests', () {
    testWidgets(
      'PauseOverlay renders title, actions, and validates >= 48dp touch targets',
      (tester) async {
        bool resumed = false;
        bool homed = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: PauseOverlay(
                onResume: () => resumed = true,
                onHome: () => homed = true,
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('GAME PAUSED'), findsOneWidget);
        expect(
          find.text('Take a breath. Your board is waiting.'),
          findsOneWidget,
        );

        final resumeBtn = find.widgetWithText(ElevatedButton, 'RESUME');
        final homeBtn = find.widgetWithText(OutlinedButton, 'HOME');

        expect(resumeBtn, findsOneWidget);
        expect(homeBtn, findsOneWidget);

        final resumeSize = tester.getSize(resumeBtn);
        final homeSize = tester.getSize(homeBtn);

        expect(
          resumeSize.height,
          greaterThanOrEqualTo(AppRadii.minTouchTarget),
          reason: 'RESUME button height must meet minimum 48dp touch target',
        );
        expect(
          homeSize.height,
          greaterThanOrEqualTo(AppRadii.minTouchTarget),
          reason: 'HOME button height must meet minimum 48dp touch target',
        );

        await tester.tap(resumeBtn);
        await tester.pumpAndSettle();
        expect(resumed, isTrue);

        await tester.tap(homeBtn);
        await tester.pumpAndSettle();
        expect(homed, isTrue);
      },
    );
  });
}
