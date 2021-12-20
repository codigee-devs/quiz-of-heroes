import 'package:injectable/injectable.dart';

import '../database/database_client/database_client.dart';
import '../database/database_client/database_client_box_name.dart';

abstract class UserGainedStoryLocalDataSource {
  Future<int?> getGainedStoryInstance(int id);
  Future<void> saveGainedStoryInstance(int id, int value);
}

@Injectable(as: UserGainedStoryLocalDataSource)
class UserGainedStoryLocalDataSourceImpl implements UserGainedStoryLocalDataSource {
  final DatabaseClient _databaseClient;

  const UserGainedStoryLocalDataSourceImpl(this._databaseClient);

  static const String _wizardStoryKey = "wizardStoryKey";
  static const String _warriorStoryKey = "warriorStoryKey";

  String get _boxName => DatabaseClientBoxName.userGainedStory();

  @override
  Future<int?> getGainedStoryInstance(int id) async {
    if (id == 0) {
      return (await _databaseClient.getWithKey(name: _boxName, key: _warriorStoryKey));
    } else {
      return (await _databaseClient.getWithKey(name: _boxName, key: _wizardStoryKey));
    }
  }

  @override
  Future<void> saveGainedStoryInstance(int id, int value) async {
    if (id == 0) {
      return (await _databaseClient.putAtKey<int>(name: _boxName, key: _warriorStoryKey, value: value));
    } else {
      return (await _databaseClient.putAtKey<int>(name: _boxName, key: _wizardStoryKey, value: value));
    }
  }
}
