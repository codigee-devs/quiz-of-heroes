import 'package:injectable/injectable.dart';

import '../../dto/user_instance_dto.dart';
import '../database/database_client/database_client.dart';
import '../database/database_client/database_client_box_name.dart';
import '../dbo/user_instance_dbo.dart';

abstract class UserInstanceGeneralLocalDataSource {
  Future<List<UserInstanceDto>?> getUserInstance();
  Future<void> saveUserInstance(UserInstanceDto instance);
}

@Injectable(as: UserInstanceGeneralLocalDataSource)
class UserInstanceGeneralLocalDataSourceImpl implements UserInstanceGeneralLocalDataSource {
  final DatabaseClient _databaseClient;

  const UserInstanceGeneralLocalDataSourceImpl(this._databaseClient);

  String get _boxName => DatabaseClientBoxName.userGeneralInstance();

  @override
  Future<List<UserInstanceDto>?> getUserInstance() async {
    final dbo = await _databaseClient.getAll(name: _boxName);
    return dbo.cast<UserInstanceDbo>().map((e) => e.toDto()).toList();
  }

  @override
  Future<void> saveUserInstance(UserInstanceDto instance) async {
    final value = UserInstanceDbo.fromDto(instance);
    await _databaseClient.add(name: _boxName, value: value);
  }
}
