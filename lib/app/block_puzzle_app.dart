import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import '../features/home/temporary_foundation_screen.dart';

/// Root widget for the Block Puzzle application.
class BlockPuzzleApp extends StatelessWidget {
  const BlockPuzzleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Block Puzzle',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const TemporaryFoundationScreen(),
    );
  }
}
