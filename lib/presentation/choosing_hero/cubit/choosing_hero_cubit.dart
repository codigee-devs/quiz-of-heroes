import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/base_features/base/cubit/base_cubit.dart';
import '../../../domain/entities/hero/hero_entity.dart';
import '../../../domain/use_case/heroes/get_heroes_usecase.dart';

part 'choosing_hero_cubit.freezed.dart';
part 'choosing_hero_state.dart';

@Injectable()
class ChoosingHeroCubit extends BaseCubit<ChoosingHeroState> {
  final GetHeroesUsecase _getHeroesUsecase;
  ChoosingHeroCubit(this._getHeroesUsecase) : super(ChoosingHeroState.initial());

  @override
  Future<void> init() async {
    final heroes = await _getHeroesUsecase();
    heroes.fold(
      (failue) => emit(ChoosingHeroState.failure()),
      (heroes) => emit(ChoosingHeroState.getHeroes(heroes: heroes)),
    );
  }

  Future<void> didTapChooseHero(HeroEntity hero) async {
    emit(ChoosingHeroState.chooseHero(hero: hero));
    emit(ChoosingHeroState.clearState());
  }

}
