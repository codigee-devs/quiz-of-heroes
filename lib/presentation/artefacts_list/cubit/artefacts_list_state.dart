part of "artefacts_list_cubit.dart";

@freezed
 class ArtefactsListState with _$ArtefactsListState {
  @Implements(ArtefactsListStateLoaded)
  const factory ArtefactsListState.initial() = _ArtefactsListStateInitial;

  @Implements(ArtefactsListStateLoaded)
  const factory ArtefactsListState.getArtefacts({required List<ArtefactEntity> artefacts}) = _ArtefactsListStateLoaded;

  @Implements(ArtefactsListStateChangingPage)
  const factory ArtefactsListState.chooseArtefact({required ArtefactEntity artefacts}) =
      _ArtefactsListStateChangingPage;

  const factory ArtefactsListState.onTapBackButton() = _ArtefactListStateOnTapBackButton;

  const factory ArtefactsListState.onTapExitButton() = _ArtefactListStateOnTapExitButton;

  const factory ArtefactsListState.failure() = _ArtefactsListStateFailure;

  const factory ArtefactsListState.clearState() = _ArtefactsListStateClearState;
}

abstract class ArtefactsListStateLoaded {}

abstract class ArtefactsListStateChangingPage {}
