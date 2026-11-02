/// Centralized registry for all validated production asset paths.
///
/// Ensures compile-time safety and prevents hardcoded path string drift.
abstract final class AssetPaths {
  const AssetPaths._();

  // Typography Families
  static const String fontFredoka = 'Fredoka';
  static const String fontNunito = 'Nunito';

  // UI Icons
  static const String iconHome = 'assets/images/ui/icons/icon_home.png';
  static const String iconPlay = 'assets/images/ui/icons/icon_play.png';
  static const String iconPause = 'assets/images/ui/icons/icon_pause.png';
  static const String iconSettings = 'assets/images/ui/icons/icon_settings.png';
  static const String iconSoundOn = 'assets/images/ui/icons/icon_sound_on.png';
  static const String iconSoundOff =
      'assets/images/ui/icons/icon_sound_off.png';
  static const String iconMusicOn = 'assets/images/ui/icons/icon_music_on.png';
  static const String iconMusicOff =
      'assets/images/ui/icons/icon_music_off.png';
  static const String iconTrophy = 'assets/images/ui/icons/icon_trophy.png';
  static const String iconLeaderboard =
      'assets/images/ui/icons/icon_leaderboard.png';
  static const String iconStatistics =
      'assets/images/ui/icons/icon_statistics.png';
  static const String iconMedal = 'assets/images/ui/icons/icon_medal.png';
  static const String iconStar = 'assets/images/ui/icons/icon_star.png';
  static const String iconShop = 'assets/images/ui/icons/icon_shop.png';
  static const String iconBack = 'assets/images/ui/icons/icon_back.png';
  static const String iconRestart = 'assets/images/ui/icons/icon_restart.png';
  static const String iconCheckmark =
      'assets/images/ui/icons/icon_checkmark.png';
  static const String iconClose = 'assets/images/ui/icons/icon_close.png';
  static const String iconInfo = 'assets/images/ui/icons/icon_info.png';
  static const String iconHelp = 'assets/images/ui/icons/icon_help.png';

  // VFX & Particles
  static const String particleSpark1 =
      'assets/images/effects/particles/particle_spark_01.png';
  static const String particleSpark2 =
      'assets/images/effects/particles/particle_spark_02.png';
  static const String particleStar1 =
      'assets/images/effects/particles/particle_star_01.png';
  static const String particleStar2 =
      'assets/images/effects/particles/particle_star_02.png';
  static const String particleFlare =
      'assets/images/effects/particles/particle_flare.png';
  static const String particleGlowCircle =
      'assets/images/effects/particles/particle_glow_circle.png';

  // Audio SFX
  static const String sfxUiClick = 'assets/audio/ui/sfx_ui_click.ogg';
  static const String sfxBlockPickup =
      'assets/audio/gameplay/sfx_block_pickup.ogg';
  static const String sfxBlockPlace =
      'assets/audio/gameplay/sfx_block_place.ogg';
  static const String sfxInvalidPlacement =
      'assets/audio/gameplay/sfx_invalid_placement.ogg';
  static const String sfxGameOver = 'assets/audio/gameplay/sfx_game_over.ogg';
  static const String sfxLineClear = 'assets/audio/clearing/sfx_line_clear.ogg';
  static const String sfxMultiClear =
      'assets/audio/clearing/sfx_multi_clear.ogg';
  static const String sfxCombo = 'assets/audio/clearing/sfx_combo.ogg';
  static const String sfxBoosterActivate =
      'assets/audio/rewards/sfx_booster_activate.ogg';
  static const String sfxNewRecord = 'assets/audio/rewards/sfx_new_record.ogg';
}
