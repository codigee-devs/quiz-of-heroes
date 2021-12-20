part of 'character_presentation_cubit.dart';

@freezed
 class CharacterPresentationState with _$CharacterPresentationState {
  const factory CharacterPresentationState.initial() = _CharacterPresentationStateInitial;

  @Implements(LayoutBuilderState)
  const factory CharacterPresentationState.loaded({
    required UserInstanceEntity instance,
    required List<UserArtefactEntity> userArtefacts,
    required QuestionEntity question,
  }) = _CharacterPresentationStateInstanceLoaded;

  @Implements(FailureState)
  const factory CharacterPresentationState.failure() = _CharacterPresentationStateInstanceFailure;
}
