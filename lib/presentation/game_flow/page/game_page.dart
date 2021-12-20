import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/app/router.dart';
import '../../../core/base_features/base/cubit/base_cubit.dart';
import '../../../core/injection/injection.dart';
import '../cubit/game_flow_cubit.dart';
import '../features/character_presentation/page/character_presentation_page.dart';
import '../features/game_over/page/game_over_page.dart';
import '../features/quiz/page/quiz_page.dart';
import '../features/quiz_result/page/quiz_result_page.dart';

class GameFlowPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => getIt<GameFlowCubit>()..init(),
        child: _Body(),
      );
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) => BlocConsumer<GameFlowCubit, GameFlowState>(
        listener: (context, state) => state.maybeWhen(
          backToMenu: () => context.navigator.pushAndPopUntil(
            HomePageRoute(),
            predicate: (_) => false,
          ),
          goToStory: (story) => context.navigator.push(
            StoryPartPageRoute(
                onConfirmButtonCallback: () => context.navigator.pushAndPopUntil(
                      GameFlowPageRoute(),
                      predicate: (_) => false,
                    ),
                storyText: story),
          ),
          orElse: () => null,
        ),
        buildWhen: (p, c) => c is LayoutBuilderState,
        builder: (context, state) => state.maybeWhen(
          gameOver: (instance, correctAnswer) => GameOverPage(
            instance: instance,
            correctAnswer: correctAnswer ?? '',
          ),
          nextLevel: (instance) =>
              instance.lifes > 0 ? CharacterPresentationPage(instance: instance) : GameOverPage(instance: instance),
          quiz: (question, user, artefacts) => QuizPage(
            question: question,
            userInstance: user,
            artefacts: artefacts,
          ),
          result: (result, points, correctAnswer, isDiamondActionActive) => QuizResultPage(
            result: result,
            points: points,
            correctAnswer: correctAnswer,
            isDiamondActionActive: isDiamondActionActive,
          ),
          orElse: () => Container(),
        ),
      );
}
