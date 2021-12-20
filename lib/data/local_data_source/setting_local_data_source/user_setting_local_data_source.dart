import '../../../../presentation/setting_game/cubit/setting_game_cubit.dart';

abstract class UserSettingLocalDataSource {
  Future<void> clearUserConfig();
  Future<bool?> getSettingState({required userSetting settingType});
  Future<void> saveSettingState({required userSetting settingType, required bool state});
}
