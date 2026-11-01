import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:blockpuzzle/app/block_puzzle_app.dart';

void main() {
  testWidgets('BlockPuzzleApp foundation screen smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: BlockPuzzleApp(),
      ),
    );

    expect(find.text('BLOCK PUZZLE'), findsOneWidget);
    expect(find.text('Project foundation ready.'), findsOneWidget);
  });
}
