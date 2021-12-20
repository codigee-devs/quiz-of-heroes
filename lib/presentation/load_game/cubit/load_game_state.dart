part of 'load_game_cubit.dart';

@freezed
class LoadGameState with _$LoadGameState {
  const factory LoadGameState.initial() = _LoadGameStateInitial;

  const factory LoadGameState.failure() = _LoadGameStateFailure;

  @Implements(LoadGameStateGetSaves)
  const factory LoadGameState.getSaves({required List<UserInstanceEntity> saves}) = _LoadGameStateGetSaves;
  @Implements(LoadGameStateOnTapBackButton)
  const factory LoadGameState.onTapBackButton() = _LoadGameStateOnTapBackButton;
  @Implements(LoadGameStateClearState)
  const factory LoadGameState.clearState() = _LoadGameStateClearState;
  @Implements(LoadGameStateOnTapBackButton)
  const factory LoadGameState.onTapExitButton() = _LoadGameStateOnTapExitButton;

  @Implements(LoadGameStateStartGame)
  const factory LoadGameState.startGame() = _LoadGameStateStartGame;
}

abstract class LoadGameStateStartGame {}

abstract class LoadGameStateGetSaves {}

abstract class LoadGameStateOnTapBackButton {}

abstract class LoadGameStateClearState {}

abstract class LoadGameStateOnTapExitButton {}
