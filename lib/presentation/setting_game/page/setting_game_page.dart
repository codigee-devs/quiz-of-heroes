import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/base_features/base/page/base_page.dart';
import '../../../core/injection/injection.dart';
import '../../../core/language/localization.dart';
import '../../../core/presentation/styles/styles.dart';
import '../../../core/presentation/values/values.dart';
import '../../../core/presentation/widgets/app_widgets.dart';
import '../../../core/presentation/widgets/buttons/app_base_button.dart';
import '../../../domain/entities/settings/user_setting_entity.dart';
import '../cubit/setting_game_cubit.dart';

class SettingGamePage extends BasePage {
  @override
  Widget buildChildWidget(BuildContext context) => BlocProvider(
        create: (_) => getIt<SettingGameCubit>()..init(),
        child: _Body(),
      );
}

class _Body extends StatelessWidget {
  static const double _appbarHeightRatio = 0.15;
  static const double _baseBarScale = 0.055;
  static const double _setNumberChildAspect = 3.5;
  static const int _setNumbersOfItemsInRow = 2;

  double _getAppbarSize(BuildContext context) => MediaQuery.of(context).size.height * _appbarHeightRatio;

  @override
  Widget build(BuildContext context) => Scaffold(
          body: BaseGameWindow(
        appBar: BaseGameWindowsAppBar(
          padding: EdgeInsets.zero,
          height: _getAppbarSize(context),
          color: AppColors.barAppBack,
          leftChild: AppBaseButton.baseBackButton(
            onPressed: () => _didTapBackButton(context),
            height: _getAppbarSize(context),
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: AppDimensions.largeEdgeInsets12),
            child: Text(
              context.translate(SKeys.setting_game_title),
              style: TextStyles.subtitleShadowWhite.copyWith(
                fontSize: MediaQuery.of(context).size.height * _baseBarScale,
              ),
            ),
          ),
          rightChild: AppBaseButton.baseCancelButton(
            onPressed: () => _didTapCancelButton(context),
            height: _getAppbarSize(context),
          ),
        ),
        child: BlocConsumer<SettingGameCubit, SettingGameState>(
          listener: (context, state) => state.maybeWhen(
            onTapBackButton: () => context.navigator.pop(),
            onTapExitButton: () => context.navigator.pushAndPopUntil(
              HomePageRoute(),
              predicate: (_) => false,
            ),
            orElse: () => null,
          ),
          buildWhen: (prevState, currState) => currState is SettingGameStateDisplaySetting,
          builder: (context, state) => state.maybeWhen(
            displaySetting: (values) => Container(
              child: _gridView(context, values),
              margin: const EdgeInsets.all(AppDimensions.xxLargeEdgeInsets48),
            ),
            orElse: () => Container(),
          ),
        ),
      ));

  Widget _gridView(BuildContext context, UserSettingEntity values) => GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: _setNumbersOfItemsInRow,
        childAspectRatio: _setNumberChildAspect,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: const EdgeInsets.only(top: AppDimensions.smallEdgeInsets4),
                  child: Text(context.translate(SKeys.setting_game_sound_effect))),
              AppBaseButton.settingGameButton(
                  onPressed: () => _didTapSettingButton(context, userSetting.isSoundEffectEnabled, values),
                  child: Text(
                    _isTextTurnOnOrTurnOff(context, values.isSoundEffectEnabled),
                    style: TextStyles.homeButtonStyle,
                  ),
                  isPressed: values.isSoundEffectEnabled)
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: const EdgeInsets.only(top: AppDimensions.smallEdgeInsets4),
                  child: Text(context.translate(SKeys.setting_game_story))),
              AppBaseButton.settingGameButton(
                  onPressed: () => _didTapSettingButton(context, userSetting.isStoryEnabled, values),
                  child: Text(
                    _isTextTurnOnOrTurnOff(context, values.isStoryEnabled),
                    style: TextStyles.homeButtonStyle,
                  ),
                  isPressed: values.isStoryEnabled)
            ],
          ),
        ],
      );

  String _isTextTurnOnOrTurnOff(BuildContext context, bool isOn) =>
      isOn ? context.translate(SKeys.setting_game_turn_on) : context.translate(SKeys.setting_game_turn_off);

  void _didTapSettingButton(BuildContext context, userSetting settingType, UserSettingEntity settings) =>
      context.read<SettingGameCubit>().didTapSettingButton(settingType: settingType, settings: settings);

  void _didTapBackButton(BuildContext context) => context.read<SettingGameCubit>().didTapBackButton();

  void _didTapCancelButton(BuildContext context) => context.read<SettingGameCubit>().didTapCancelButton();
}
