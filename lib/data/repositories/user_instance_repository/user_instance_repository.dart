import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../dto/user_instance_dto.dart';
import '../../exceptions/exception.dart';
import '../../failures/failure.dart';
import '../../local_data_source/user_instance_local_data_source/user_instance_local_data_source.dart';

abstract class UserInstanceRepository {
  Future<Either<Failure, UserInstanceDto>> getUserInstance();
  Future<Either<Failure, void>> saveUserInstance(UserInstanceDto value);
  Future<Either<Failure, void>> clearUserInstance();
}

@Injectable(as: UserInstanceRepository)
class UserInstanceRepositoryImpl implements UserInstanceRepository {
  final UserInstanceLocalDataSource _localDataSource;

  const UserInstanceRepositoryImpl(this._localDataSource);

  @override
  Future<Either<Failure, UserInstanceDto>> getUserInstance() async {
    final instance = await _localDataSource.getUserInstance();
    if (instance == null) return Left(Failure.instanceNotExist());
    return Right(instance);
  }

  @override
  Future<Either<Failure, void>> saveUserInstance(UserInstanceDto value) async {
    try {
      return Right(await _localDataSource.saveUserInstance(value));
    } on InvalidParametrException {
      return Left(Failure.invalidParameter());
    }  on Exception catch (_) {
      return Left(Failure.databaseClientFailure());
    }
  }

  @override
  Future<Either<Failure, void>> clearUserInstance() async => Right(_localDataSource.clearUserInstance());
}
