import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../dto/user_instance_dto.dart';
import '../../failures/failure.dart';
import '../../local_data_source/user_instance_general_local_data_source/user_instance_general_local_data.dart';
import '../../local_data_source/user_instance_local_data_source/user_instance_local_data_source.dart';

abstract class UserInstanceGeneralRepository {
  Future<Either<Failure, List<UserInstanceDto>>> getUserInstance();
  Future<Either<Failure, void>> saveUserInstance(UserInstanceDto value);
  Future<Either<Failure, bool>> checkIfInstanceExsist();
  Future<Either<Failure, bool>> checkIfChosenInstanceAlreadyExsist(UserInstanceDto chosenInstance);
}

@Injectable(as: UserInstanceGeneralRepository)
class UserInstanceGeneralRepositoryImpl implements UserInstanceGeneralRepository {
  final UserInstanceGeneralLocalDataSource _dataGeneralSource;
  final UserInstanceLocalDataSource _dataSource;

  UserInstanceGeneralRepositoryImpl(this._dataGeneralSource, this._dataSource);

  @override
  Future<Either<Failure, List<UserInstanceDto>>> getUserInstance() async {
    final instance = await _dataGeneralSource.getUserInstance();
    if (instance == null) return Left(Failure.instanceNotExist());
    return Right(instance);
  }

  @override
  Future<Either<Failure, void>> saveUserInstance(UserInstanceDto value) async {
    try {
      return Right(await _dataGeneralSource.saveUserInstance(value));
    }  on Exception catch (_) {
      return Left(Failure.databaseClientFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> checkIfInstanceExsist() async {
    final instances = await _dataGeneralSource.getUserInstance();
    final currInstance = await _dataSource.getUserInstance();

    if (instances == null) return Left(Failure.instanceNotExist());
    return Right(instances.any((e) => e == currInstance));
  }

  @override
  Future<Either<Failure, bool>> checkIfChosenInstanceAlreadyExsist(UserInstanceDto chosenInstance) async {
    final instances = await _dataGeneralSource.getUserInstance();
    if (instances == null) return Left(Failure.instanceNotExist());
    return Right(instances.any((e) {
      if (e == chosenInstance) {}
      return (e == chosenInstance);
    }));
  }
}
