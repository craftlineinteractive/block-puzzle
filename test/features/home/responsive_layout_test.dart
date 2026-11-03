import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:blockpuzzle/app/block_puzzle_app.dart';
import 'package:blockpuzzle/app/router/app_router.dart';
import 'package:blockpuzzle/app/router/app_routes.dart';
import 'package:blockpuzzle/features/home/presentation/home_screen.dart';
import 'package:blockpuzzle/features/splash/presentation/splash_screen.dart';

void main() {
  group('Phase 03B Responsive Layout & Overflow Audit', () {
    const testScreenSizes = <String, Size>{
      'Narrow phone (320x568)': Size(320, 568),
      'Standard small Android (360x640)': Size(360, 640),
      'Standard modern phone (393x852)': Size(393, 852),
      'Large phone (430x932)': Size(430, 932),
      'Tablet / Wide (600x960)': Size(600, 960),
    };

    for (final entry in testScreenSizes.entries) {
      final label = entry.key;
      final size = entry.value;

      testWidgets('HomeScreen renders with zero overflow on $label', (
        tester,
      ) async {
        tester.view.physicalSize = size * 2.0; // Assume 2.0 device pixel ratio
        tester.view.devicePixelRatio = 2.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        final router = createAppRouter(initialLocation: AppRoutes.home);

        await tester.pumpWidget(
          ProviderScope(child: BlockPuzzleApp(routerConfig: router)),
        );
        await tester.pumpAndSettle();

        expect(find.byType(HomeScreen), findsOneWidget);
        final exception = tester.takeException();
        if (exception is FlutterError) {
          debugPrint(exception.toStringDeep());
        }
        expect(exception, isNull);
      });

      testWidgets('SplashScreen renders with zero overflow on $label', (
        tester,
      ) async {
        tester.view.physicalSize = size * 2.0;
        tester.view.devicePixelRatio = 2.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        final router = createAppRouter(initialLocation: AppRoutes.splash);

        await tester.pumpWidget(
          ProviderScope(child: BlockPuzzleApp(routerConfig: router)),
        );

        expect(find.byType(SplashScreen), findsOneWidget);
        final exception = tester.takeException();
        if (exception is FlutterError) {
          debugPrint(exception.toStringDeep());
        }
        expect(exception, isNull);
      });
    }

    testWidgets('HomeScreen handles large font scale (1.5x) without overflow', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(393 * 2.0, 852 * 2.0);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final router = createAppRouter(initialLocation: AppRoutes.home);

      await tester.pumpWidget(
        ProviderScope(
          child: MediaQuery(
            data: const MediaQueryData(
              size: Size(393, 852),
              textScaler: TextScaler.linear(1.5),
            ),
            child: BlockPuzzleApp(routerConfig: router),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
