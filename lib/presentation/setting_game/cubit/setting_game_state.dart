part of 'setting_game_cubit.dart';

@freezed
abstract class SettingGameState with _$SettingGameState {
  const factory SettingGameState.initial() = _SettingGameStateInitial;

  const factory SettingGameState.failure() = _SettingGameStateFailure;

  @Implements(SettingGameStateOnTapBackButton)
  const factory SettingGameState.onTapBackButton() = _SettingGameStateOnTapBackButton;
  @Implements(SettingGameStateClearState)
  const factory SettingGameState.clearState() = _SettingGameStateClearState;
  @Implements(SettingGameStateOnTapBackButton)
  const factory SettingGameState.onTapExitButton() = _SettingGameStateOnTapExitButton;

  @Implements(SettingGameStateDisplaySetting)
  const factory SettingGameState.displaySetting({required UserSettingEntity valuesOfButtons}) =
      _SettingGameStateDisplaySetting;
}

abstract class SettingGameStateDisplaySetting {}

abstract class SettingGameStateOnTapBackButton {}

abstract class SettingGameStateClearState {}
