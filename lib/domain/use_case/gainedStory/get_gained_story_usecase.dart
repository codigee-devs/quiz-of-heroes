import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/failures/failure.dart';
import '../../../data/repositories/config_gained_story_repository/config_gained_story_repository.dart';
import '../core/usecase.dart';

@Injectable()
class GetGainedStoryUseCase implements UseCase<List<int>, void> {
  final UserGainedStoryRepository _repository;

  GetGainedStoryUseCase(this._repository);

  @override
  Future<Either<Failure, List<int>>> call([void noParams]) async => await _repository.getGainedStory();
}
