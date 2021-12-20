import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/dto/user_artefact_dto.dart';
import '../../../data/failures/failure.dart';
import '../../../data/repositories/user_artefacts_repository/user_artefacts_repository.dart';
import '../../entities/artefacts/user_artefact_entity.dart';
import '../core/usecase.dart';

@Injectable()
class SaveUserArtefactsUseCase implements UseCase<void, List<UserArtefactEntity>> {
  final UserArtefactsRepository _repository;
  const SaveUserArtefactsUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(List<UserArtefactEntity> value) async {
    final result = value
        .map((entity) => UserArtefactDto(
              artefactId: entity.artefact.id,
              count: entity.count,
            ))
        .toList();
        
    return _repository.saveUserArtefacts(value: result);
  }
}
