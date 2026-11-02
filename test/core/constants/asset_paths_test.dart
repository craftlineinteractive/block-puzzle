import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

import 'package:blockpuzzle/core/constants/asset_paths.dart';

void main() {
  group('AssetPaths & Manifest Verification Tests', () {
    final assetList = [
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
      AssetPaths.particleSpark1,
      AssetPaths.particleSpark2,
      AssetPaths.particleStar1,
      AssetPaths.particleStar2,
      AssetPaths.particleFlare,
      AssetPaths.particleGlowCircle,
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

    test('All AssetPaths constants point to existing production files', () {
      for (final path in assetList) {
        final file = File(path);
        expect(
          file.existsSync(),
          isTrue,
          reason: 'Missing asset file on disk: $path',
        );
      }
    });

    test('Font family files exist on disk', () {
      expect(File('assets/fonts/fredoka/Fredoka.ttf').existsSync(), isTrue);
      expect(File('assets/fonts/nunito/Nunito.ttf').existsSync(), isTrue);
    });

    test('Asset manifest JSON includes all AssetPaths files and fonts', () {
      final manifestFile = File('docs/asset_manifest.json');
      expect(manifestFile.existsSync(), isTrue);

      final manifestData =
          jsonDecode(manifestFile.readAsStringSync()) as Map<String, dynamic>;
      final assets = manifestData['assets'] as List<dynamic>;
      final manifestPaths = assets
          .map((a) => (a as Map<String, dynamic>)['path'] as String)
          .toSet();

      for (final path in assetList) {
        expect(
          manifestPaths.contains(path),
          isTrue,
          reason: 'Manifest missing asset: $path',
        );
      }
      expect(
        manifestPaths.contains('assets/fonts/fredoka/Fredoka.ttf'),
        isTrue,
      );
      expect(manifestPaths.contains('assets/fonts/nunito/Nunito.ttf'), isTrue);
    });
  });
}
