import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/base_features/base/cubit/base_cubit.dart';
import '../../../domain/entities/settings/user_setting_entity.dart';
import '../../../domain/use_case/settings/get_user_setting_usecase.dart';
import '../../../domain/use_case/settings/save_user_setting_usecase.dart';

part 'setting_game_cubit.freezed.dart';
part 'setting_game_state.dart';

@Injectable()
class SettingGameCubit extends BaseCubit<SettingGameState> {
  final GetUserSettingUsecase _getUserSettingUsecase;
  final SaveUserSettingUsecase _saveUserSettingUsecase;

  SettingGameCubit(this._getUserSettingUsecase, this._saveUserSettingUsecase) : super(SettingGameState.initial());

  @override
  Future<void> init() async {
    (await _getUserSettingUsecase.call()).fold(
      (failure) => emit(SettingGameState.failure()),
      (r) => emit(SettingGameState.displaySetting(valuesOfButtons: r)),
    );
  }

  Future<void> didTapBackButton() async {
    emit(SettingGameState.onTapBackButton());
    emit(SettingGameState.clearState());
  }

  Future<void> didTapCancelButton() async => emit(SettingGameState.onTapExitButton());

  Future<void> didTapSettingButton({required userSetting settingType, required UserSettingEntity settings}) async {
    final value = settings;
    switch (settingType) {
      case userSetting.isMusicEnabled:
        settings = value.copyWith(isMusicEnabled: !value.isMusicEnabled);
        break;
      case userSetting.isSoundEffectEnabled:
        settings = value.copyWith(isSoundEffectEnabled: !value.isSoundEffectEnabled);
        break;
      case userSetting.isCountingEnabled:
        settings = value.copyWith(isCountingEnabled: !value.isCountingEnabled);
        break;
      case userSetting.isStoryEnabled:
        settings = value.copyWith(isStoryEnabled: !value.isStoryEnabled);
        break;
    }

    (await _saveUserSettingUsecase(settings)).fold(
      (failure) => emit(SettingGameState.failure()),
      (r) => emit(SettingGameState.displaySetting(valuesOfButtons: settings)),
    );
  }
}

enum userSetting {
  isCountingEnabled,
  isMusicEnabled,
  isSoundEffectEnabled,
  isStoryEnabled,
}
