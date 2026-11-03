import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:blockpuzzle/features/game/presentation/models/game_screen_preview_data.dart';
import 'package:blockpuzzle/features/game/presentation/painters/board_painter.dart';
import 'package:blockpuzzle/features/game/widgets/board_widget.dart';

void main() {
  group('10x10 Board UI & Painter Tests', () {
    test('BoardPainter constants ensure strictly 100 cells', () {
      expect(BoardPainter.rows, equals(10));
      expect(BoardPainter.cols, equals(10));
      expect(BoardPainter.totalCells, equals(100));
    });

    testWidgets(
      'BoardWidget renders with semantics label and RepaintBoundary',
      (tester) async {
        final emptyData = GameScreenPreviewData.empty();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: SizedBox(
                  width: 320,
                  height: 320,
                  child: BoardWidget(grid: emptyData.grid),
                ),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(BoardWidget), findsOneWidget);
        expect(find.bySemanticsLabel('10 by 10 puzzle board'), findsOneWidget);
        expect(find.byType(RepaintBoundary), findsWidgets);
        expect(find.byType(CustomPaint), findsWidgets);
      },
    );

    testWidgets('BoardWidget renders sample preview grid without errors', (
      tester,
    ) async {
      final sampleData = GameScreenPreviewData.samplePreview();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 360,
                height: 360,
                child: BoardWidget(grid: sampleData.grid),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
    });

    test('BoardPainter shouldRepaint returns false for identical grid', () {
      final emptyData = GameScreenPreviewData.empty();
      final painter1 = BoardPainter(grid: emptyData.grid);
      final painter2 = BoardPainter(grid: emptyData.grid);

      expect(painter2.shouldRepaint(painter1), isFalse);
    });

    test(
      'BoardPainter shouldRepaint returns true when grid contents differ',
      () {
        final emptyData = GameScreenPreviewData.empty();
        final sampleData = GameScreenPreviewData.samplePreview();

        final painter1 = BoardPainter(grid: emptyData.grid);
        final painter2 = BoardPainter(grid: sampleData.grid);

        expect(painter2.shouldRepaint(painter1), isTrue);
      },
    );

    test(
      'BoardPainter shouldRepaint returns true when gap or radius differs',
      () {
        final emptyData = GameScreenPreviewData.empty();
        final painter1 = BoardPainter(grid: emptyData.grid, gap: 2.0);
        final painter2 = BoardPainter(grid: emptyData.grid, gap: 3.5);

        expect(painter2.shouldRepaint(painter1), isTrue);
      },
    );
  });
}
