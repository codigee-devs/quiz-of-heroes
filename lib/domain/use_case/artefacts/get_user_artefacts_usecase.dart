import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/failures/failure.dart';
import '../../../data/repositories/config_artefacts_repository/config_artefacts_repository.dart';
import '../../../data/repositories/user_artefacts_repository/user_artefacts_repository.dart';
import '../../entities/artefacts/artefact_entity.dart';
import '../../entities/artefacts/user_artefact_entity.dart';
import '../core/usecase.dart';

@Injectable()
class GetUserArtefactsUseCase implements UseCase<List<UserArtefactEntity>, void> {
  final ConfigArtefactsRepository _configArtefactsRepository;
  final UserArtefactsRepository _userArtefactsRepository;
  const GetUserArtefactsUseCase(this._configArtefactsRepository, this._userArtefactsRepository);

  @override
  Future<Either<Failure, List<UserArtefactEntity>>> call([void noParams]) async {
    final userArtefacts = await _userArtefactsRepository.getUserArtefacts();
    return userArtefacts.fold((l) => Left(l), (userArtefacts) async {
      final artefacts = await _configArtefactsRepository.getArtefacts();
      return artefacts.fold((l) => Left(l), (artefacts) {
        final result = userArtefacts.map((dto) => UserArtefactEntity(
              count: dto.count,
              artefact: ArtefactEntity.fromDto(
                artefacts.firstWhere((artefact) => artefact.id == dto.artefactId),
              ),
            )).toList();
        return Right(result);
      });
    });
  }
}
