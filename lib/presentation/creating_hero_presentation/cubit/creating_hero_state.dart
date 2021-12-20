part of "creating_hero_cubit.dart";

@freezed
class CreatingHeroState with _$CreatingHeroState {
  const factory CreatingHeroState.initial() = _CreatingHeroStateInitial;

  const factory CreatingHeroState.failure() = _CreatingHeroStateFailure;

  @Implements(CreatingHeroStateSavedInstance)
  const factory CreatingHeroState.savedInstance({required StoryDescriptionEntity story}) =
      _CreatingHeroStateSavedInstance;
  const factory CreatingHeroState.changePage() = _CreatingHeroChangePage;

  const factory CreatingHeroState.textFieldEmpty() = _CreatingHeroTextFieldEmpty;

  const factory CreatingHeroState.textTooManySigns() = _CreatingHeroTextTooManySigns;

  const factory CreatingHeroState.backButton() = _CreatingHeroBackButton;

  const factory CreatingHeroState.cleanState() = _CreatingHeroCleanState;
}

abstract class CreatingHeroStateSavedInstance {}
