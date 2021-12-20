import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/dto/user_artefact_dto.dart';
import '../../../data/failures/failure.dart';
import '../../../data/repositories/user_artefacts_repository/user_artefacts_repository.dart';
import '../core/usecase.dart';

@Injectable()
class UseUserArtefactUseCase implements UseCase<void, int> {
  final UserArtefactsRepository _repository;
  const UseUserArtefactUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(int artefactId) async => (await _repository.getUserArtefacts()).fold(
        (failure) => Left(failure),
        (artefacts) async {
          final updatedArtefacts = _updateArtefactsCounts(artefactId, artefacts);
          if(updatedArtefacts == null) return Left(Failure.invalidParameter());
          return Right(await _repository.saveUserArtefacts(value: updatedArtefacts));
        },
      );

  List<UserArtefactDto>? _updateArtefactsCounts(int artefactId, List<UserArtefactDto> value) {
    final index = value.indexWhere((e) => e.artefactId == artefactId);
    if (index != -1) {
      value[index] = value[index].copyWith(count: value[index].count - 1);
      return value;
    } else {
      return null;
    }
  }
}
