import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/dto/user_instance_dto.dart';
import '../../../data/failures/failure.dart';
import '../../../data/repositories/ranking_repository/ranking_repository.dart';
import '../../entities/game_flow/user_instance_entity.dart';
import '../core/usecase.dart';

@Injectable()
class CreateRankInstanceUseCase implements UseCase<void, UserInstanceEntity> {
  final RankingRepository _repository;
  const CreateRankInstanceUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(UserInstanceEntity entity) async =>
      _repository.createUserInstance(instance: _instanceDtoFromEntity(entity));

  UserInstanceDto _instanceDtoFromEntity(UserInstanceEntity entity) => UserInstanceDto(
        level: entity.level,
        points: entity.points,
        lifes: entity.lifes,
        heroId: entity.hero.id,
        name: entity.name,
        askedQuestions: entity.askedQuestions,
      );
}
