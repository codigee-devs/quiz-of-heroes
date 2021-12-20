part of 'artefact_info_cubit.dart';

@freezed
class ArtefactInfoState with _$ArtefactInfoState {
  @Implements(ArtefactInfoStateLoaded)
  const factory ArtefactInfoState.initial() = _ArtefactInfoStateInitial;

  const factory ArtefactInfoState.failure() = _ArtefactInfoStateFailure;

  const factory ArtefactInfoState.onTapBackButton() = _ArtefactInfoStateOnTapBackButton;

  const factory ArtefactInfoState.onTapExitButton() = _ArtefactInfoStateOnTapExitButton;
}

abstract class ArtefactInfoStateLoaded {}
