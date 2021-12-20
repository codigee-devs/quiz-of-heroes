import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/failures/failure.dart';
import '../../../data/repositories/user_instance_repository/user_instance_repository.dart';
import 'usecase.dart';

@Injectable()
class ClearUserInstanceUseCase implements UseCase<void, void> {
  final UserInstanceRepository _repository;
  const ClearUserInstanceUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call([void noParams]) async => _repository.clearUserInstance();
}
