import 'package:injectable/injectable.dart';

import '../../dto/user_instance_dto.dart';
import '../database/database_client/database_client.dart';
import '../database/database_client/database_client_box_name.dart';
import '../dbo/user_instance_dbo.dart';

abstract class UserInstanceLocalDataSource {
  Future<UserInstanceDto?> getUserInstance();
  Future<void> saveUserInstance(UserInstanceDto instance);
  Future<void> clearUserInstance();
}

@Injectable(as: UserInstanceLocalDataSource)
class UserInstanceLocalDataSourceImpl implements UserInstanceLocalDataSource {
  final DatabaseClient _databaseClient;

  const UserInstanceLocalDataSourceImpl(this._databaseClient);

  static const String _userInstanceKey = 'userInstanceKey';

  String get _boxName => DatabaseClientBoxName.userInstance();

  @override
  Future<UserInstanceDto?> getUserInstance() async {
    final dbo =
        await _databaseClient.getWithKey(name: _boxName, key: _userInstanceKey);
    return dbo?.toDto();
  }

  @override
  Future<void> saveUserInstance(UserInstanceDto instance) async {
    final value = UserInstanceDbo.fromDto(instance);
    await _databaseClient.putAtKey(
        name: _boxName, key: _userInstanceKey, value: value);
  }

  @override
  Future<void> clearUserInstance() async =>
      _databaseClient.clear(name: _boxName);
}
