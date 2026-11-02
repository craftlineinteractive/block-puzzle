import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:blockpuzzle/core/constants/asset_paths.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AssetBundle rootBundle Loading Tests', () {
    test('Font binary assets load successfully via rootBundle', () async {
      final fredokaData = await rootBundle.load(
        'assets/fonts/fredoka/Fredoka.ttf',
      );
      expect(fredokaData.lengthInBytes, greaterThan(0));

      final nunitoData = await rootBundle.load(
        'assets/fonts/nunito/Nunito.ttf',
      );
      expect(nunitoData.lengthInBytes, greaterThan(0));
    });

    test('All UI Icon PNG assets load successfully via rootBundle', () async {
      final icons = [
        AssetPaths.iconHome,
        AssetPaths.iconPlay,
        AssetPaths.iconPause,
        AssetPaths.iconSettings,
        AssetPaths.iconSoundOn,
        AssetPaths.iconSoundOff,
        AssetPaths.iconMusicOn,
        AssetPaths.iconMusicOff,
        AssetPaths.iconTrophy,
        AssetPaths.iconLeaderboard,
        AssetPaths.iconStatistics,
        AssetPaths.iconMedal,
        AssetPaths.iconStar,
        AssetPaths.iconShop,
        AssetPaths.iconBack,
        AssetPaths.iconRestart,
        AssetPaths.iconCheckmark,
        AssetPaths.iconClose,
        AssetPaths.iconInfo,
        AssetPaths.iconHelp,
      ];

      for (final iconPath in icons) {
        final byteData = await rootBundle.load(iconPath);
        expect(
          byteData.lengthInBytes,
          greaterThan(0),
          reason: 'Failed to load icon from bundle: $iconPath',
        );
      }
    });

    test(
      'All VFX Particle PNG assets load successfully via rootBundle',
      () async {
        final particles = [
          AssetPaths.particleSpark1,
          AssetPaths.particleSpark2,
          AssetPaths.particleStar1,
          AssetPaths.particleStar2,
          AssetPaths.particleFlare,
          AssetPaths.particleGlowCircle,
        ];

        for (final particlePath in particles) {
          final byteData = await rootBundle.load(particlePath);
          expect(
            byteData.lengthInBytes,
            greaterThan(0),
            reason: 'Failed to load particle from bundle: $particlePath',
          );
        }
      },
    );

    test(
      'All Audio OGG sound effect assets load successfully via rootBundle',
      () async {
        final audioSfx = [
          AssetPaths.sfxUiClick,
          AssetPaths.sfxBlockPickup,
          AssetPaths.sfxBlockPlace,
          AssetPaths.sfxInvalidPlacement,
          AssetPaths.sfxGameOver,
          AssetPaths.sfxLineClear,
          AssetPaths.sfxMultiClear,
          AssetPaths.sfxCombo,
          AssetPaths.sfxBoosterActivate,
          AssetPaths.sfxNewRecord,
        ];

        for (final audioPath in audioSfx) {
          final byteData = await rootBundle.load(audioPath);
          expect(
            byteData.lengthInBytes,
            greaterThan(0),
            reason: 'Failed to load audio SFX from bundle: $audioPath',
          );
        }
      },
    );
  });
}
