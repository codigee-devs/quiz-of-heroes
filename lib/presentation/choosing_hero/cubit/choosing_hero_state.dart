part of 'choosing_hero_cubit.dart';

@freezed
class ChoosingHeroState with _$ChoosingHeroState {
  const factory ChoosingHeroState.initial() = _ChossingHeroStateInitial;

  @Implements(LayoutBuilderState)
  const factory ChoosingHeroState.getHeroes({required List<HeroEntity> heroes}) = _ChoosingHeroStateLoaded;

  const factory ChoosingHeroState.chooseHero({required HeroEntity hero}) = _ChoosingHeroStateChangingPage;

  const factory ChoosingHeroState.clearState() = _ChoosingHeroStateClearState;

  const factory ChoosingHeroState.failure() = _ChoosingHeroStateFailure;
}
