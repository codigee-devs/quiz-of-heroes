import 'package:injectable/injectable.dart';

import '../../../../presentation/setting_game/cubit/setting_game_cubit.dart';
import '../database/database_client/database_client.dart';
import '../database/database_client/database_client_box_name.dart';
import 'user_setting_local_data_source.dart';

@Injectable(as: UserSettingLocalDataSource)
class UserSettingLocalDataSourceImpl implements UserSettingLocalDataSource {
  final DatabaseClient _databaseClient;

  const UserSettingLocalDataSourceImpl(this._databaseClient);

  static const String _soundToggleKey = 'soundToggleKey';
  static const String _soundEffectToggleKey = 'soundEffectToggleKey';
  static const String _storyToggleKey = 'storyToggleKey';
  static const String _countingToggleKey = 'countingToggleKey';

  String get _boxName => DatabaseClientBoxName.userSetting();

  @override
  Future<void> clearUserConfig() async => _databaseClient.clear(name: _boxName);

  @override
  Future<bool?> getSettingState({required userSetting settingType}) async {
    switch (settingType) {
      case userSetting.isMusicEnabled:
        return (await _databaseClient.getWithKey<bool>(name: _boxName, key: _soundToggleKey));
      case userSetting.isSoundEffectEnabled:
        return (await _databaseClient.getWithKey<bool>(name: _boxName, key: _soundEffectToggleKey));

      case userSetting.isCountingEnabled:
        return (await _databaseClient.getWithKey<bool>(name: _boxName, key: _countingToggleKey));

      case userSetting.isStoryEnabled:
        return (await _databaseClient.getWithKey<bool>(name: _boxName, key: _storyToggleKey));
    }
  }

  @override
  Future<void> saveSettingState({required userSetting settingType, required bool state}) async {
    switch (settingType) {
      case userSetting.isMusicEnabled:
        return (await _databaseClient.putAtKey<bool>(name: _boxName, key: _soundToggleKey, value: state));
      case userSetting.isSoundEffectEnabled:
        return (await _databaseClient.putAtKey<bool>(name: _boxName, key: _soundEffectToggleKey, value: state));

      case userSetting.isCountingEnabled:
        return (await _databaseClient.putAtKey<bool>(name: _boxName, key: _countingToggleKey, value: state));

      case userSetting.isStoryEnabled:
        return (await _databaseClient.putAtKey<bool>(name: _boxName, key: _storyToggleKey, value: state));
    }
  }
}
