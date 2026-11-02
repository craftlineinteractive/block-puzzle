import 'package:flutter/material.dart';

import '../../shared/widgets/design_system_preview.dart';

/// Temporary foundation screen to verify baseline application bootstrap.
///
/// This is not the final home screen and intentionally excludes game UI,
/// boards, or complex state, while providing navigation to the design system preview.
class TemporaryFoundationScreen extends StatelessWidget {
  const TemporaryFoundationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('BLOCK PUZZLE', style: textTheme.headlineMedium),
              const SizedBox(height: 12),
              Text('Project foundation ready.', style: textTheme.bodyLarge),
              const SizedBox(height: 32),
              FilledButton.icon(
                icon: const Icon(Icons.palette_outlined),
                label: const Text('View Design System'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const DesignSystemPreview(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
