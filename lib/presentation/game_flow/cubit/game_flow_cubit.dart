import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/base_features/base/cubit/base_cubit.dart';
import '../../../core/base_features/sound_player/sound_player.dart';
import '../../../core/config/config.dart';
import '../../../core/presentation/values/values.dart';
import '../../../data/failures/failure.dart';
import '../../../domain/entities/artefacts/user_artefact_entity.dart';
import '../../../domain/entities/game_flow/question_entity.dart';
import '../../../domain/entities/game_flow/user_instance_entity.dart';
import '../../../domain/entities/history/story_description_entity.dart';
import '../../../domain/use_case/artefacts/get_user_artefacts_usecase.dart';
import '../../../domain/use_case/core/clear_user_instance_usecase.dart';
import '../../../domain/use_case/core/draw_question_usecase.dart';
import '../../../domain/use_case/core/get_user_instance_usecase.dart';
import '../../../domain/use_case/gainedStory/save_gained_story_usecase.dart';
import '../../../domain/use_case/history/get_hero_history_usecase.dart';
import '../../../domain/use_case/settings/get_user_story_setting_usecase.dart';

part 'game_flow_cubit.freezed.dart';
part 'game_flow_state.dart';

@Injectable()
class GameFlowCubit extends BaseCubit<GameFlowState> {
  final ClearUserInstanceUseCase _clearUserInstanceUseCase;
  final DrawQuestionUseCase _drawQuestionUseCase;
  final GetHeroHistoryUsecase _getHeroHistoryUsecase;
  final GetUserArtefactsUseCase _getUserArtefactsUseCase;
  final GetUserInstanceUsecase _getUserInstanceUsecase;
  final GetUserStorySettingUsecase _getUserStorySettingUseCase;
  final SaveGainedStoryUseCase _saveGainedStoryUseCase;

  final SoundPlayer soundPlayer;

  GameFlowCubit(
    this._clearUserInstanceUseCase,
    this._drawQuestionUseCase,
    this._getHeroHistoryUsecase,
    this._getUserArtefactsUseCase,
    this._getUserInstanceUsecase,
    this._getUserStorySettingUseCase,
    this._saveGainedStoryUseCase,
    this.soundPlayer,
  ) : super(GameFlowState.initial());

  @override
  Future<void> init() async => runNextLevel();

  Future<void> didBackToMenu() async => emit(GameFlowState.backToMenu());
  Future<void> goToTheLevel() async {
    (await _getUserInstanceUsecase()).fold(
      (failure) => emit(GameFlowState.failure()),
      (instance) => _ifDisplayStory(instance: instance),
    );
  }

  Future<void> runNextLevel() async {
    (await _getUserInstanceUsecase()).fold(
      (failure) => emit(GameFlowState.failure()),
      (entity) => emit(GameFlowState.nextLevel(instance: entity)),
    );
  }

  Future<void> didShowNewQuestion({required UserInstanceEntity instance}) async {
    emit(GameFlowState.empty());
    final question = (await _drawQuestionUseCase()).fold(
      (l) => l,
      (entity) => entity,
    );
    final artefacts = (await _getUserArtefactsUseCase()).fold(
      (l) => l,
      (entities) => entities,
    );

    if ([question, artefacts].any((e) => e is Failure)) {
      emit(GameFlowState.failure());
    } else {
      emit(
        GameFlowState.quiz(
          question: (question as QuestionEntity),
          userInstance: instance,
          userArtefacts: (artefacts as List<UserArtefactEntity>),
        ),
      );
    }
  }

  Future<void> didQuizTimeout({
    required String correctAnswer,
    required bool isDiamondActionActive,
  }) async =>
      didConfirmAnswer(
        isDiamondActionActive: isDiamondActionActive,
        correctAnswer: correctAnswer,
        newPoints: 0,
        result: QuizResult.timeout,
      );

  Future<void> didTapStartButton({
    required UserInstanceEntity instance,
    required List<UserArtefactEntity> artefacts,
    required QuestionEntity question,
  }) async {
    soundPlayer.playShort(AppSounds.wavQuizUnveilQuestion);

    return emit(GameFlowState.quiz(
      question: question,
      userArtefacts: artefacts,
      userInstance: instance,
    ));
  }

  Future<void> didConfirmAnswer({
    required QuizResult result,
    required int newPoints,
    required String correctAnswer,
    required bool isDiamondActionActive,
  }) async {
    (await _getUserInstanceUsecase()).fold(
      (failure) => emit(GameFlowState.failure()),
      (instance) async {
        if (result != QuizResult.correct && instance.lifes <= 1 && isDiamondActionActive == false) {
          soundPlayer.playShort(AppSounds.wavQuizLose);
          await _clearUserInstanceUseCase();
          emit(GameFlowState.gameOver(instance: instance, correctAnswer: correctAnswer));
        } else {
          soundPlayer.playShort(AppSounds.wavQuizWin2);
          emit(
            GameFlowState.result(
              quizResult: result,
              newPoints: newPoints,
              correctAnswer: correctAnswer,
              isDiamondActionActive: isDiamondActionActive,
            ),
          );
        }
      },
    );
  }

  Future<void> _ifDisplayStory({required UserInstanceEntity instance}) async {
    final isStoryEnabled = (await _getUserStorySettingUseCase()).fold(
      (failure) => failure,
      (r) => r,
    );
    if (instance.level % AppConfig.howOftenDisplayStory == 0) {
      final values = Params(instance.hero.id, _getNextStoryId(instance: instance));
      await _saveGainedStoryUseCase(values);
    }

    if (isStoryEnabled == Failure()) {
      emit(GameFlowState.failure());
    } else if (instance.level % AppConfig.howOftenDisplayStory == 0 && isStoryEnabled == true && instance.level < 102) {
      (await _getHeroHistoryUsecase(
        instance.hero.id,
        _getNextStoryId(instance: instance),
      ))
          .fold(
        (l) => emit(GameFlowState.failure()),
        (story) => emit(GameFlowState.goToStory(story)),
      );
    } else {
      emit(GameFlowState.nextLevel(instance: instance));
    }
  }

  int _getNextStoryId({required UserInstanceEntity instance}) => (instance.level ~/ AppConfig.howOftenDisplayStory + 1);
}
