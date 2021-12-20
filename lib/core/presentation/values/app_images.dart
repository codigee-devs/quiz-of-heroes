part of 'values.dart';

/// ------------------
/// Naming conventions
/// images should be sorted alphabetically and first part of it should be contain place where is used.
///  EXAMPLE
///  if we use sth menu icon in app header.
///   - feature name is "Menu",
///   - so it should name appHeader_menu.svg
///  if we want use back arrow in app header
///   - it's should name appHeader_backArrow.svg
///   etc.
///
///  For common images, icons etc.
///  names should start not from feature_name, but from part 'app'
///  EXAMPLE
///  app_menu.svg
///
abstract class AppImages {
  static final _pngPath = 'assets/images/png';
  static final _svgPath = 'assets/images/svg';

  // svg images

  static final svgAppCoin = '$_svgPath/app_coin.svg';
  static final svgAppCoinLarge = '$_svgPath/app_coin_large.svg';
  static final svgAppDiamond = '$_svgPath/app_diamond.svg';
  static final svgAppDiamondLarge = '$_svgPath/app_diamond_large.svg';
  static final svgAppHeart = '$_svgPath/app_heart.svg';
  static final svgAppHero = '$_svgPath/app_hero.svg';
  static final svgAppHourglass = '$_svgPath/app_hourglass.svg';
  static final svgAppKey = '$_svgPath/app_key.svg';
  static final svgAppLife = '$_svgPath/app_life.svg';
  static final svgAppMenu = '$_svgPath/app_menu.svg';
  static final svgAppPaper = '$_svgPath/app_paper.svg';
  static final svgAppPoint = '$_svgPath/app_point.svg';
  static final svgAppPotion = '$_svgPath/app_potion.svg';
  static final svgAppRedPotion = '$_svgPath/app_red_potion.svg';
  static final svgAppSword = '$_svgPath/app_sword.svg';
  static final svgAppWarrior = '$_svgPath/app_warrior.svg';
  static final svgAppWitch = '$_svgPath/app_witch.svg';
  static final svgQuizExplosion = '$_svgPath/quiz_explosion.svg';
  static final svgQuizGameOverSkeleton = '$_svgPath/quiz_game_over_skeleton.svg';
  static final svgQuizResultCorrect = '$_svgPath/quiz_result_correct.svg';
  static final svgQuizResultOneMoreLife = '$_svgPath/quiz_result_one_more_life.svg';
  static final svgQuizResultSkull = '$_svgPath/quiz_result_skull.svg';
  static final svgQuizResultWrong = '$_svgPath/quiz_result_wrong.svg';
  static final svgSplashCodigee = '$_svgPath/splash_codigee.svg';

  // png images
  static final pngAppBackButton = '$_pngPath/app_back_button.png';
  static final pngAppBackButtonActive = '$_pngPath/app_back_button_active.png';
  static final pngAppButton = '$_pngPath/app_button.png';
  static final pngAppButtonActive = '$_pngPath/app_button_active.png';
  static final pngAppButtonLarge = '$_pngPath/app_button_large.png';
  static final pngAppButtonLargeActive = '$_pngPath/app_button_large_active.png';
  static final pngAppButtonTiny = '$_pngPath/app_button_tiny.png';
  static final pngAppButtonTinyActive = '$_pngPath/app_button_tiny_active.png';
  static final pngAppCancelButton = '$_pngPath/app_cancel_button.png';
  static final pngAppCancelButtonActive = '$_pngPath/app_cancel_button_active.png';
  static final pngHomePageGreenButton = '$_pngPath/home_green_button.png';
  static final pngHomePageGreenButtonActive = '$_pngPath/home_green_button_active.png';
  static final pngHomePageLogoOfCompany = '$_pngPath/home_logo_of_company.png';
  static final pngHomePageLogoOfGame = '$_pngPath/home_logo_of_game.png';
  static final pngHomePageSetting = '$_pngPath/home_button_setting.png';
  static final pngHomePageSettingActive = '$_pngPath/home_button_setting_active.png';
  static final pngHomePageStartButton = '$_pngPath/home_button_start.png';
  static final pngQuizArtefactButton = '$_pngPath/quiz_artefact_button.png';
  static final pngQuizArtefactButtonActive = '$_pngPath/quiz_artefact_button_active.png';
  static final pngQuizArtefactButtonDeactive = '$_pngPath/quiz_artefact_button_deactive.png';
  static final pngQuizArtefactCount = '$_pngPath/quiz_artefact_count.png';
  static final pngQuizConfirmButton = '$_pngPath/quiz_confirm_button.png';
  static final pngQuizConfirmButtonActive = '$_pngPath/quiz_confirm_button_active.png';
  static final pngQuizConfirmButtonDeactive = '$_pngPath/quiz_confirm_button_deactive.png';
  static final pngQuizDiamondArtefactButtonActive = '$_pngPath/diamond_quiz_artefact_button_active.png';
}
