import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/dto/hero_dto.dart';
import '../../../data/dto/user_instance_dto.dart';
import '../../../data/failures/failure.dart';
import '../../../data/repositories/config_heroes_repository/config_heroes_repository.dart';
import '../../../data/repositories/user_instance_repository/user_instance_general_repository.dart';
import '../../entities/game_flow/user_instance_entity.dart';
import '../../entities/hero/hero_entity.dart';
import 'usecase.dart';

@Injectable()
class GetUserGeneralInstanceUsecase implements UseCase<List<UserInstanceEntity>, void> {
  final UserInstanceGeneralRepository _userInstanceRepository;
  final ConfigHeroesRepository _configHeroesRepository;
  GetUserGeneralInstanceUsecase(this._userInstanceRepository, this._configHeroesRepository);

  @override
  Future<Either<Failure, List<UserInstanceEntity>>> call([void noParams]) async {
    final heroes = (await _configHeroesRepository.getHeroes()).fold(
      (failure) => failure,
      (r) => r,
    );
    if (heroes == Failure) return Left(Failure());

    return (await _userInstanceRepository.getUserInstance()).fold(
      (left) => Left(left),
      (dto) => Right(_userDtoToEntity(dto, (heroes as List<HeroDto>))),
    );
  }

  List<UserInstanceEntity> _userDtoToEntity(List<UserInstanceDto> dto, List<HeroDto> heroes) => dto
      .map((e) => UserInstanceEntity.fromDto(
            dto: e,
            hero: HeroEntity.fromDto((heroes)[e.heroId]),
          ))
      .toList();
}
