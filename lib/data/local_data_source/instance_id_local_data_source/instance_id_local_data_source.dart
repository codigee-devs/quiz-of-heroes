import 'package:injectable/injectable.dart';

import '../database/database_client/database_client.dart';
import '../database/database_client/database_client_box_name.dart';

abstract class InstanceIdLocalDataSource {
  Future<String?> getUserInstanceId();
  Future<void> saveUserInstanceId({required String id});
}

@Injectable(as: InstanceIdLocalDataSource)
class InstanceIdLocalDataSourceImpl implements InstanceIdLocalDataSource {
  final DatabaseClient _databaseClient;

  const InstanceIdLocalDataSourceImpl(this._databaseClient);

  static const String _instanceIdKey = 'instanceIdKey';

  String get _boxName => DatabaseClientBoxName.instanceId();

  @override
  Future<String?> getUserInstanceId() async =>
      await _databaseClient.getWithKey<String>(name: _boxName, key: _instanceIdKey);
  @override
  Future<void> saveUserInstanceId({required String id}) async =>
      _databaseClient.putAtKey(name: _boxName, key: _instanceIdKey, value: id);
}
