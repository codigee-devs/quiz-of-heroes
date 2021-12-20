import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/failures/failure.dart';
import '../../../data/repositories/config_artefacts_repository/config_artefacts_repository.dart';
import '../../entities/artefacts/artefact_entity.dart';
import '../core/usecase.dart';

@Injectable()
class GetArtefactsUseCase implements UseCase<List<ArtefactEntity>, void> {
  final ConfigArtefactsRepository _repository;
  const GetArtefactsUseCase(this._repository);

  @override
  Future<Either<Failure, List<ArtefactEntity>>> call([void noParams]) async {
    final result = await _repository.getArtefacts();
    return result.fold(
      (l) => Left(l),
      (r) => Right(r.map((dto) => ArtefactEntity.fromDto(dto)).toList()),
    );
  }
}
