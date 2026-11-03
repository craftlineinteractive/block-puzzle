import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:blockpuzzle/features/game/presentation/models/game_screen_preview_data.dart';
import 'package:blockpuzzle/features/game/widgets/block_tray_preview.dart';
import 'package:blockpuzzle/features/game/widgets/preview_block_widget.dart';

void main() {
  group('Block Tray Preview Tests', () {
    testWidgets('BlockTrayPreview renders section header and 3 slots', (
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

    testWidgets('PreviewBlockWidget paints without layout exceptions', (
      tester,
    ) async {
      final sampleData = GameScreenPreviewData.samplePreview();
      final piece = sampleData.previewPieces.first;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 80,
                height: 80,
                child: PreviewBlockWidget(piece: piece),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(
        find.bySemanticsLabel('Preview piece ${piece.id}'),
        findsOneWidget,
      );
    });
  });
}
