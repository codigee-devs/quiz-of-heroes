import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/logger/logger.dart';
import '../../failures/failure.dart';
import '../../local_data_source/user_gained_story_local_data_source/user_gained_story_local_data_source.dart';

abstract class UserGainedStoryRepository {
  Future<Either<Failure, List<int>>> getGainedStory();
  Future<Either<Failure, void>> saveGainedStory(int id, int value);
}

@Injectable(as: UserGainedStoryRepository)
class UserGainedStoryRepositoryImpl implements UserGainedStoryRepository {
  final UserGainedStoryLocalDataSource _userGainedStoryLocalDataSource;

  UserGainedStoryRepositoryImpl(this._userGainedStoryLocalDataSource);

  @override
  Future<Either<Failure, List<int>>> getGainedStory() async {
    try {
      var gainedStoryWarrior = await _userGainedStoryLocalDataSource.getGainedStoryInstance(0) ?? 0;
      var gainedStoryWizard = await _userGainedStoryLocalDataSource.getGainedStoryInstance(1) ?? 0;

      return Right([gainedStoryWarrior, gainedStoryWizard]);
    } on Exception catch (e) {
      AppLogger.errorDatabase(e);
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, void>> saveGainedStory(int id, int value) async {
    try {
      var numberOfStory = await _userGainedStoryLocalDataSource.getGainedStoryInstance(id) ?? 0;
      if (value > numberOfStory) {
        return Right(await _userGainedStoryLocalDataSource.saveGainedStoryInstance(id, numberOfStory + 1));
      } else {
        return Right(null);
      }
    } on Exception catch (e) {
      AppLogger.errorDatabase(e);
      return Left(Failure());
    }
  }
}
