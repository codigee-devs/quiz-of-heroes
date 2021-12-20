import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../values/values.dart';

part 'app_button_style.freezed.dart';

@freezed
class AppButtonStyle with _$AppButtonStyle {
  const factory AppButtonStyle({
    required ImageProvider backgroundImage,
    required BoxFit boxFit,
    double? height,
    double? width,
    ImageProvider? activeBackgroundImage,
    ImageProvider? deactiveBackgroundImage,
  }) = _AppButtonStyle;

  factory AppButtonStyle.artefactsButton() => AppButtonStyle(
        activeBackgroundImage: AssetImage(AppImages.pngQuizArtefactButtonActive),
        backgroundImage: AssetImage(AppImages.pngQuizArtefactButton),
        boxFit: BoxFit.contain,
        height: AppDimensions.baseAppSmallButtonSize,
        width: AppDimensions.baseAppSmallButtonSize,
      );

  factory AppButtonStyle.base() => AppButtonStyle(
      boxFit: BoxFit.contain,
      backgroundImage: AssetImage(AppImages.pngAppButton),
      activeBackgroundImage: AssetImage(AppImages.pngAppButtonActive),
      height: AppDimensions.baseAppBaseButtonHeight,
      width: AppDimensions.baseAppBaseButtonWidth);

  factory AppButtonStyle.baseBackButton() => AppButtonStyle(
      boxFit: BoxFit.fill,
      backgroundImage: AssetImage(AppImages.pngAppBackButton),
      activeBackgroundImage: AssetImage(AppImages.pngAppBackButtonActive),
      height: AppDimensions.baseAppBarHeight,
      width: AppDimensions.baseAppBarBackButtonWidth);

  factory AppButtonStyle.baseCancelButton() => AppButtonStyle(
      boxFit: BoxFit.fill,
      backgroundImage: AssetImage(AppImages.pngAppCancelButton),
      activeBackgroundImage: AssetImage(AppImages.pngAppCancelButton),
      height: AppDimensions.baseAppBarHeight,
      width: AppDimensions.baseAppBarHeight);

  factory AppButtonStyle.characterPresentationButton() => AppButtonStyle(
      backgroundImage: AssetImage(AppImages.pngAppButtonLarge),
      activeBackgroundImage: AssetImage(AppImages.pngAppButtonLargeActive),
      boxFit: BoxFit.contain,
      height: AppDimensions.baseAppBaseButtonHeight,
      width: double.infinity);

  factory AppButtonStyle.introButton() => AppButtonStyle(
      backgroundImage: AssetImage(AppImages.pngAppButtonLarge),
      activeBackgroundImage: AssetImage(AppImages.pngAppButtonLargeActive),
      boxFit: BoxFit.fitWidth,
      height: AppDimensions.baseIntroButtonHeight,
      width: double.infinity);

  factory AppButtonStyle.creatingHeroContinueButton() => AppButtonStyle(
      activeBackgroundImage: AssetImage(AppImages.pngAppButtonActive),
      backgroundImage: AssetImage(AppImages.pngAppButton),
      boxFit: BoxFit.fill,
      height: AppDimensions.creatingHeroButtonContinueHeight,
      width: AppDimensions.creatingHeroButtonContnueWidth);

  factory AppButtonStyle.homeBigButton() => AppButtonStyle(
        activeBackgroundImage: AssetImage(AppImages.pngAppButtonActive),
        backgroundImage: AssetImage(AppImages.pngHomePageStartButton),
        boxFit: BoxFit.fill,
        height: AppDimensions.homeBigButtonHight,
        width: AppDimensions.homeColumnWidth,
      );

  factory AppButtonStyle.homeBigGreenButton() => AppButtonStyle(
        activeBackgroundImage: AssetImage(AppImages.pngHomePageGreenButtonActive),
        backgroundImage: AssetImage(AppImages.pngHomePageGreenButton),
        boxFit: BoxFit.fill,
        height: AppDimensions.homeBigButtonHight,
        width: AppDimensions.homeColumnWidth,
      );
  factory AppButtonStyle.homeLogoButton() => AppButtonStyle(
        activeBackgroundImage: AssetImage(AppImages.pngHomePageLogoOfCompany),
        backgroundImage: AssetImage(AppImages.pngHomePageLogoOfCompany),
        boxFit: BoxFit.contain,
        height: AppDimensions.homeHeight,
        width: AppDimensions.baseAppBaseButtonWidth,
      );

  factory AppButtonStyle.homeSettingsButton() => AppButtonStyle(
        activeBackgroundImage: AssetImage(AppImages.pngHomePageSettingActive),
        backgroundImage: AssetImage(AppImages.pngHomePageSetting),
        boxFit: BoxFit.contain,
        height: AppDimensions.homeSettingSize,
        width: AppDimensions.homeSettingSize,
      );

  factory AppButtonStyle.homeSmallButton() => AppButtonStyle(
        activeBackgroundImage: AssetImage(AppImages.pngAppButtonActive),
        backgroundImage: AssetImage(AppImages.pngAppButton),
        boxFit: BoxFit.contain,
        height: AppDimensions.homeHeight,
        width: AppDimensions.homeColumnWidth,
      );
  factory AppButtonStyle.homeTinyButton() => AppButtonStyle(
        activeBackgroundImage: AssetImage(AppImages.pngAppButtonTinyActive),
        backgroundImage: AssetImage(AppImages.pngAppButtonTiny),
        boxFit: BoxFit.contain,
        height: AppDimensions.homeHeight,
        width: AppDimensions.homeTinyButtonWidth,
      );

  factory AppButtonStyle.quizAnswerButton() => AppButtonStyle(
        activeBackgroundImage: AssetImage(AppImages.pngAppButtonActive),
        backgroundImage: AssetImage(AppImages.pngAppButton),
        boxFit: BoxFit.fitWidth,
        width: AppDimensions.quizWidgetAnswerButtonWidth,
      );

  factory AppButtonStyle.quizConfirmButton({required double width, required double height}) => AppButtonStyle(
        activeBackgroundImage: AssetImage(AppImages.pngQuizConfirmButtonActive),
        backgroundImage: AssetImage(AppImages.pngQuizConfirmButton),
        deactiveBackgroundImage: AssetImage(AppImages.pngQuizConfirmButtonDeactive),
        boxFit: BoxFit.fitHeight,
        height: height,
        width: width,
      );
  factory AppButtonStyle.storyListButton() => AppButtonStyle(
      activeBackgroundImage: AssetImage(AppImages.pngAppButtonActive),
      backgroundImage: AssetImage(AppImages.pngAppButton),
      boxFit: BoxFit.contain,
      height: AppDimensions.settingGameButtonHeight,
      width: 80);

  factory AppButtonStyle.settingGameButton() => AppButtonStyle(
      activeBackgroundImage: AssetImage(AppImages.pngAppButtonActive),
      backgroundImage: AssetImage(AppImages.pngAppButton),
      boxFit: BoxFit.fill,
      height: AppDimensions.settingGameButtonHeight,
      width: AppDimensions.settingGameButtonWidth);
}
