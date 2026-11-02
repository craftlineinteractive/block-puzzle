import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../widgets/puzzle_logo_mark.dart';
import '../widgets/splash_tile_animation.dart';

/// Animated entry splash screen for Block Puzzle.
///
/// Features animated polyomino logo assembly, display typography, and
/// automatic seamless handoff to the Home screen with reduced-motion support.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _titleFadeAnimation;
  late final Animation<double> _taglineFadeAnimation;

  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );

    _titleFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.8, curve: Curves.easeOut),
      ),
    );

    _taglineFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.65, 0.95, curve: Curves.easeOut),
      ),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _navigateToHome();
      }
    });

    _controller.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Respect system reduced-motion or accessible navigation preferences
    final disableAnimations = MediaQuery.disableAnimationsOf(context);
    final accessibleNavigation = MediaQuery.accessibleNavigationOf(context);

    if (disableAnimations || accessibleNavigation) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _navigateToHome();
      });
    }
  }

  void _navigateToHome() {
    if (!mounted || _hasNavigated) return;
    _hasNavigated = true;
    context.go(AppRoutes.home);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.md,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Animated Logo Symbol
                      SplashTileAnimation(
                        animation: _controller,
                        child: const PuzzleLogoMark(size: 110),
                      ),
                      const SizedBox(height: AppSpacing.xl),

                      // Title with fade-in
                      FadeTransition(
                        opacity: _titleFadeAnimation,
                        child: Text(
                          'BLOCK PUZZLE',
                          textAlign: TextAlign.center,
                          style: AppTypography.displayLarge.copyWith(
                            letterSpacing: 2.0,
                            shadows: [
                              Shadow(
                                color: AppColors.primaryAccent.withValues(
                                  alpha: 0.45,
                                ),
                                blurRadius: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.smMd),

                      // Tagline with delayed fade-in
                      FadeTransition(
                        opacity: _taglineFadeAnimation,
                        child: Text(
                          'PLACE. CLEAR. REPEAT.',
                          textAlign: TextAlign.center,
                          style: AppTypography.bodySmall.copyWith(
                            letterSpacing: 3.2,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
