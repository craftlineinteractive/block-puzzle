import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:blockpuzzle/app/block_puzzle_app.dart';
import 'package:blockpuzzle/app/router/app_router.dart';
import 'package:blockpuzzle/app/router/app_routes.dart';
import 'package:blockpuzzle/features/game/presentation/game_screen.dart';
import 'package:blockpuzzle/features/game/presentation/models/game_screen_preview_data.dart';
import 'package:blockpuzzle/features/game/widgets/block_tray_preview.dart';
import 'package:blockpuzzle/features/game/widgets/board_widget.dart';
import 'package:blockpuzzle/features/game/widgets/game_hud.dart';
import 'package:blockpuzzle/features/game/widgets/pause_overlay.dart';
import 'package:blockpuzzle/features/home/presentation/home_screen.dart';

void main() {
  group('GameScreen Full Integration & Lifecycle Tests', () {
    testWidgets('GameScreen renders HUD, Board, and Tray at initial launch', (
      tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: GameScreen()));
      await tester.pumpAndSettle();

      expect(find.byType(GameHUD), findsOneWidget);
      expect(find.byType(BoardWidget), findsOneWidget);
      expect(find.byType(BlockTrayPreview), findsOneWidget);
      expect(find.byType(PauseOverlay), findsNothing);
    });

    testWidgets('Pause overlay opens and resumes correctly', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: GameScreen()));
      await tester.pumpAndSettle();

      // Tap Pause
      await tester.tap(find.byTooltip('Pause game'));
      await tester.pumpAndSettle();

      expect(find.byType(PauseOverlay), findsOneWidget);
      expect(find.text('GAME PAUSED'), findsOneWidget);

      // Tap RESUME
      await tester.tap(find.text('RESUME'));
      await tester.pumpAndSettle();

      expect(find.byType(PauseOverlay), findsNothing);
    });

    testWidgets('Pause overlay Home button navigates back to HomeScreen', (
      tester,
    ) async {
      final router = createAppRouter(initialLocation: AppRoutes.classic);

      await tester.pumpWidget(
        ProviderScope(child: BlockPuzzleApp(routerConfig: router)),
      );
      await tester.pumpAndSettle();

      expect(find.byType(GameScreen), findsOneWidget);

      // Open pause
      await tester.tap(find.byTooltip('Pause game'));
      await tester.pumpAndSettle();

      // Tap Home
      await tester.tap(find.text('HOME'));
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.byType(GameScreen), findsNothing);
    });

    testWidgets('Re-entering Classic mode resets pause overlay to closed', (
      tester,
    ) async {
      final router = createAppRouter(initialLocation: AppRoutes.home);

      await tester.pumpWidget(
        ProviderScope(child: BlockPuzzleApp(routerConfig: router)),
      );
      await tester.pumpAndSettle();

      // 1. Navigate to Classic
      await tester.tap(find.text('PLAY CLASSIC'));
      await tester.pumpAndSettle();
      expect(find.byType(GameScreen), findsOneWidget);

      // 2. Open pause
      await tester.tap(find.byTooltip('Pause game'));
      await tester.pumpAndSettle();
      expect(find.byType(PauseOverlay), findsOneWidget);

      // 3. Navigate back Home
      await tester.tap(find.text('HOME'));
      await tester.pumpAndSettle();
      expect(find.byType(HomeScreen), findsOneWidget);

      // 4. Return to Classic
      await tester.tap(find.text('PLAY CLASSIC'));
      await tester.pumpAndSettle();
      expect(find.byType(GameScreen), findsOneWidget);

      // 5. Verify pause overlay is NOT open
      expect(find.byType(PauseOverlay), findsNothing);
    });

    testWidgets('PopScope handles system back gesture when paused', (
      tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: GameScreen()));
      await tester.pumpAndSettle();

      // Open Pause
      await tester.tap(find.byTooltip('Pause game'));
      await tester.pumpAndSettle();
      expect(find.byType(PauseOverlay), findsOneWidget);

      // Simulate system back button dispatch
      final popScopeFinder = find.byWidgetPredicate((w) => w is PopScope);
      expect(popScopeFinder, findsOneWidget);

      // When paused, canPop is false
      final popScopeWidget = tester.widget<PopScope<Object?>>(popScopeFinder);
      expect(popScopeWidget.canPop, isFalse);

      // Invoking callback resumes game
      popScopeWidget.onPopInvokedWithResult?.call(false, null);
      await tester.pumpAndSettle();

      expect(find.byType(PauseOverlay), findsNothing);
    });

    const responsiveViewports = <String, Size>{
      '320dp Narrow': Size(320, 568),
      '360dp Android Small': Size(360, 640),
      '393dp Standard Modern': Size(393, 852),
      '430dp Large Phone': Size(430, 932),
      '800dp Tablet': Size(800, 1280),
    };

    for (final entry in responsiveViewports.entries) {
      testWidgets('GameScreen zero overflow on ${entry.key}', (tester) async {
        tester.view.physicalSize = entry.value;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        await tester.pumpWidget(const MaterialApp(home: GameScreen()));
        await tester.pumpAndSettle();

        expect(find.byType(GameHUD), findsOneWidget);
        expect(find.byType(BoardWidget), findsOneWidget);
        expect(find.byType(BlockTrayPreview), findsOneWidget);
        expect(tester.takeException(), isNull);
      });
    }

    testWidgets('GameScreen handles dynamic previewData updates', (
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
