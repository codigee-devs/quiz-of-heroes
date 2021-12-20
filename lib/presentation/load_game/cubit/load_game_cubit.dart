import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/base_features/base/cubit/base_cubit.dart';
import '../../../core/logger/logger.dart';
import '../../../data/failures/failure.dart';
import '../../../domain/entities/game_flow/user_instance_entity.dart';
import '../../../domain/use_case/core/check_if_chosen_instance_current_exist.dart';
import '../../../domain/use_case/core/get_user_general_usecase.dart';
import '../../../domain/use_case/core/get_user_instance_usecase.dart';
import '../../../domain/use_case/core/save_user_general_usecase.dart';
import '../../../domain/use_case/core/save_user_instance_usecase.dart';

part 'load_game_cubit.freezed.dart';
part 'load_game_state.dart';

@Injectable()
class LoadGameCubit extends BaseCubit<LoadGameState> {
  final GetUserGeneralInstanceUsecase _getUserGeneralInstanceUsecase;
  final GetUserInstanceUsecase _getUserInstanceUsecase;
  final SaveUserGeneralInstanceUseCase _saveUserGeneralInstanceUseCase;
  final SaveUserInstanceUseCase _saveUserInstanceUseCase;
  final CheckIfChosenInstanceAlreadyExistUseCase _checkIfChosenInstanceAlreadyExistUseCase;

  LoadGameCubit(
    this._getUserGeneralInstanceUsecase,
    this._saveUserInstanceUseCase,
    this._getUserInstanceUsecase,
    this._saveUserGeneralInstanceUseCase,
    this._checkIfChosenInstanceAlreadyExistUseCase,
  ) : super(LoadGameState.initial());

  @override
  Future<void> init() async => getSaves();

  Future<void> getSaves() async {
    (await _getUserGeneralInstanceUsecase()).fold(
      (l) => emit(LoadGameState.failure()),
      (savesOfPlayer) => emit(LoadGameState.getSaves(saves: savesOfPlayer)),
    );
  }

  Future<void> didTapBackButton() async {
    emit(LoadGameState.onTapBackButton());
    emit(LoadGameState.clearState());
  }

  Future<void> didTapCancelButton() async => emit(LoadGameState.onTapExitButton());

  Future<void> didTapChooseHero(UserInstanceEntity saves) async {
    final currentInstance = (await _getUserInstanceUsecase()).fold(
      (failure) => failure,
      (instanceOfGame) => instanceOfGame,
    );

    final savingAsCurrentInstance = await _saveUserInstanceUseCase(saves);
    savingAsCurrentInstance.fold(
      (failure) => failure,
      (r) => AppLogger.dev('The save has been loaded'),
    );
    if ([currentInstance, savingAsCurrentInstance].any((e) => e != Failure)) {
      final isChosenInstanceExist =
          (await _checkIfChosenInstanceAlreadyExistUseCase(currentInstance as UserInstanceEntity)).fold(
        (failure) => failure,
        (r) => r,
      );

      if (isChosenInstanceExist != Failure && isChosenInstanceExist == false) {
        _savingInstanceToGeneral(currentInstance);
      } else {
        emit(LoadGameState.startGame());
      }
    } else {
      emit(LoadGameState.failure());
    }
  }

  Future<void> _savingInstanceToGeneral(UserInstanceEntity currentInstance) async {
    (await _saveUserGeneralInstanceUseCase((currentInstance))).fold(
      (failure) => emit(LoadGameState.failure()),
      (r) => emit(LoadGameState.startGame()),
    );
  }
}
