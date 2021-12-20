import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../dto/question_dto.dart';
import '../../failures/failure.dart';
import '../../local_data_source/questions_local_data_source/questions_local_data_source.dart';

abstract class QuestionsRepository {
  Future<Either<Failure, List<QuestionDto>>> getQuestions();
}

@Injectable(as: QuestionsRepository)
class QuestionsRepositoryImpl implements QuestionsRepository {
  final QuestionsLocalDataSource _dataSource;
  const QuestionsRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, List<QuestionDto>>> getQuestions() async {
    final value = await _dataSource.getQuestionsFromJson();
    if (value == null) return Left(Failure.jsonAssetDecode());
    return Right(value);
  }
}
