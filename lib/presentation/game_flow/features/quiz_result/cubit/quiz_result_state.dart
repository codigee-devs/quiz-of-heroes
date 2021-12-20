part of 'quiz_result_cubit.dart';

@freezed
class QuizResultState with _$QuizResultState {
  @Implements(UpdateUserInstance)
  const factory QuizResultState.initial() = _QuizResultStateInitial;

  @Implements(UpdateDrawnArtefact)
  const factory QuizResultState.newArtefact({required ArtefactEntity value}) = _QuizResultStateNewArtefact;

  @Implements(UpdateUserInstance)
  const factory QuizResultState.userInstance({required UserInstanceEntity value}) = _QuziResultStateUserInstance;

  @Implements(FailureState)
  const factory QuizResultState.failure() = _QuizResultStateFailure;

  const factory QuizResultState.endGame() = _QuizResultStateEndGame;
}

abstract class UpdateDrawnArtefact {}

abstract class UpdateUserInstance {}
