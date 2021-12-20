import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/failures/failure.dart';
import '../../../data/repositories/user_instance_repository/user_instance_general_repository.dart';
import 'usecase.dart';

@Injectable()
class CheckIfInstanceExistUseCase implements UseCase<bool, void> {
  final UserInstanceGeneralRepository _configGeneralInstanceRepository;

  CheckIfInstanceExistUseCase(this._configGeneralInstanceRepository);
  @override
  Future<Either<Failure, bool>> call([void noParams]) async =>
      await _configGeneralInstanceRepository.checkIfInstanceExsist();
}
