import 'package:flutter/material.dart';

/// Temporary foundation screen to verify baseline application bootstrap.
///
/// This is not the final home screen and intentionally excludes game UI,
/// buttons, boards, or complex state.
class TemporaryFoundationScreen extends StatelessWidget {
  const TemporaryFoundationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'BLOCK PUZZLE',
              style: textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),
            Text(
              'Project foundation ready.',
              style: textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}

