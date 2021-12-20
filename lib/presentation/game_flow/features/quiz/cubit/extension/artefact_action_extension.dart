part of '../quiz_cubit.dart';

extension ArtefactsExtension on QuizCubit {
  // function selects random answers for actions
  List<int> generateRandomIds({required QuestionEntity question, required int count, bool includeCorrect = false}) {
    if (count > 4) {
      AppLogger.error('[generateRandomIds]: Count cannot exceed the number of responses, function return empty array');
      return List<int>.empty();
    }

    final ids = question.answers.map((question) => question.id).toList()..remove(question.correctAnswerId);
    final generated = (ids.toList()..shuffle()).sublist(0, (includeCorrect ? count - 1 : count));
    includeCorrect ? generated.add(question.correctAnswerId) : null;
    return generated;
  }

  Future<QuizState> addLife({required int count}) async => await _getUserInstanceUsecase().then(
        (value) => value.fold(
          (l) => QuizState.failure(),
          (instance) async {
            await _saveUserInstanceUseCase(instance.copyWith(lifes: instance.lifes + 1));
            return QuizState.addLife(count: count);
          },
        ),
      );

  Future<QuizState> _artefactActionToState({
    required ArtefactAction action,
    QuestionEntity? question,
    int? activeButton,
  }) async {
    switch (action) {
      case ArtefactAction.pauseTime:
        return QuizState.pauseTimer(duration: AppDurations.artefactActionPauseTimeDuration);

      case ArtefactAction.addOneLife:
        return await addLife(count: 1);

      case ArtefactAction.godQuestion:
        return QuizState.godQuestion();

      case ArtefactAction.destroyQuestion:
        return QuizState.runBombAnimation();

      case ArtefactAction.hideOneAnswer:
        return QuizState.hideAnswers(
          activeButton: activeButton!,
          hiddenAnswers: generateRandomIds(count: 1, question: question!),
        );

      case ArtefactAction.hideTwoAnswers:
        return QuizState.hideAnswers(
          activeButton: activeButton!,
          hiddenAnswers: generateRandomIds(count: 2, question: question!),
        );

      case ArtefactAction.lessOpacityTwoWrongAnswers:
        return await QuizState.lessOpacity(
          activeButton: activeButton!,
          selectedAnswers: generateRandomIds(count: 2, question: question!),
        );

      case ArtefactAction.selectHalfAnswers:
        return await QuizState.selectCorrectAnswers(
          activeButton: activeButton!,
          selectedAnswers: generateRandomIds(count: 2, question: question!, includeCorrect: true),
        );
    }
  }
}
