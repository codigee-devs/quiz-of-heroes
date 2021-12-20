import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../dto/user_artefact_dto.dart';
import '../../failures/failure.dart';
import '../../local_data_source/user_artefacts_local_data_source/user_artefacts_local_data_source.dart';

abstract class UserArtefactsRepository {
  /// Get artefacts ids from the current session. Also contains the number of available uses
  Future<Either<Failure, List<UserArtefactDto>>> getUserArtefacts();

  /// e.g to change the available amount of an artifact
  /// specify in the parameter only artefacts that have changed
  /// [overrideInstance] is used to override existing instance, eg. while creating new game
  Future<Either<Failure, void>> saveUserArtefacts({required List<UserArtefactDto> value, bool overrideInstance});
}

@Injectable(as: UserArtefactsRepository)
class UserArtefactsRepositoryImpl implements UserArtefactsRepository {
  final UserArtefactsLocalDataSource _dataSource;

  const UserArtefactsRepositoryImpl(this._dataSource);

  static const int _notFoundIndex = -1;

  @override
  Future<Either<Failure, List<UserArtefactDto>>> getUserArtefacts() async {
    final artefacts = await _dataSource.getUserArtefacts();
    if (artefacts == null) return Left(Failure.instanceNotExist());
    return Right(artefacts);
  }

  @override
  Future<Either<Failure, void>> saveUserArtefacts({
    required List<UserArtefactDto> value,
    bool overrideInstance = false,
  }) async {
    final items = await _dataSource.getUserArtefacts();
    if (items != null && !overrideInstance) {
      final updatedArtefacts = List<UserArtefactDto>.from(items);
      for (var newItem in value) {
        final index = updatedArtefacts.indexWhere((curr) => curr.artefactId == newItem.artefactId);
        if (index != _notFoundIndex) {
          updatedArtefacts[index] = newItem;
        } else {
          updatedArtefacts.add(newItem);
        }
      }
      return Right(_dataSource.saveUserArtefacts(updatedArtefacts));
    } else {
      return Right(_dataSource.saveUserArtefacts(value));
    }
  }
}
