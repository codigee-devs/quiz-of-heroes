import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/dto/user_instance_dto.dart';
import '../../../data/failures/failure.dart';
import '../../../data/repositories/user_instance_repository/user_instance_general_repository.dart';
import '../../entities/game_flow/user_instance_entity.dart';
import 'usecase.dart';

@Injectable()
class CheckIfChosenInstanceAlreadyExistUseCase implements UseCase<bool, UserInstanceEntity> {
  final UserInstanceGeneralRepository _repository;

  const CheckIfChosenInstanceAlreadyExistUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> call(UserInstanceEntity instance) async =>
      await _repository.checkIfChosenInstanceAlreadyExsist(
        (UserInstanceDto(
          level: instance.level,
          points: instance.points,
          lifes: instance.lifes,
          heroId: instance.hero.id,
          name: instance.name,
          askedQuestions: instance.askedQuestions,
        )),
      );
}
