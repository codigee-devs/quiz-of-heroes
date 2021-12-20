part of 'values.dart';

/// ------------------
/// Naming conventions
/// dimmensions should be sorted alphabetically and first part of it should be contain place where is used.
///  EXAMPLE
///  if we use sth menu icon in app header.
///   - feature name is "Menu",
///   - so it should name appHeader_headerHeight
///  if we want use back arrow in app header
///   - it's should name appHeader_backArrowSize
///   etc.
///
///  For common dimensions like padding, margin etc.
///  names should start not from feature_name, but with part of size like:
///     - xSmall = 0.25x base
///     - small = 0.5x base
///     - base = to be specified
///     - large = 1.5x base
///     - xLarge = 2x base
///     - xxLarge = 3x base
///     - custom+[dimens] for Example = customMargin76
///
///  EXAMPLE
///  baseEdgeInsets
///
abstract class AppDimensions {
  /// base space
  static const double baseSmallSpace = 8;
  static const double baseSpace = 16;
  static const double baseBigSpace = 32;
  static const double smallSpace = 8.0;

  /// edge insets
  static const double xSmallEdgeInsets2 = 2;
  static const double smallEdgeInsets4 = 4;
  static const double baseEdgeInsets8 = 8;
  static const double largeEdgeInsets12 = 12;
  static const double xLargeEdgeInsets16 = 16;
  static const double xxLargeEdgeInsets24 = 24;
  static const double xxLargeEdgeInsets48 = 48;
  static const double xxSuperLargeEdgeInsets80 = 80;

  // base page insets
  static const double basePageHorizontalInsets = 24;
  static const double basePageNoHorizontalInsets = 0;
  static const double characterPresentationHorizontalInsets = 46;
  static const double characterPresentationVerticalInsets = 20;
  static const double basePageVerticalInsets = 12;
  static const double quizWidgetBaseHeight = 250;
  static const double quizWidgetBaseWidth = double.infinity;

  /// specific dimens
  static const double baseAppBarSpacing = smallEdgeInsets4;
  static const double baseButtonCornerRadius = 12;
  static const double baseButtonElevation = 3.0;
  static const double baseGameWindowsCornerRadius = 5.0;
  static const double quizWidgetBorderSize = 2.0;
  static const double quizWidgetButtonsAxisSpacing = smallEdgeInsets4;
  static const double quizWidgetCornerRadius = 8.0;

/*   For the same buttons
  static const double buttonHeight = 48;
  static const double buttonHeightSmall = 36;
  */

  ///base radius
  static const double baseSmallRadius = 2;
  static const double baseRadius = 4;

  static const double baseAppBarBackButtonWidth = 80;
  static const double baseAppBarHeight = 43;

  static const double baseIntroButtonHeight = 65;
  static const double baseAppBaseButtonHeight = 75;
  static const double baseAppBaseButtonWidth = 500;
  static const double baseAppSmallAssetSize = 21;
  static const double baseAppSmallButtonSize = 50;

  static const double baseCharacterHeight = 175;

  static const double artefactInfoAssetHeight = 80;
  static const double creatingHeroTextFieldWidth = 245;
  static const double creatingHeroTextFieldHeight = 45;
  static const double creatingHeroButtonContinueHeight = 40;
  static const double creatingHeroButtonContnueWidth = 230;
  static const double baseAssetBuilderSize = 100.0;
  static const double baseCharacterSize = 150;
  static const double homeBigButtonHight = 65;
  static const double homeColumnWidth = 240;
  static const double homeHeight = 40;
  static const double homeLogoSize = 160;
  static const double homeSettingSize = 37;
  static const double homeTinyButtonWidth = 125;
  static const double loadHeroSize = 80;
  static const double menuButtonHeight = 30;
  static const double rankingStarAssetRatio = 0.07;
  static const double rankingStarAssetUserScoreSize = 30;
  static const double rankingHeroAssetRatio = 0.08;
  static const double rankingListMarginHorizontal = 30;
  static const double rankingListMarginVertical = 2;
  static const double rankingListContainerMarginHorizontal = 50;
  static const double rankingListContainerMarginVertical = 10;
  static const double rankingListUserScoreContainerBorderRadius = 3;
  static const double rankingListUserAssetSize = 40;
  static const double rankingRowHeight = 40;
  static const double rankingUserRowHeight = 60;
  static const double quizWidgetAnswerButtonHeight = quizWidgetAnswerButtonWidth * 0.144;
  static const double quizWidgetAnswerButtonWidth = 350.0;
  static const double quizWidgetArtefactInnerPadding = smallEdgeInsets4;
  static const double settingGameButtonHeight = 40;
  static const double settingGameButtonWidth = 180;
}
