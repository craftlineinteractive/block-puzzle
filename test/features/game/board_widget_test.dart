import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:blockpuzzle/core/theme/app_colors.dart';
import 'package:blockpuzzle/features/game/presentation/models/game_screen_preview_data.dart';
import 'package:blockpuzzle/features/game/presentation/painters/board_painter.dart';
import 'package:blockpuzzle/features/game/widgets/board_widget.dart';

void main() {
  group('BoardWidget & Board Geometry Tests', () {
    test('BoardPainter constants enforce exactly 10x10 (100 cells)', () {
      expect(BoardPainter.rows, equals(10));
      expect(BoardPainter.cols, equals(10));
      expect(BoardPainter.totalCells, equals(100));
    });

    testWidgets(
      'BoardWidget enforces strict 1:1 square aspect ratio in non-square box',
      (tester) async {
        final emptyData = GameScreenPreviewData.empty();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: SizedBox(
                  width: 320,
                  height: 500, // Non-square parent box
                  child: BoardWidget(grid: emptyData.grid),
                ),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        final aspectRatioFinder = find.descendant(
          of: find.byType(BoardWidget),
          matching: find.byType(AspectRatio),
        );
        expect(aspectRatioFinder, findsOneWidget);

        final renderBox = tester.renderObject<RenderBox>(aspectRatioFinder);
        expect(renderBox.size.width, equals(renderBox.size.height));
        expect(renderBox.size.width, equals(320.0));
        expect(renderBox.size.height, equals(320.0));
      },
    );

    testWidgets(
      'BoardWidget renders all four corners and edge cells without error',
      (tester) async {
        final grid = List.generate(
          BoardPainter.rows,
          (_) => List.generate(BoardPainter.cols, (_) => null as Color?),
        );

        // Four corners
        grid[0][0] = AppColors.blockRed; // Top-left
        grid[0][9] = AppColors.blockBlue; // Top-right
        grid[9][0] = AppColors.blockGreen; // Bottom-left
        grid[9][9] = AppColors.blockYellow; // Bottom-right

        // Edge cells
        grid[0][4] = AppColors.blockPink; // First row center
        grid[9][4] = AppColors.blockCyan; // Last row center
        grid[4][0] = AppColors.blockPurple; // First col center
        grid[4][9] = AppColors.blockOrange; // Last col center

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: SizedBox(
                  width: 360,
                  height: 360,
                  child: BoardWidget(grid: grid),
                ),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull);
        expect(find.bySemanticsLabel('10 by 10 puzzle board'), findsOneWidget);
      },
    );

    testWidgets('BoardWidget wraps CustomPaint inside RepaintBoundary', (
      tester,
    ) async {
      final emptyData = GameScreenPreviewData.empty();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 300,
                height: 300,
                child: BoardWidget(grid: emptyData.grid),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final repaintBoundaryFinder = find.descendant(
        of: find.byType(BoardWidget),
        matching: find.byType(RepaintBoundary),
      );
      expect(repaintBoundaryFinder, findsWidgets);

      final customPaintFinder = find.descendant(
        of: find.byType(BoardWidget),
        matching: find.byType(CustomPaint),
      );
      expect(customPaintFinder, findsWidgets);
    });

    test('BoardPainter shouldRepaint deep equality behavior', () {
      final empty1 = GameScreenPreviewData.empty();
      final empty2 = GameScreenPreviewData.empty();
      final sample = GameScreenPreviewData.samplePreview();

      final painter1 = BoardPainter(grid: empty1.grid);
      final painter2 = BoardPainter(grid: empty1.grid); // Identical reference
      final painter3 = BoardPainter(
        grid: empty2.grid,
      ); // Equal matrix, different instance
      final painter4 = BoardPainter(grid: sample.grid); // Different content

      // Reference equality -> false
      expect(painter2.shouldRepaint(painter1), isFalse);

      // Structural equality -> false
      expect(painter3.shouldRepaint(painter1), isFalse);

      // Modified cells -> true
      expect(painter4.shouldRepaint(painter1), isTrue);

      // Changed parameters -> true
      final painterParamChange = BoardPainter(grid: empty1.grid, gap: 5.0);
      expect(painterParamChange.shouldRepaint(painter1), isTrue);
    });
  });
}
