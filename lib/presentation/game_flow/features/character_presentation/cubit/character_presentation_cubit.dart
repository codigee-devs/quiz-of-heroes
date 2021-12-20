import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/base_features/base/cubit/base_cubit.dart';
import '../../../../../data/failures/failure.dart';
import '../../../../../domain/entities/artefacts/user_artefact_entity.dart';
import '../../../../../domain/entities/game_flow/question_entity.dart';
import '../../../../../domain/entities/game_flow/user_instance_entity.dart';
import '../../../../../domain/use_case/artefacts/get_user_artefacts_usecase.dart';
import '../../../../../domain/use_case/core/draw_question_usecase.dart';

part 'character_presentation_cubit.freezed.dart';
part 'character_presentation_state.dart';

@Injectable()
class CharacterPresentationCubit extends BaseCubit<CharacterPresentationState> {
  final GetUserArtefactsUseCase _getUserArtefactsUseCase;
  final DrawQuestionUseCase _drawQuestionUseCase;

  CharacterPresentationCubit(this._getUserArtefactsUseCase, this._drawQuestionUseCase)
      : super(CharacterPresentationState.initial());

  Future<void> init({UserInstanceEntity? instance}) async {
    if (instance != null) {
      _getEntities(instance: instance);
    } else {
      emit(CharacterPresentationState.failure());
    }
  }

  Future<void> _getEntities({required UserInstanceEntity instance}) async {
    final artefacts = (await _getUserArtefactsUseCase()).fold(
      (failure) => failure,
      (entities) => entities,
    );

    final question = (await _drawQuestionUseCase()).fold(
      (failure) => failure,
      (entity) => entity,
    );
    if ([artefacts, question].any((e) => e != Failure)) {
      emit(
        CharacterPresentationState.loaded(
          instance: instance,
          userArtefacts: (artefacts as List<UserArtefactEntity>),
          question: (question as QuestionEntity),
        ),
      );
    } else {
      emit(CharacterPresentationState.failure());
    }
  }
}
