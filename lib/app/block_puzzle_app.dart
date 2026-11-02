import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/theme/app_theme.dart';
import 'router/app_router.dart';

/// Root widget for the Block Puzzle application.
class BlockPuzzleApp extends ConsumerWidget {
  const BlockPuzzleApp({super.key, this.routerConfig});

  /// Optional router override for independent widget testing.
  final RouterConfig<Object>? routerConfig;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = routerConfig ?? ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Block Puzzle',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routerConfig: router,
    );
  }
}
