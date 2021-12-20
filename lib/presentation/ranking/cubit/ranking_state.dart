part of 'ranking_cubit.dart';

@freezed
 class RankingState with _$RankingState {
  @Implements(RankingStateLoaded)
  const factory RankingState.initial() = _RankingStateInitial;

  @Implements(RankingStateLoaded)
  const factory RankingState.showRankingList({required List<UserInstanceEntity> entities}) = _RankingStateLoaded;

  @Implements(RankingStateLoaded)
  const factory RankingState.showCurrentScore({required UserInstanceEntity entity}) = _RankingStateEntityLoaded;

  const factory RankingState.backToPreviousPageState() = _RankingStateOnTapBackButton;

  const factory RankingState.exitToMenuState() = _RankingStateOnTapExitButton;

  const factory RankingState.failure() = _RankingStateFailure;

  const factory RankingState.clearState() = _RankingStateClearState;
}

abstract class RankingStateLoaded {}

abstract class RankingStateChangingPage {}
