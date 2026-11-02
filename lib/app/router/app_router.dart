import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';
import '../../shared/widgets/design_system_preview.dart';
import '../../shared/widgets/feature_placeholder_screen.dart';
import 'app_routes.dart';

/// Helper to build consistent arcade fade transitions between game screens.
CustomTransitionPage<void> _buildGameTransitionPage({
  required LocalKey key,
  required Widget child,
}) {
  return CustomTransitionPage<void>(
    key: key,
    child: child,
    transitionDuration: const Duration(milliseconds: 250),
    reverseTransitionDuration: const Duration(milliseconds: 200),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final fadeAnimation = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      );
      final slideAnimation = Tween<Offset>(
        begin: const Offset(0.04, 0),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic));

      return FadeTransition(
        opacity: fadeAnimation,
        child: SlideTransition(position: slideAnimation, child: child),
      );
    },
  );
}

/// Factory function to create a configured [GoRouter] instance.
GoRouter createAppRouter({
  String initialLocation = AppRoutes.splash,
  List<NavigatorObserver>? observers,
}) {
  return GoRouter(
    initialLocation: initialLocation,
    observers: observers,
    routes: [
      // Splash Screen
      GoRoute(
        path: AppRoutes.splash,
        name: AppRoutes.splashName,
        builder: (context, state) => const SplashScreen(),
      ),

      // Home Screen
      GoRoute(
        path: AppRoutes.home,
        name: AppRoutes.homeName,
        pageBuilder: (context, state) => _buildGameTransitionPage(
          key: state.pageKey,
          child: const HomeScreen(),
        ),
      ),

      // Classic Game Mode Placeholder
      GoRoute(
        path: AppRoutes.classic,
        name: AppRoutes.classicName,
        pageBuilder: (context, state) => _buildGameTransitionPage(
          key: state.pageKey,
          child: FeaturePlaceholderScreen.fromRoute(AppRoutes.classic),
        ),
      ),

      // Levels Game Mode Placeholder
      GoRoute(
        path: AppRoutes.levels,
        name: AppRoutes.levelsName,
        pageBuilder: (context, state) => _buildGameTransitionPage(
          key: state.pageKey,
          child: FeaturePlaceholderScreen.fromRoute(AppRoutes.levels),
        ),
      ),

      // Time Attack Game Mode Placeholder
      GoRoute(
        path: AppRoutes.timeAttack,
        name: AppRoutes.timeAttackName,
        pageBuilder: (context, state) => _buildGameTransitionPage(
          key: state.pageKey,
          child: FeaturePlaceholderScreen.fromRoute(AppRoutes.timeAttack),
        ),
      ),

      // Daily Challenge Game Mode Placeholder
      GoRoute(
        path: AppRoutes.dailyChallenge,
        name: AppRoutes.dailyChallengeName,
        pageBuilder: (context, state) => _buildGameTransitionPage(
          key: state.pageKey,
          child: FeaturePlaceholderScreen.fromRoute(AppRoutes.dailyChallenge),
        ),
      ),

      // Zen Game Mode Placeholder
      GoRoute(
        path: AppRoutes.zen,
        name: AppRoutes.zenName,
        pageBuilder: (context, state) => _buildGameTransitionPage(
          key: state.pageKey,
          child: FeaturePlaceholderScreen.fromRoute(AppRoutes.zen),
        ),
      ),

      // Statistics Placeholder
      GoRoute(
        path: AppRoutes.statistics,
        name: AppRoutes.statisticsName,
        pageBuilder: (context, state) => _buildGameTransitionPage(
          key: state.pageKey,
          child: FeaturePlaceholderScreen.fromRoute(AppRoutes.statistics),
        ),
      ),

      // Themes Placeholder
      GoRoute(
        path: AppRoutes.themes,
        name: AppRoutes.themesName,
        pageBuilder: (context, state) => _buildGameTransitionPage(
          key: state.pageKey,
          child: FeaturePlaceholderScreen.fromRoute(AppRoutes.themes),
        ),
      ),

      // Achievements Placeholder
      GoRoute(
        path: AppRoutes.achievements,
        name: AppRoutes.achievementsName,
        pageBuilder: (context, state) => _buildGameTransitionPage(
          key: state.pageKey,
          child: FeaturePlaceholderScreen.fromRoute(AppRoutes.achievements),
        ),
      ),

      // Settings Placeholder
      GoRoute(
        path: AppRoutes.settings,
        name: AppRoutes.settingsName,
        pageBuilder: (context, state) => _buildGameTransitionPage(
          key: state.pageKey,
          child: FeaturePlaceholderScreen.fromRoute(AppRoutes.settings),
        ),
      ),

      // Design System Preview Route (Development verification)
      GoRoute(
        path: AppRoutes.designPreview,
        name: AppRoutes.designPreviewName,
        pageBuilder: (context, state) => _buildGameTransitionPage(
          key: state.pageKey,
          child: const DesignSystemPreview(),
        ),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline_rounded,
                size: 64,
                color: AppColors.error,
              ),
              const SizedBox(height: 16),
              Text('Page Not Found', style: AppTypography.displaySmall),
              const SizedBox(height: 8),
              Text(
                'The requested route (${state.uri.path}) does not exist.',
                textAlign: TextAlign.center,
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryAccent,
                  foregroundColor: Colors.white,
                ),
                onPressed: () => context.go(AppRoutes.home),
                icon: const Icon(Icons.home_rounded),
                label: const Text('Back to Home'),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

/// Riverpod provider delivering the application's singleton [GoRouter] instance.
final appRouterProvider = Provider<GoRouter>((ref) {
  final router = createAppRouter();
  ref.onDispose(router.dispose);
  return router;
});
