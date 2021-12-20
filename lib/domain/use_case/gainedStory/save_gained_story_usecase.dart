import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';

import '../../../data/failures/failure.dart';
import '../../../data/repositories/config_gained_story_repository/config_gained_story_repository.dart';
import '../core/usecase.dart';

class Params {
  late int id;
  late int value;

  Params(this.id, this.value);
}

@Injectable()
class SaveGainedStoryUseCase implements UseCase<void, Params> {
  final UserGainedStoryRepository _repository;

  SaveGainedStoryUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(Params data) async => await _repository.saveGainedStory(data.id, data.value);
}
