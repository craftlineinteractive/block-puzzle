import 'package:flutter/material.dart';

/// Animated wrapper delivering a staggered scale, fade, and slight entrance slide
/// for the splash puzzle logo mark.
class SplashTileAnimation extends StatelessWidget {
  const SplashTileAnimation({
    super.key,
    required this.animation,
    required this.child,
  });

  /// Master animation controller driving the splash entrance.
  final Animation<double> animation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scaleAnimation = Tween<double>(begin: 0.65, end: 1.0).animate(
      CurvedAnimation(
        parent: animation,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOutBack),
      ),
    );

    final opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animation,
        curve: const Interval(0.0, 0.45, curve: Curves.easeIn),
      ),
    );

    return AnimatedBuilder(
      animation: animation,
      builder: (context, staticChild) {
        return Opacity(
          opacity: opacityAnimation.value,
          child: Transform.scale(
            scale: scaleAnimation.value,
            child: staticChild,
          ),
        );
      },
      child: child,
    );
  }
}
