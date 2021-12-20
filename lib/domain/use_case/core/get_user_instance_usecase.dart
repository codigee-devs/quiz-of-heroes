import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/failures/failure.dart';
import '../../../data/repositories/config_heroes_repository/config_heroes_repository.dart';
import '../../../data/repositories/user_instance_repository/user_instance_repository.dart';
import '../../entities/game_flow/user_instance_entity.dart';
import '../../entities/hero/hero_entity.dart';
import 'usecase.dart';

@Injectable()
class GetUserInstanceUsecase implements UseCase<UserInstanceEntity, void> {
  final UserInstanceRepository _userInstanceRepository;
  final ConfigHeroesRepository _configHeroesRepository;
  const GetUserInstanceUsecase(this._userInstanceRepository, this._configHeroesRepository);

  @override
  Future<Either<Failure, UserInstanceEntity>> call([void noParams]) async {
    final result = await _userInstanceRepository.getUserInstance();
    return result.fold(
      (l) => Left(l),
      (dto) async {
        final userHero = await _configHeroesRepository.getHeroById(dto.heroId);
        return userHero.fold(
          (l) => Left(l),
          (r) => Right(
            UserInstanceEntity(
              name: dto.name,
              level: dto.level,
              points: dto.points,
              lifes: dto.lifes,
              hero: HeroEntity.fromDto(r),
              askedQuestions: dto.askedQuestions,
            ),
          ),
        );
      },
    );
  }
}
