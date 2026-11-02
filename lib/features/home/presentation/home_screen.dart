import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../widgets/game_modes_section.dart';
import '../widgets/home_background_decoration.dart';
import '../widgets/home_header.dart';
import '../widgets/home_hero_card.dart';
import '../widgets/home_shortcut_tile.dart';

/// Casual arcade puzzle game home screen.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Ambient arcade lighting accents
          const HomeBackgroundDecoration(),

          // Main scrollable content
          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 580),
                child: const SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top branding and settings header
                      HomeHeader(),
                      SizedBox(height: AppSpacing.md),

                      // Featured Play Hero Card
                      HomeHeroCard(),
                      SizedBox(height: AppSpacing.xl),

                      // Game Mode Grid (Classic, Levels, Time Attack, Daily, Zen)
                      GameModesSection(),
                      SizedBox(height: AppSpacing.xl),

                      // Quick shortcuts (Stats, Themes, Trophies)
                      HomeShortcutsBar(),
                      SizedBox(height: AppSpacing.xxl),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
