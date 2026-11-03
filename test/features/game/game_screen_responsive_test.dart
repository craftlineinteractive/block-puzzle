import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:blockpuzzle/features/game/presentation/game_screen.dart';
import 'package:blockpuzzle/features/game/presentation/models/game_screen_preview_data.dart';
import 'package:blockpuzzle/features/game/widgets/block_tray_preview.dart';
import 'package:blockpuzzle/features/game/widgets/board_widget.dart';
import 'package:blockpuzzle/features/game/widgets/game_hud.dart';
import 'package:blockpuzzle/features/game/widgets/pause_overlay.dart';

void main() {
  group('GameScreen Responsive & Interaction Tests', () {
    const viewports = <String, Size>{
      'Narrow phone (320x568)': Size(320, 568),
      'Standard phone (390x844)': Size(390, 844),
      'Large phone (412x915)': Size(412, 915),
      'Tablet (800x1280)': Size(800, 1280),
    };

    for (final entry in viewports.entries) {
      testWidgets('GameScreen renders with zero overflow on ${entry.key}', (
        tester,
      ) async {
        tester.view.physicalSize = entry.value;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        await tester.pumpWidget(const MaterialApp(home: GameScreen()));
        await tester.pumpAndSettle();

        // Verify HUD, Board, Tray presence
        expect(find.byType(GameHUD), findsOneWidget);
        expect(find.byType(BoardWidget), findsOneWidget);
        expect(find.byType(BlockTrayPreview), findsOneWidget);

        // Zero overflow guarantee
        expect(tester.takeException(), isNull);
      });
    }

    testWidgets('Tapping pause icon shows PauseOverlay and resuming hides it', (
      tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: GameScreen()));
      await tester.pumpAndSettle();

      // Initially pause overlay is not visible
      expect(find.byType(PauseOverlay), findsNothing);

      // Tap pause button
      final pauseBtn = find.byTooltip('Pause game');
      expect(pauseBtn, findsOneWidget);
      await tester.tap(pauseBtn);
      await tester.pumpAndSettle();

      // Pause overlay is visible
      expect(find.byType(PauseOverlay), findsOneWidget);
      expect(find.text('GAME PAUSED'), findsOneWidget);

      // Tap RESUME
      final resumeBtn = find.text('RESUME');
      expect(resumeBtn, findsOneWidget);
      await tester.tap(resumeBtn);
      await tester.pumpAndSettle();

      // Pause overlay dismissed
      expect(find.byType(PauseOverlay), findsNothing);
    });

    testWidgets('GameScreen updates previewData when prop changes', (
      tester,
    ) async {
      final initialData = GameScreenPreviewData.empty();
      final updatedData = GameScreenPreviewData.samplePreview();

      await tester.pumpWidget(
        MaterialApp(home: GameScreen(previewData: initialData)),
      );
      await tester.pumpAndSettle();

      await tester.pumpWidget(
        MaterialApp(home: GameScreen(previewData: updatedData)),
      );
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
    });
  });
}
