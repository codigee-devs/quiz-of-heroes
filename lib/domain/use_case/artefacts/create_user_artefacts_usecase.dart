import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/dto/hero_dto.dart';
import '../../../data/failures/failure.dart';
import '../../../data/repositories/config_heroes_repository/config_heroes_repository.dart';
import '../../../data/repositories/user_artefacts_repository/user_artefacts_repository.dart';
import '../core/usecase.dart';

///
/// Create instance user artefacts by get them from heroes json
/// as parameter usecase provide [hero id]
///

@Injectable()
class CreateUserArtefactsUsecase implements UseCase<void, int> {
  final UserArtefactsRepository _userArtefactsRepository;
  final ConfigHeroesRepository _configHeroesRepository;
  const CreateUserArtefactsUsecase(this._userArtefactsRepository, this._configHeroesRepository);
  @override
  Future<Either<Failure, void>> call(int heroId) async {
    final result = await _configHeroesRepository.getHeroById(heroId);
    final dto = result.fold((l) => l, (hero) => hero);
    if (dto is Failure) return Left(dto);
    final artefacts = (dto as HeroDto).items;
    return await _userArtefactsRepository.saveUserArtefacts(value: artefacts, overrideInstance: true);
  }
}
