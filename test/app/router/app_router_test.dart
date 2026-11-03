import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:blockpuzzle/app/block_puzzle_app.dart';
import 'package:blockpuzzle/app/router/app_router.dart';
import 'package:blockpuzzle/app/router/app_routes.dart';
import 'package:blockpuzzle/features/game/presentation/game_screen.dart';
import 'package:blockpuzzle/features/home/presentation/home_screen.dart';
import 'package:blockpuzzle/features/splash/presentation/splash_screen.dart';
import 'package:blockpuzzle/shared/widgets/feature_placeholder_screen.dart';

void main() {
  group('AppRouter Declarative Routing Tests', () {
    testWidgets('Initial route opens SplashScreen', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: BlockPuzzleApp()));
      expect(find.byType(SplashScreen), findsOneWidget);
    });

    testWidgets('Navigating to /home renders HomeScreen', (tester) async {
      final router = createAppRouter(initialLocation: AppRoutes.home);

      await tester.pumpWidget(
        ProviderScope(child: BlockPuzzleApp(routerConfig: router)),
      );
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('Classic route renders GameScreen', (tester) async {
      final router = createAppRouter(initialLocation: AppRoutes.classic);

      await tester.pumpWidget(
        ProviderScope(child: BlockPuzzleApp(routerConfig: router)),
      );
      await tester.pumpAndSettle();

      expect(find.byType(GameScreen), findsOneWidget);
      expect(find.bySemanticsLabel('10 by 10 puzzle board'), findsOneWidget);
    });

    testWidgets(
      'Settings route renders FeaturePlaceholderScreen with Settings info',
      (tester) async {
        final router = createAppRouter(initialLocation: AppRoutes.settings);

        await tester.pumpWidget(
          ProviderScope(child: BlockPuzzleApp(routerConfig: router)),
        );
        await tester.pumpAndSettle();

        expect(find.byType(FeaturePlaceholderScreen), findsOneWidget);
        expect(find.text('Settings'), findsOneWidget);
      },
    );

    testWidgets('Unknown route renders Page Not Found error page', (
      tester,
    ) async {
      final router = createAppRouter(initialLocation: '/unknown-route');

      await tester.pumpWidget(
        ProviderScope(child: BlockPuzzleApp(routerConfig: router)),
      );
      await tester.pumpAndSettle();

      expect(find.text('Page Not Found'), findsOneWidget);
      expect(find.text('Back to Home'), findsOneWidget);
    });

    testWidgets('Error page Back to Home button navigates to HomeScreen', (
      tester,
    ) async {
      final router = createAppRouter(initialLocation: '/unknown-route');

      await tester.pumpWidget(
        ProviderScope(child: BlockPuzzleApp(routerConfig: router)),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Back to Home'));
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });
}
