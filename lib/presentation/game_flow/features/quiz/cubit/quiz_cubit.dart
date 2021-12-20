import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/base_features/base/cubit/base_cubit.dart';
import '../../../../../core/logger/logger.dart';
import '../../../../../core/presentation/values/values.dart';
import '../../../../../data/dto/artefact_dto.dart';
import '../../../../../domain/entities/artefacts/artefact_entity.dart';
import '../../../../../domain/entities/game_flow/question_entity.dart';
import '../../../../../domain/use_case/artefacts/use_user_artefact_usecase.dart';
import '../../../../../domain/use_case/core/get_user_instance_usecase.dart';
import '../../../../../domain/use_case/core/save_user_instance_usecase.dart';

part 'extension/artefact_action_extension.dart';
part 'quiz_cubit.freezed.dart';
part 'quiz_state.dart';

@Injectable()
class QuizCubit extends BaseCubit<QuizState> {
  final GetUserInstanceUsecase _getUserInstanceUsecase;
  final SaveUserInstanceUseCase _saveUserInstanceUseCase;
  final UseUserArtefactUseCase _useUserArtefactUseCase;

  QuizCubit(
    this._getUserInstanceUsecase,
    this._saveUserInstanceUseCase,
    this._useUserArtefactUseCase,
  ) : super(QuizState.initial());

  static const int _unselectedButtonId = -1;

  @override
  Future<void> init() async => emit(QuizState.showQuestion());

  Future<void> didShowAnswers() async {
    emit(QuizState.showAnswers());
    emit(QuizState.updateButtons(id: _unselectedButtonId));
  }

  Future<void> didUpdateButtons({required int id}) async => emit(QuizState.updateButtons(id: id));

  Future<void> didStartTimer() async => emit(QuizState.runTimer());

  Future<void> changeArtefactsClickability({required bool areClickable}) async =>
      emit(QuizState.clickableArtefacts(areClickable: areClickable));

  Future<void> didTapArtefactButton({
    required ArtefactEntity artefact,
    required QuestionEntity question,
    required int activeButton,
  }) async {
    await _useUserArtefactUseCase(artefact.id);
    return artefact.actions.forEach(
      (action) async => emit(
        await _artefactActionToState(
          action: action,
          activeButton: activeButton,
          question: question,
        ),
      ),
    );
  }
}
