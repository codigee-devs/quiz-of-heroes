import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/logger/logger.dart';
import '../../dto/user_instance_dto.dart';
import '../../failures/failure.dart';
import '../../local_data_source/instance_id_local_data_source/instance_id_local_data_source.dart';
import '../../remote_data_source/ranking_remote_data_source/ranking_remote_data_source.dart';

abstract class RankingRepository {
  Future<Either<Failure, void>> createUserInstance({required UserInstanceDto instance});
  Future<Either<Failure, void>> updateUserInstance({required UserInstanceDto instance});
  Future<Either<Failure, List<UserInstanceDto>>> getEntireRank();
}

@Injectable(as: RankingRepository)
class RankingRepositoryImpl implements RankingRepository {
  final RankingRemoteDataSource _remoteDataSource;
  final InstanceIdLocalDataSource _localDataSource;
  const RankingRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Either<Failure, void>> createUserInstance({required UserInstanceDto instance}) async {
    try {
      final id = await _remoteDataSource.createUserInstance(instance: instance);
      return Right(await _localDataSource.saveUserInstanceId(id: id!));
    } on Exception catch (e) {
      AppLogger.error('CreateUserInstance: Failed to connect to datasource: $e');
      return Left(Failure.connectionFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateUserInstance({required UserInstanceDto instance}) async {
    try {
      final id = await _localDataSource.getUserInstanceId();
      return Right(await _remoteDataSource.updateUserInstance(instance: instance, key: id!));
    } on Exception catch (e) {
      AppLogger.error('UpdateUserInstance: Failed to connect to datasource: $e');
      return Left(Failure.connectionFailure());
    }
  }

  @override
  Future<Either<Failure, List<UserInstanceDto>>> getEntireRank() async {
    try {
      return Right(await _remoteDataSource.getEntireRank());
    } on Exception catch (e) {
      AppLogger.error('Ranking Repository Error: $e');
      return Left(Failure.databaseClientFailure());
    }
  }
}
