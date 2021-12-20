import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/base_features/base/cubit/base_cubit.dart';
import '../../../../../domain/entities/artefacts/artefact_entity.dart';
import '../../../../../domain/entities/game_flow/user_instance_entity.dart';
import '../../../../../domain/use_case/artefacts/draw_artefact_usecase.dart';
import '../../../../../domain/use_case/core/get_user_instance_usecase.dart';
import '../../../../../domain/use_case/core/save_user_instance_usecase.dart';
import '../../../../game_flow/cubit/game_flow_cubit.dart';

part 'quiz_result_cubit.freezed.dart';
part 'quiz_result_state.dart';

@Injectable()
class QuizResultCubit extends BaseCubit<QuizResultState> {
  final DrawArtefactUsecase _drawArtefactUsecase;
  final GetUserInstanceUsecase _getUserInstanceUsecase;
  final SaveUserInstanceUseCase _saveUserInstanceUseCase;

  QuizResultCubit(
    this._drawArtefactUsecase,
    this._getUserInstanceUsecase,
    this._saveUserInstanceUseCase,
  ) : super(QuizResultState.initial());

  @override
  Future<void> init({
    QuizResult? result,
    int? points,
    bool? isDiamondActionActive,
  }) async {
    await _getUserInstanceUsecase()
      ..fold(
        (l) => emit(QuizResultState.failure()),
        (instance) async {
          if (instance.lifes <= 1 && result != QuizResult.correct && !isDiamondActionActive!) {
            await _saveUserInstanceUseCase(instance.copyWith(lifes: 0));
            emit(QuizResultState.endGame());
          } else {
            emit(QuizResultState.userInstance(value: instance));
            _drawArtefact(instance, points, result, isDiamondActionActive);
          }
        },
      );
  }

  Future<void> _drawArtefact(instance, points, result, isDiamondActionActive) async {
    await _drawArtefactUsecase()
      ..fold(
        (l) => emit(QuizResultState.failure()),
        (artefact) {
          emit(QuizResultState.newArtefact(value: artefact));
          _updateUserInstance(instance, artefact, result, points, isDiamondActionActive);
        },
      );
  }

  Future<void> _updateUserInstance(instance, artefact, result, points, isDiamondActionActive) async {
    UserInstanceEntity newInstance;
    final int updateLifes =
        (result == QuizResult.correct || isDiamondActionActive) ? instance.lifes : instance.lifes - 1;
    newInstance = instance.copyWith(
      level: instance.level + 1,
      points: instance.points + points,
      lifes: updateLifes,
    );

    await _saveUserInstanceUseCase(newInstance);
  }
}
