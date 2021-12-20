part of 'quiz_cubit.dart';

@freezed
class QuizState with _$QuizState {
  @Implements(ShowQuestionState)
  @Implements(ShowAnswersState)
  @Implements(UpdateButtonsState)
  @Implements(UpdateTimerState)
  const factory QuizState.initial() = _QuizStateInitial;

  @Implements(FailureState)
  const factory QuizState.failure() = _QuizStateFailure;

  const factory QuizState.showQuestion() = _QuizStateShowQuestion;
  @Implements(ShowAnswersState)
  const factory QuizState.showAnswers() = _QuizStateShowAnswers;

  @Implements(UpdateButtonsState)
  const factory QuizState.updateButtons({required int id}) = _QuizStateUpdateButtons;

  @Implements(UpdateButtonsState)
  const factory QuizState.hideAnswers({required int activeButton, required List<int> hiddenAnswers}) =
      _QuizStateHideAnswers;

  @Implements(UpdateButtonsState)
  const factory QuizState.desactiveAnswers({required QuestionEntity question}) = _QuizStateDesactiveAnswers;

  @Implements(UpdateTimerState)
  const factory QuizState.runTimer() = _QuizStateRunTimer;

  @Implements(UpdateTimerState)
  const factory QuizState.pauseTimer({required Duration duration}) = _QuizStatePauseTimer;

  @Implements(UpdateInstanceState)
  const factory QuizState.addLife({required int count}) = _QuizStateAddLife;

  @Implements(UpdateButtonsState)
  const factory QuizState.selectCorrectAnswers({required int activeButton, required List<int> selectedAnswers}) =
      _QuizStateSelectCorrectAnswers;

  @Implements(UpdateButtonsState)
  const factory QuizState.lessOpacity({required int activeButton, required List<int> selectedAnswers}) =
      _QuizStateLessOpacity;

  const factory QuizState.godQuestion() = _QuizStateGodQuestion;

  @Implements(UpdateArtefactsButtonsState)
  const factory QuizState.clickableArtefacts({required bool areClickable}) = _QuizStateClickableArtefacts;

  const factory QuizState.runBombAnimation() = _QuizStateRunBombAnimation;
}

abstract class ShowQuestionState {}

abstract class ShowAnswersState {}

abstract class UpdateButtonsState {}

abstract class UpdateTimerState {}

abstract class UpdateInstanceState {}

abstract class UpdateArtefactsButtonsState {}
