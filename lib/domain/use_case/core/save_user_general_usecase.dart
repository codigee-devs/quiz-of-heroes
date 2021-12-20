import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/dto/user_instance_dto.dart';
import '../../../data/failures/failure.dart';
import '../../../data/repositories/user_instance_repository/user_instance_general_repository.dart';
import '../../entities/game_flow/user_instance_entity.dart';
import 'usecase.dart';

@Injectable()
class SaveUserGeneralInstanceUseCase implements UseCase<void, UserInstanceEntity> {
  final UserInstanceGeneralRepository _repository;
  const SaveUserGeneralInstanceUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(UserInstanceEntity entity) => _repository.saveUserInstance(
        UserInstanceDto(
          level: entity.level,
          points: entity.points,
          lifes: entity.lifes,
          heroId: entity.hero.id,
          name: entity.name,
          askedQuestions: entity.askedQuestions,
        ),
      );
}
