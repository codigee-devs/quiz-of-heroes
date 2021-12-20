import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/base_features/base/cubit/base_cubit.dart';
import '../../../core/config/config.dart';
import '../../../domain/entities/game_flow/user_instance_entity.dart';
import '../../../domain/entities/hero/hero_entity.dart';
import '../../../domain/entities/history/story_description_entity.dart';
import '../../../domain/use_case/artefacts/create_user_artefacts_usecase.dart';
import '../../../domain/use_case/core/save_user_instance_usecase.dart';
import '../../../domain/use_case/gainedStory/save_gained_story_usecase.dart';
import '../../../domain/use_case/history/get_hero_history_usecase.dart';

part 'creating_hero_cubit.freezed.dart';
part 'creating_hero_state.dart';

@Injectable()
class CreatingHeroCubit extends BaseCubit<CreatingHeroState> {
  final SaveUserInstanceUseCase _saveInstanceUseCase;
  final CreateUserArtefactsUsecase _createUserArtefactsUsecase;
  final GetHeroHistoryUsecase _getHeroHistoryUsecase;
  final SaveGainedStoryUseCase _saveGainedStoryUseCase;

  static const int _firstHeadlineOfStory = 1;

  CreatingHeroCubit(
    this._saveInstanceUseCase,
    this._createUserArtefactsUsecase,
    this._getHeroHistoryUsecase,
    this._saveGainedStoryUseCase,
  ) : super(CreatingHeroState.initial());

  @override
  Future<void> init() async => emit(CreatingHeroState.initial());

  Future<void> didTapContinueButton(String name, HeroEntity hero) async {
    if (name.length > 14) {
      emit(CreatingHeroState.textTooManySigns());
    } else if (name.isNotEmpty) {
      final _userInstance = _generateUserInstance(hero: hero, name: name);
      final _instanceCallback = await _saveInstanceUseCase(_userInstance);
      final _artefactsCallback = await _createUserArtefactsUsecase(hero.id);

      if ([_instanceCallback, _artefactsCallback].any((e) => e.isLeft())) {
        emit(CreatingHeroState.failure());
      } else {
        (await _getHeroHistoryUsecase(hero.id, _firstHeadlineOfStory)).fold(
          (l) => emit(CreatingHeroState.failure()),
          (r) => emit(CreatingHeroState.savedInstance(story: r)),
        );
        final values = Params(hero.id, 1);
        _saveGainedStoryUseCase(values);
        emit(CreatingHeroState.cleanState());
      }
    } else {
      emit(CreatingHeroState.textFieldEmpty());
    }
  }

  Future<void> didTapBackButton() async => emit(CreatingHeroState.backButton());

  UserInstanceEntity _generateUserInstance({required HeroEntity hero, required String name}) => UserInstanceEntity(
        level: AppConfig.lvlInit,
        points: AppConfig.pointInit,
        lifes: hero.health,
        hero: hero,
        name: name,
        askedQuestions: [],
      );
}
