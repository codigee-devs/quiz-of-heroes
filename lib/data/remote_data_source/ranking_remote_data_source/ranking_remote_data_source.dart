import 'package:injectable/injectable.dart';

import '../../../core/app/remote.dart';
import '../../dto/user_instance_dto.dart';

abstract class RankingRemoteDataSource {
  Future<String?> createUserInstance({required UserInstanceDto instance});
  Future<void> updateUserInstance({required UserInstanceDto instance, required String key});
  Future<List<UserInstanceDto>> getEntireRank();
}

@Injectable(as: RankingRemoteDataSource)
class RankingRemoteDataSourceImpl implements RankingRemoteDataSource {
  static const String _rankCollection = 'rank';
  static const String _orderByField = 'points';

  @override
  Future<String?> createUserInstance({required UserInstanceDto instance}) async {
    final db = RemoteCore.database;
    return await db.collection(_rankCollection).add(instance.toJson()).then((doc) => doc.id);
  }

  @override
  Future<void> updateUserInstance({required UserInstanceDto instance, required String key}) async {
    final db = RemoteCore.database;
    await db.collection(_rankCollection).doc(key).update(instance.toJson());
  }

  @override
  Future<List<UserInstanceDto>> getEntireRank() async {
    final db = RemoteCore.database;
    final snapshots =
        await db.collection(_rankCollection).orderBy(_orderByField, descending: true).get().then((value) => value.docs);
    return snapshots.map((doc) => UserInstanceDto.fromJson(doc.data())).toList();
  }
}
