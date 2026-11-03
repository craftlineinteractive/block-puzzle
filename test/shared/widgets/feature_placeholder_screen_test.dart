import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:blockpuzzle/app/block_puzzle_app.dart';
import 'package:blockpuzzle/app/router/app_router.dart';
import 'package:blockpuzzle/app/router/app_routes.dart';
import 'package:blockpuzzle/features/home/presentation/home_screen.dart';
import 'package:blockpuzzle/shared/widgets/feature_placeholder_screen.dart';

void main() {
  group('FeaturePlaceholderScreen Tests', () {
    testWidgets('Renders correct metadata for Classic route', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FeaturePlaceholderScreen.fromRoute(AppRoutes.classic),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(FeaturePlaceholderScreen), findsOneWidget);
      expect(find.text('Classic Mode'), findsOneWidget);
      expect(find.text('CORE GAMEPLAY IN DEVELOPMENT'), findsOneWidget);
      expect(
        find.textContaining('The core 10x10 puzzle board'),
        findsOneWidget,
      );
      expect(find.text('Back to Home'), findsOneWidget);
    });

    testWidgets('Renders correct metadata for Zen route', (tester) async {
      final router = createAppRouter(initialLocation: AppRoutes.zen);

      await tester.pumpWidget(
        ProviderScope(child: BlockPuzzleApp(routerConfig: router)),
      );
      await tester.pumpAndSettle();

      expect(find.byType(FeaturePlaceholderScreen), findsOneWidget);
      expect(find.text('Zen Mode'), findsOneWidget);
      expect(find.text('RELAXED MODE IN PLANNING'), findsOneWidget);
    });

    testWidgets('Tapping Back to Home returns to HomeScreen', (tester) async {
      final router = createAppRouter(initialLocation: AppRoutes.home);

      await tester.pumpWidget(
        ProviderScope(child: BlockPuzzleApp(routerConfig: router)),
      );
      await tester.pumpAndSettle();

      // Scroll to levels card
      final levelsFinder = find.text('LEVELS');
      await tester.scrollUntilVisible(
        levelsFinder,
        150,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.pumpAndSettle();

      await tester.tap(levelsFinder);
      await tester.pumpAndSettle();
      expect(find.byType(FeaturePlaceholderScreen), findsOneWidget);

      // Tap Back to Home
      await tester.tap(find.text('Back to Home'));
      await tester.pumpAndSettle();
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('Tapping AppBar back icon returns to HomeScreen', (
      tester,
    ) async {
      final router = createAppRouter(initialLocation: AppRoutes.home);

      await tester.pumpWidget(
        ProviderScope(child: BlockPuzzleApp(routerConfig: router)),
      );
      await tester.pumpAndSettle();

      // Scroll to Time Attack card
      final timeAttackFinder = find.text('TIME ATTACK');
      await tester.scrollUntilVisible(
        timeAttackFinder,
        150,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.pumpAndSettle();

      await tester.tap(timeAttackFinder);
      await tester.pumpAndSettle();
      expect(find.byType(FeaturePlaceholderScreen), findsOneWidget);

      // Tap AppBar leading back icon
      final backButton = find.byTooltip('Back to Home');
      expect(backButton, findsOneWidget);

      await tester.tap(backButton);
      await tester.pumpAndSettle();
      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });
}
