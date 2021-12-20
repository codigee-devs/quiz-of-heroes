import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../data/failures/failure.dart';
import '../../../../../data/local_data_source/setting_local_data_source/user_setting_local_data_source.dart';
import '../../../../../presentation/setting_game/cubit/setting_game_cubit.dart';

abstract class SoundPlayerRepository {
  Future<Either<Failure, bool>> getSoundState();
  Future<Either<Future, void>> saveNewSoundState({required bool state});
}

@Injectable(as: SoundPlayerRepository)
class SoundPlayerRepositoryImpl implements SoundPlayerRepository {
  final UserSettingLocalDataSource _soundPlayerDataSource;
  const SoundPlayerRepositoryImpl(this._soundPlayerDataSource);

  @override
  Future<Either<Failure, bool>> getSoundState() async {
    final state = await _soundPlayerDataSource.getSettingState(settingType: userSetting.isMusicEnabled) ?? true;

    return Right(state);
  }

  @override
  Future<Either<Future, void>> saveNewSoundState({required bool state}) async =>
      Right(await _soundPlayerDataSource.saveSettingState(state: state, settingType: userSetting.isMusicEnabled));
}
