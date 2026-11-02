import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:blockpuzzle/app/block_puzzle_app.dart';
import 'package:blockpuzzle/app/router/app_router.dart';
import 'package:blockpuzzle/features/home/presentation/home_screen.dart';
import 'package:blockpuzzle/features/splash/presentation/splash_screen.dart';
import 'package:blockpuzzle/features/splash/widgets/puzzle_logo_mark.dart';

void main() {
  group('SplashScreen Presentation & Animation Tests', () {
    testWidgets('SplashScreen renders logo, title, and tagline', (
      tester,
    ) async {
      await tester.pumpWidget(const ProviderScope(child: BlockPuzzleApp()));

      expect(find.byType(SplashScreen), findsOneWidget);
      expect(find.byType(PuzzleLogoMark), findsOneWidget);
      expect(find.text('BLOCK PUZZLE'), findsOneWidget);
      expect(find.text('PLACE. CLEAR. REPEAT.'), findsOneWidget);
    });

    testWidgets(
      'SplashScreen completes animation and navigates to HomeScreen',
      (tester) async {
        final router = createAppRouter();

        await tester.pumpWidget(
          ProviderScope(child: BlockPuzzleApp(routerConfig: router)),
        );

        expect(find.byType(SplashScreen), findsOneWidget);
        expect(find.byType(HomeScreen), findsNothing);

        // Advance past splash animation duration (1600ms)
        await tester.pump(const Duration(milliseconds: 1700));
        await tester.pumpAndSettle();

        expect(find.byType(HomeScreen), findsOneWidget);
      },
    );

    testWidgets(
      'SplashScreen immediately navigates when animations are disabled (reduced motion)',
      (tester) async {
        final router = createAppRouter();

        await tester.pumpWidget(
          ProviderScope(
            child: MediaQuery(
              data: const MediaQueryData(disableAnimations: true),
              child: BlockPuzzleApp(routerConfig: router),
            ),
          ),
        );

        // Initial frame triggers didChangeDependencies -> addPostFrameCallback
        await tester.pump();
        await tester.pumpAndSettle();

        expect(find.byType(HomeScreen), findsOneWidget);
      },
    );
  });
}
