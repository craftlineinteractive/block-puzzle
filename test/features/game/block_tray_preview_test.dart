import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:blockpuzzle/core/theme/app_colors.dart';
import 'package:blockpuzzle/features/game/presentation/models/game_screen_preview_data.dart';
import 'package:blockpuzzle/features/game/widgets/block_tray_preview.dart';
import 'package:blockpuzzle/features/game/widgets/preview_block_widget.dart';

void main() {
  group('BlockTrayPreview & Polyomino Piece Preview Tests', () {
    testWidgets('BlockTrayPreview renders header and exactly 3 slots', (
      tester,
    ) async {
      final sampleData = GameScreenPreviewData.samplePreview();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 360,
                child: BlockTrayPreview(pieces: sampleData.previewPieces),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('YOUR NEXT BLOCKS'), findsOneWidget);
      expect(find.byType(BlockTrayPreview), findsOneWidget);
      expect(find.byType(PreviewBlockWidget), findsNWidgets(3));
      expect(
        find.byWidgetPredicate(
          (w) => w is Semantics && w.properties.label == 'Piece preview tray',
        ),
        findsOneWidget,
      );
    });

    testWidgets(
      'PreviewBlockWidget paints line, square, and L pieces cleanly',
      (tester) async {
        const linePiece = PreviewPiece(
          id: 'test_line',
          matrix: [
            [true, true, true, true],
          ],
          color: AppColors.blockCyan,
        );

        const squarePiece = PreviewPiece(
          id: 'test_square',
          matrix: [
            [true, true],
            [true, true],
          ],
          color: AppColors.blockYellow,
        );

        const lPiece = PreviewPiece(
          id: 'test_l',
          matrix: [
            [true, false],
            [true, false],
            [true, true],
          ],
          color: AppColors.blockPink,
        );

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: Row(
                children: [
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: PreviewBlockWidget(piece: linePiece),
                  ),
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: PreviewBlockWidget(piece: squarePiece),
                  ),
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: PreviewBlockWidget(piece: lPiece),
                  ),
                ],
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull);
        expect(
          find.bySemanticsLabel('Preview piece test_line'),
          findsOneWidget,
        );
        expect(
          find.bySemanticsLabel('Preview piece test_square'),
          findsOneWidget,
        );
        expect(find.bySemanticsLabel('Preview piece test_l'), findsOneWidget);
      },
    );

    testWidgets('PreviewBlockWidget handles empty matrix gracefully', (
      tester,
    ) async {
      const emptyPiece = PreviewPiece(
        id: 'empty_piece',
        matrix: [],
        color: AppColors.blockRed,
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 80,
                height: 80,
                child: PreviewBlockWidget(piece: emptyPiece),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
    });
  });
}
