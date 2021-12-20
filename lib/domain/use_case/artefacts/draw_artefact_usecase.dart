import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/dto/artefact_dto.dart';
import '../../../data/dto/user_artefact_dto.dart';
import '../../../data/failures/failure.dart';
import '../../../data/repositories/config_artefacts_repository/config_artefacts_repository.dart';
import '../../../data/repositories/user_artefacts_repository/user_artefacts_repository.dart';
import '../../entities/artefacts/artefact_entity.dart';
import '../core/usecase.dart';

@Injectable()
class DrawArtefactUsecase implements UseCase<ArtefactEntity, void> {
  final ConfigArtefactsRepository _configArtefactsRepository;
  final UserArtefactsRepository _userArtefactsRepository;
  const DrawArtefactUsecase(this._configArtefactsRepository, this._userArtefactsRepository);

  @override
  Future<Either<Failure, ArtefactEntity>> call([void noParams]) async {
    final configArtefacts = await _configArtefactsRepository.getArtefacts();
    final userArtefacts = await _userArtefactsRepository.getUserArtefacts();

    final drawnArtefact = configArtefacts.fold(
      (failure) => failure,
      _drawArtefact,
    );

    final currentArtefacts = userArtefacts.fold(
      (failure) => failure,
      (artefacts) => artefacts,
    );

    if (drawnArtefact is Failure || currentArtefacts is Failure) return Left(Failure());
    _updateUserArtefacts((currentArtefacts as List<UserArtefactDto>), (drawnArtefact as ArtefactEntity));
    return Right(drawnArtefact);
  }

  ArtefactEntity _drawArtefact(List<ArtefactDto> artefacts) {
    final drawnIndex = Random().nextInt(artefacts.length);
    return ArtefactEntity.fromDto(artefacts[drawnIndex]);
  }

  Future<void> _updateUserArtefacts(List<UserArtefactDto> currentArtefacts, ArtefactEntity drawnArtefact) async {
    final index = currentArtefacts.indexWhere((dto) => dto.artefactId == drawnArtefact.id);
    if (index != -1) {
      final dto = currentArtefacts[index];
      currentArtefacts[index] = dto.copyWith(count: dto.count + 1);
      await _userArtefactsRepository.saveUserArtefacts(value: currentArtefacts);
    } else {
      var artefacts = List<UserArtefactDto>.from(currentArtefacts);
      artefacts.add(UserArtefactDto(artefactId: drawnArtefact.id, count: 1));
      await _userArtefactsRepository.saveUserArtefacts(value: artefacts);
    }
  }
}
