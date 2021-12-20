part of 'game_flow_cubit.dart';

///
/// [correct] => user earn life, get artefact and points
/// [wrong] => user lose life but get new artefact
/// [timeout] => same as wrong
///

enum QuizResult { correct, wrong, timeout }

@freezed
 class GameFlowState with _$GameFlowState {
  @Implements(LayoutBuilderState)
  const factory GameFlowState.initial() = _Initial;

  @Implements(LayoutBuilderState)
  const factory GameFlowState.quiz({
    required QuestionEntity question,
    required UserInstanceEntity userInstance,
    required List<UserArtefactEntity> userArtefacts,
  }) = _GameFlowStateQuiz;

  @Implements(LayoutBuilderState)
  const factory GameFlowState.result({
    required QuizResult quizResult,
    required int newPoints,
    required String correctAnswer,
    required bool isDiamondActionActive,
  }) = _GameFlowStateResult;

  @Implements(LayoutBuilderState)
  const factory GameFlowState.nextLevel({required UserInstanceEntity instance}) = _GameFlowStateNextLevel;

  @Implements(FailureState)
  const factory GameFlowState.failure() = _GameFlowStateFailure;

  @Implements(LayoutBuilderState)
  const factory GameFlowState.empty() = _GameFlowStateEmpty;

  @Implements(GoToStory)
  const factory GameFlowState.goToStory(
    StoryDescriptionEntity story,
  ) = _GameFlowStateGoToStory;

  const factory GameFlowState.backToMenu() = _GameFlowStateBackToMenu;

  const factory GameFlowState.instanceLoaded({required UserInstanceEntity instance}) = _GameFlowStateInstanceLoaded;

  @Implements(LayoutBuilderState)
  const factory GameFlowState.gameOver({required UserInstanceEntity instance, String? correctAnswer}) = _GameFlowStateGameOver;
}

abstract class GoToStory {}
