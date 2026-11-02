import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:blockpuzzle/core/theme/app_theme.dart';
import 'package:blockpuzzle/shared/widgets/design_system_preview.dart';

void main() {
  testWidgets('DesignSystemPreview renders all design sections cleanly', (
    tester,
  ) async {
    // Set a realistic mobile device screen size (390 x 844, iPhone 12/13/14 scale)
    tester.view.physicalSize = const Size(1170, 2532);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(theme: AppTheme.darkTheme, home: const DesignSystemPreview()),
    );

    await tester.pumpAndSettle();

    expect(find.text('Design System Preview'), findsOneWidget);
    expect(find.text('1. Color Palette & Surfaces'), findsOneWidget);
    expect(find.text('2. Polyomino Block Colors'), findsOneWidget);
    expect(find.text('3. Typography Hierarchy'), findsOneWidget);
    expect(
      find.text('4. Buttons & Interactive Targets (Min 48px)'),
      findsOneWidget,
    );
    expect(find.text('5. Corner Radii & Panels'), findsOneWidget);
    expect(find.text('6. Imported Game Icons'), findsOneWidget);

    expect(find.text('PLAY NOW'), findsOneWidget);
    expect(find.text('SETTINGS'), findsOneWidget);
    expect(find.text('Score: 12,480'), findsOneWidget);

    expect(tester.takeException(), isNull);
  });
}
