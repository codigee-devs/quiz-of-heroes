import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/base_features/base/cubit/base_cubit.dart';
import '../../../data/failures/failure.dart';
import '../../../domain/entities/game_flow/user_instance_entity.dart';
import '../../../domain/entities/history/story_description_entity.dart';
import '../../../domain/use_case/core/check_if_instance_exist_usecase.dart';
import '../../../domain/use_case/core/get_user_instance_usecase.dart';
import '../../../domain/use_case/core/save_user_general_usecase.dart';
import '../../../domain/use_case/history/get_hero_history_usecase.dart';
import '../page/home_page.dart';

part 'home_cubit.freezed.dart';
part 'home_state.dart';

@Injectable()
class HomeCubit extends BaseCubit<HomeState> {
  final GetUserInstanceUsecase _getUserInstanceUsecase;
  final GetHeroHistoryUsecase _getHeroHistoryUseCase;
  final SaveUserGeneralInstanceUseCase _saveUserGeneralInstanceUseCase;
  final CheckIfInstanceExistUseCase _checkIfInstanceExistUseCase;

  static const int _introOfStory = 0;

  HomeCubit(this._getUserInstanceUsecase, this._saveUserGeneralInstanceUseCase,
      this._checkIfInstanceExistUseCase, this._getHeroHistoryUseCase)
      : super(HomeState.initial());

  @override
  Future<void> init() async {
    final result = await _getUserInstanceUsecase();
    result.fold(
      (failure) => _failureCase,
      (result) => emit(HomeState.gameWasSaved()),
    );
  }

  Future<void> didTapButton(HomeButtonType buttonType) async {
    emit(HomeState.changePage(button: buttonType));
    emit(HomeState.clearState());
  }

  Future<void> didTapSaveButton() async {
    final isInstanceAlreadyExist = (await _checkIfInstanceExistUseCase()).fold(
      (failure) => failure,
      (r) => r,
    );

    final currInstance = (await _getUserInstanceUsecase()).fold(
      (failure) => failure,
      (r) => r,
    );

    if ([isInstanceAlreadyExist, currInstance].any((e) => e is Failure)) {
      emit(HomeState.failure());
    } else if ((isInstanceAlreadyExist) == false) {
      _savingGeneralInstance((currInstance as UserInstanceEntity));
    }
  }

  void _failureCase(Failure failure) => failure.maybeWhen(
        (failureInstanceNotExist) => emit(HomeState.initial()),
        orElse: () => emit(HomeState.failure()),
      );

  Future<void> _savingGeneralInstance(UserInstanceEntity currInstance) async =>
      (await _saveUserGeneralInstanceUseCase(currInstance)).fold(
        (failure) => failure,
        (r) => emit(HomeState.savedInstance()),
      );

  Future<void> didTapStartButton() async {
    final result = await _getHeroHistoryUseCase(_introOfStory, _introOfStory);
    result.fold(
      _failureCase,
      (result) => emit(HomeState.startGame(story: result)),
    );
  }
}
