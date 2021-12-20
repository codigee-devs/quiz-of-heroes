import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/dto/question_dto.dart';
import '../../../data/dto/user_instance_dto.dart';
import '../../../data/failures/failure.dart';
import '../../../data/repositories/questions_repository/questions_repository.dart';
import '../../../data/repositories/user_instance_repository/user_instance_repository.dart';
import '../../entities/game_flow/question_entity.dart';
import 'usecase.dart';

@Injectable()
class DrawQuestionUseCase implements UseCase<QuestionEntity, void> {
  final UserInstanceRepository _userInstanceRepository;
  final QuestionsRepository _questionsRepository;

  const DrawQuestionUseCase(this._userInstanceRepository, this._questionsRepository);

  @override
  Future<Either<Failure, QuestionEntity>> call([void noParams]) async {
    final result = await _userInstanceRepository.getUserInstance();
    final questions = await _questionsRepository.getQuestions();
    return result.fold(
      (failure) => Left(failure),
      (dto) => questions.fold(
        (failure) => Left(failure),
        (questions) async {
          final drawnQuestion = _drawQuestion(instance: dto, questions: questions);
          final updatedInstance = dto.copyWith(
            askedQuestions: ((dto.askedQuestions)..add(drawnQuestion.id)),
          );
          await _userInstanceRepository.saveUserInstance(updatedInstance);
          return Right(drawnQuestion);
        },
      ),
    );
  }

  QuestionEntity _drawQuestion({required UserInstanceDto instance, required List<QuestionDto> questions}) {
    final neverUsedQuestionsIds = List<int>.generate(questions.length, (i) => i)
      ..removeWhere((id) => instance.askedQuestions.contains(id));
    final drawnQuestionId = (neverUsedQuestionsIds..shuffle()).first;
    return QuestionEntity.fromDto(questions[drawnQuestionId]);
  }
}
