import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../dto/hero_dto.dart';
import '../../failures/failure.dart';
import '../../local_data_source/config_heroes_local_data_source/config_heroes_local_data_source.dart';

///
/// this repository get [HeroDto] from the config json
///

abstract class ConfigHeroesRepository {
  Future<Either<Failure, List<HeroDto>>> getHeroes();
  Future<Either<Failure, HeroDto>> getHeroById(int id);
}

@Injectable(as: ConfigHeroesRepository)
class ConfigHeroesRepositoryImpl implements ConfigHeroesRepository {
  final ConfigHeroesLocalDataSource _dataSource;
  const ConfigHeroesRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, List<HeroDto>>> getHeroes() async {
    final value = await _dataSource.getHeroesFromJson();
    if (value == null) return Left(Failure.jsonAssetDecode());
    return Right(value);
  }

  @override
  Future<Either<Failure, HeroDto>> getHeroById(int id) async {
    final value = await _dataSource.getHeroesFromJson();
    if (value == null) return Left(Failure.jsonAssetDecode());
    final index = value.indexWhere((e) => e.id == id);
    return Right(value[index]);
  }
}
