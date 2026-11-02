import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:blockpuzzle/app/block_puzzle_app.dart';
import 'package:blockpuzzle/core/theme/app_theme.dart';
import 'package:blockpuzzle/features/home/temporary_foundation_screen.dart';

void main() {
  group('Block Puzzle Foundation & App Startup Tests', () {
    test('BlockPuzzleApp can be instantiated', () {
      const app = BlockPuzzleApp();
      expect(app, isNotNull);
    });

    testWidgets(
      'ProviderScope initializes and mounts BlockPuzzleApp without exceptions',
      (tester) async {
        await tester.pumpWidget(const ProviderScope(child: BlockPuzzleApp()));

        // Verify no unexpected error widgets or exceptions thrown
        expect(tester.takeException(), isNull);
      },
    );

    testWidgets(
      'MaterialApp is configured with expected title, banner, and dark theme',
      (tester) async {
        await tester.pumpWidget(const ProviderScope(child: BlockPuzzleApp()));

        final materialAppFinder = find.byType(MaterialApp);
        expect(materialAppFinder, findsOneWidget);

        final materialApp = tester.widget<MaterialApp>(materialAppFinder);
        expect(materialApp.title, equals('Block Puzzle'));
        expect(materialApp.debugShowCheckedModeBanner, isFalse);
        expect(materialApp.theme?.useMaterial3, isTrue);
        expect(materialApp.theme?.brightness, equals(Brightness.dark));
        expect(
          materialApp.theme?.scaffoldBackgroundColor,
          equals(AppTheme.scaffoldBackground),
        );
      },
    );

    testWidgets('TemporaryFoundationScreen renders expected text and layout', (
      tester,
    ) async {
      await tester.pumpWidget(const ProviderScope(child: BlockPuzzleApp()));

      expect(find.byType(TemporaryFoundationScreen), findsOneWidget);
      expect(find.text('BLOCK PUZZLE'), findsOneWidget);
      expect(find.text('Project foundation ready.'), findsOneWidget);
    });

    testWidgets(
      'ProviderScope dependency injection operates correctly within widget tree',
      (tester) async {
        final statusProvider = Provider<String>((ref) => 'online_ready');
        late String resolvedStatus;

        await tester.pumpWidget(
          ProviderScope(
            child: Consumer(
              builder: (context, ref, child) {
                resolvedStatus = ref.watch(statusProvider);
                return const BlockPuzzleApp();
              },
            ),
          ),
        );

        expect(resolvedStatus, equals('online_ready'));
        expect(find.text('BLOCK PUZZLE'), findsOneWidget);
      },
    );
  });
}
