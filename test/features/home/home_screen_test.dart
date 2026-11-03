import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:blockpuzzle/app/block_puzzle_app.dart';
import 'package:blockpuzzle/app/router/app_router.dart';
import 'package:blockpuzzle/app/router/app_routes.dart';
import 'package:blockpuzzle/features/game/presentation/game_screen.dart';
import 'package:blockpuzzle/features/home/presentation/home_screen.dart';
import 'package:blockpuzzle/features/home/widgets/home_header.dart';
import 'package:blockpuzzle/features/home/widgets/home_hero_card.dart';
import 'package:blockpuzzle/features/home/widgets/home_shortcut_tile.dart';
import 'package:blockpuzzle/shared/widgets/feature_placeholder_screen.dart';

void main() {
  group('HomeScreen Presentation & Navigation Tests', () {
    testWidgets('HomeScreen renders header, hero, modes, and shortcuts', (
      tester,
    ) async {
      final router = createAppRouter(initialLocation: AppRoutes.home);

      await tester.pumpWidget(
        ProviderScope(child: BlockPuzzleApp(routerConfig: router)),
      );
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.byType(HomeHeader), findsOneWidget);
      expect(find.byType(HomeHeroCard), findsOneWidget);
      expect(find.text('GAME MODES'), findsOneWidget);
      expect(find.text('CLASSIC'), findsOneWidget);
      expect(find.text('LEVELS'), findsOneWidget);
      expect(find.text('TIME ATTACK'), findsOneWidget);
      expect(find.text('DAILY'), findsOneWidget);
      expect(find.text('ZEN MODE'), findsOneWidget);
      expect(find.byType(HomeShortcutsBar), findsOneWidget);
    });

    testWidgets('Tapping PLAY CLASSIC button in Hero card pushes GameScreen', (
      tester,
    ) async {
      final router = createAppRouter(initialLocation: AppRoutes.home);

      await tester.pumpWidget(
        ProviderScope(child: BlockPuzzleApp(routerConfig: router)),
      );
      await tester.pumpAndSettle();

      final playButton = find.text('PLAY CLASSIC');
      expect(playButton, findsOneWidget);

      await tester.tap(playButton);
      await tester.pumpAndSettle();

      expect(find.byType(GameScreen), findsOneWidget);
      expect(find.bySemanticsLabel('10 by 10 puzzle board'), findsOneWidget);
    });

    testWidgets(
      'Tapping Settings button in Header pushes Settings placeholder',
      (tester) async {
        final router = createAppRouter(initialLocation: AppRoutes.home);

        await tester.pumpWidget(
          ProviderScope(child: BlockPuzzleApp(routerConfig: router)),
        );
        await tester.pumpAndSettle();

        final settingsButton = find.byTooltip('Settings');
        expect(settingsButton, findsOneWidget);

        await tester.tap(settingsButton);
        await tester.pumpAndSettle();

        expect(find.byType(FeaturePlaceholderScreen), findsOneWidget);
        expect(find.text('Settings'), findsOneWidget);
      },
    );

    testWidgets('Tapping LEVELS card pushes Levels placeholder', (
      tester,
    ) async {
      final router = createAppRouter(initialLocation: AppRoutes.home);

      await tester.pumpWidget(
        ProviderScope(child: BlockPuzzleApp(routerConfig: router)),
      );
      await tester.pumpAndSettle();

      final levelsCard = find.text('LEVELS');
      expect(levelsCard, findsOneWidget);

      await tester.scrollUntilVisible(
        levelsCard,
        150,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.pumpAndSettle();

      await tester.tap(levelsCard);
      await tester.pumpAndSettle();

      expect(find.byType(FeaturePlaceholderScreen), findsOneWidget);
      expect(find.text('Levels & Progression'), findsOneWidget);
    });

    testWidgets('Tapping Stats shortcut pushes Statistics placeholder', (
      tester,
    ) async {
      final router = createAppRouter(initialLocation: AppRoutes.home);

      await tester.pumpWidget(
        ProviderScope(child: BlockPuzzleApp(routerConfig: router)),
      );
      await tester.pumpAndSettle();

      final statsShortcut = find.text('Stats');
      expect(statsShortcut, findsOneWidget);

      // Scroll to reveal shortcuts bar
      await tester.scrollUntilVisible(
        statsShortcut,
        200,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.pumpAndSettle();

      await tester.tap(statsShortcut);
      await tester.pumpAndSettle();

      expect(find.byType(FeaturePlaceholderScreen), findsOneWidget);
      expect(find.text('Player Statistics'), findsOneWidget);
    });
  });
}
