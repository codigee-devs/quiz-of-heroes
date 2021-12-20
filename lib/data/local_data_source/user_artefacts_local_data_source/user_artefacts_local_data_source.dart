import 'package:injectable/injectable.dart';

import '../../dto/user_artefact_dto.dart';
import '../database/database_client/database_client.dart';
import '../database/database_client/database_client_box_name.dart';
import '../dbo/user_artefact_dbo.dart';


///
/// User artefacts are stored in an array of [UserArtefactDbo]
///

abstract class UserArtefactsLocalDataSource {
  Future<List<UserArtefactDto>?> getUserArtefacts();
  Future<void> saveUserArtefacts(List<UserArtefactDto> value);
}


@Injectable(as: UserArtefactsLocalDataSource)
class UserArtefactsLocalDataSourceImpl implements UserArtefactsLocalDataSource {
  final DatabaseClient _databaseClient;

  const UserArtefactsLocalDataSourceImpl(this._databaseClient);

  static const String _userArtefactsKey = 'userArtefactsKey';

  String get _boxName => DatabaseClientBoxName.artefacts();

  @override
  Future<List<UserArtefactDto>?> getUserArtefacts() async {
    final dbo = await _databaseClient.getWithKey<List<dynamic>>(name: _boxName, key: _userArtefactsKey);
    if(dbo == null) return null;
    return dbo.cast<UserArtefactDbo>().map((dbo) => dbo.toDto()).toList();
  }

  @override
  Future<void> saveUserArtefacts(List<UserArtefactDto> artefacts) async {
    final value = artefacts.map((dto) => UserArtefactDbo.fromDto(dto)).toList();
    return _databaseClient.putAtKey(name: _boxName, key: _userArtefactsKey, value: value);
  }
}
