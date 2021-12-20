import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../dto/history_dto.dart';
import '../../dto/story_description_dto.dart';
import '../../failures/failure.dart';
import '../../local_data_source/config_history_local_data_source/config_history_local_data_source.dart';

abstract class HistoryRepository {
  Future<Either<Failure, List<HistoryDto>>> getHistory();

  Future<Either<Failure, StoryDescriptionDto>> getHistoryById(int heroId, int storyId);
}

@Injectable(as: HistoryRepository)
class HistoryRepositoryImpl implements HistoryRepository {
  final ConfigHistoryLocalDataSource _dataSource;
  const HistoryRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, List<HistoryDto>>> getHistory() async {
    final value = await _dataSource.getHistoryFromJson();
    if (value == null) return Left(Failure.jsonAssetDecode());
    return Right(value);
  }

  @override
  Future<Either<Failure, StoryDescriptionDto>> getHistoryById(int heroId, int storyId) async {
    final value = await _dataSource.getHistoryFromJson();
    if (value == null) return Left(Failure.jsonAssetDecode());
    if (value.length > heroId && value[heroId].story.length > storyId) {
      return Right(value[heroId].story[storyId]);
    } else {
      return Left(Failure.instanceNotExist());
    }
  }
}
