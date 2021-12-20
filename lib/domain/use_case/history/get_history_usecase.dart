import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/failures/failure.dart';
import '../../../data/repositories/config_history_repository/history_repository.dart';
import '../../entities/history/history_entity.dart';
import '../core/usecase.dart';

@Injectable()
class GetHistoryUsecase implements UseCase<List<HistoryEntity>, void> {
  final HistoryRepository _repository;
  const GetHistoryUsecase(this._repository);
  @override
  Future<Either<Failure, List<HistoryEntity>>> call([void noParams]) async {
    final result = await _repository.getHistory();
    return result.fold(
      (l) => Left(l),
      (r) => Right(r.map((dto) => HistoryEntity.fromDto(dto)).toList()),
    );
  }
}
