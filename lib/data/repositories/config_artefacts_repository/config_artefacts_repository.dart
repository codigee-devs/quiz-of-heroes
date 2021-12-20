import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../dto/artefact_dto.dart';
import '../../failures/failure.dart';
import '../../local_data_source/config_artefacts_local_data_source/config_artefacts_local_data_source.dart';

///
/// this repository get [ArtefactDto] from the config json
///

abstract class ConfigArtefactsRepository {
  Future<Either<Failure, List<ArtefactDto>>> getArtefacts();
  Future<Either<Failure, ArtefactDto>> getArtefactById(int id);
}

@Injectable(as: ConfigArtefactsRepository)
class ConfigArtefactsRepositoryImpl implements ConfigArtefactsRepository {
  final ConfigArtefactsLocalDataSource _dataSource;
  const ConfigArtefactsRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, List<ArtefactDto>>> getArtefacts() async {
    final value = await _dataSource.getArtefactsFromJson();
    if (value == null) return Left(Failure.jsonAssetDecode());
    return Right(value);
  }

  @override
  Future<Either<Failure, ArtefactDto>> getArtefactById(int id) async {
    final value = await _dataSource.getArtefactsFromJson();
    if (value == null) return Left(Failure.jsonAssetDecode());
    final index = value.indexWhere((e) => e.id == id);
    return Right(value[index]);
  }
}
