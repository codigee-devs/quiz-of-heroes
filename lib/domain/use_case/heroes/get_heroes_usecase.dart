import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/failures/failure.dart';
import '../../../data/repositories/config_heroes_repository/config_heroes_repository.dart';
import '../../entities/hero/hero_entity.dart';
import '../core/usecase.dart';

@Injectable()
class GetHeroesUsecase implements UseCase<List<HeroEntity>, void> {
  final ConfigHeroesRepository _repository;
  const GetHeroesUsecase(this._repository);
  @override
  Future<Either<Failure, List<HeroEntity>>> call([void noParams]) async {
    final result = await _repository.getHeroes();
    return result.fold(
      (l) => Left(l),
      (r) => Right(r.map((dto) => HeroEntity.fromDto(dto)).toList()),
    );
  }
}
