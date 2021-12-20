part of "home_cubit.dart";

@freezed
 class HomeState with _$HomeState {
  const factory HomeState.initial() = _HomeStateInitial;

  const factory HomeState.failure() = _HomeStateFailure;

  @Implements(HomeStateGameWasSaved)
  const factory HomeState.gameWasSaved() = _HomeStateWasSaved;

  @Implements(HomeStateChangePage)
  const factory HomeState.changePage({required HomeButtonType button}) = _HomeStateChangePage;

  @Implements(HomeStateSavedInstance)
  const factory HomeState.savedInstance() = _HomeStateSavedInstance;

  const factory HomeState.clearState() = _HomeStateClearState;

  @Implements(HomeStateStartGame)
  const factory HomeState.startGame({required StoryDescriptionEntity story}) = _HomeStateStartGame;
}

abstract class HomeStateGameWasSaved {}

abstract class HomeStateChangePage {}

abstract class HomeStateSavedInstance {}

abstract class HomeStateStartGame {}
