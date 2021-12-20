import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/dto/hero_dto.dart';
import '../../../data/dto/user_instance_dto.dart';
import '../../../data/failures/failure.dart';
import '../../../data/repositories/config_heroes_repository/config_heroes_repository.dart';
import '../../../data/repositories/ranking_repository/ranking_repository.dart';
import '../../entities/game_flow/user_instance_entity.dart';
import '../../entities/hero/hero_entity.dart';
import '../core/usecase.dart';

@Injectable()
class GetEntireRankUseCase implements UseCase<List<UserInstanceEntity>, void> {
  final RankingRepository _rankingRepository;
  final ConfigHeroesRepository _configHeroesRepository;
  const GetEntireRankUseCase(this._rankingRepository, this._configHeroesRepository);

  @override
  Future<Either<Failure, List<UserInstanceEntity>>> call([void noParams]) async {
    final instances = (await _rankingRepository.getEntireRank()).fold(
      (failure) => failure,
      (dtos) => dtos,
    );

    final heroes = (await _configHeroesRepository.getHeroes()).fold(
      (failure) => failure,
      (dtos) => dtos,
    );

    if ([instances, heroes].any((e) => e is Failure)) return Left(Failure());
    final entities = (instances as List<UserInstanceDto>).map(
      (dto) {
        final hero = _selectHeroById((heroes as List<HeroDto>), id: dto.heroId);
        return UserInstanceEntity.fromDto(dto: dto, hero: hero);
      },
    ).toList();

    return Right((entities));
  }

  HeroEntity _selectHeroById(List<HeroDto> heroes, {required int id}) =>
      HeroEntity.fromDto(heroes.firstWhere((e) => e.id == id));
}
