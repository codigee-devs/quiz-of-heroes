import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/failures/failure.dart';
import '../../../data/repositories/config_history_repository/history_repository.dart';
import '../../entities/history/story_description_entity.dart';
import '../core/usecase.dart';

@Injectable()
class GetHeroHistoryUsecase implements UseCase<StoryDescriptionEntity, int> {
  final HistoryRepository _repository;

  const GetHeroHistoryUsecase(this._repository);
  @override
  Future<Either<Failure, StoryDescriptionEntity>> call([int? heroId,  int? storyId]) async {
    if([heroId, storyId].any((e) => e == null)) return Left(Failure());
    final result = await _repository.getHistoryById(heroId!, storyId!);
    return result.fold(
      (l) => Left(l),
      (r) => Right(StoryDescriptionEntity.fromDto(r)),
    );
  }
}
