import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/logger/logger.dart';
import '../../../presentation/setting_game/cubit/setting_game_cubit.dart';
import '../../dto/user_setting_dto.dart';
import '../../failures/failure.dart';
import '../../local_data_source/setting_local_data_source/user_setting_local_data_source.dart';
import 'config_setting_repository.dart';

@Injectable(as: UserSettingRepository)
class UserSettingRepositoryImpl implements UserSettingRepository {
  final UserSettingLocalDataSource _localDataSource;

  UserSettingRepositoryImpl(this._localDataSource);

  @override
  Future<Either<Failure, UserSettingDto>> getUserSetting() async {
    try {
      var _isMusicEnabled = (await _localDataSource.getSettingState(settingType: userSetting.isMusicEnabled)) ?? true;
      var _isSoundEffectEnabled =
          (await _localDataSource.getSettingState(settingType: userSetting.isSoundEffectEnabled)) ?? true;
      var _isStoryEnabled = (await _localDataSource.getSettingState(settingType: userSetting.isStoryEnabled)) ?? true;
      var _isCountingEnabled =
          (await _localDataSource.getSettingState(settingType: userSetting.isCountingEnabled)) ?? true;

      final setting = UserSettingDto(
        isMusicEnabled: _isMusicEnabled,
        isSoundEffectEnabled: _isSoundEffectEnabled,
        isCountingEnabled: _isCountingEnabled,
        isStoryEnabled: _isStoryEnabled,
      );
      return Right(setting);
    } on Exception catch (e) {
      AppLogger.error(e);
      return Left(Failure.databaseClientFailure());
    }
  }

  @override
  Future<Either<Failure, void>> saveUserSetting(UserSettingDto value) async {
    try {
      await _localDataSource.saveSettingState(state: value.isMusicEnabled, settingType: userSetting.isMusicEnabled);
      await _localDataSource.saveSettingState(
          state: value.isSoundEffectEnabled, settingType: userSetting.isSoundEffectEnabled);
      await _localDataSource.saveSettingState(state: value.isStoryEnabled, settingType: userSetting.isStoryEnabled);

      return Right(await _localDataSource.saveSettingState(
          state: value.isCountingEnabled, settingType: userSetting.isCountingEnabled));
    } on Exception catch (e) {
      AppLogger.error(e);
      return Left(Failure.databaseClientFailure());
    }
  }

  @override
  Future<Either<Failure, void>> saveUserSoundSetting({required bool value}) async {
    try {
      await _localDataSource.saveSettingState(state: value, settingType: userSetting.isSoundEffectEnabled);
      return Right(
          await _localDataSource.saveSettingState(state: value, settingType: userSetting.isSoundEffectEnabled));
    } on Exception catch (e) {
      AppLogger.error(e);
      return Left(Failure.databaseClientFailure());
    }
  }

  @override
  Future<Either<Failure, void>> saveUserMusicSetting({required bool value}) async {
    try {
      await _localDataSource.saveSettingState(state: value, settingType: userSetting.isMusicEnabled);
      return Right(await _localDataSource.saveSettingState(state: value, settingType: userSetting.isMusicEnabled));
    } on Exception catch (e) {
      AppLogger.error(e);
      return Left(Failure.databaseClientFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> getUserStorySetting() async {
    try {
      var _isStoryEnabled = (await _localDataSource.getSettingState(settingType: userSetting.isStoryEnabled));
      if (_isStoryEnabled == null) _isStoryEnabled = true;

      return Right(_isStoryEnabled);
    } on Exception catch (e) {
      AppLogger.error(e);
      return Left(Failure.databaseClientFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> getUserMusicSetting() async {
    try {
      var _isMusicEnabled = (await _localDataSource.getSettingState(settingType: userSetting.isMusicEnabled));
      if (_isMusicEnabled == null) _isMusicEnabled = true;
      return Right(_isMusicEnabled);
    } on Exception catch (e) {
      AppLogger.error(e);
      return Left(Failure.databaseClientFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> getUserSoundSetting() async {
    try {
      var _isSoundEffectEnabled =
          (await _localDataSource.getSettingState(settingType: userSetting.isSoundEffectEnabled));
      if (_isSoundEffectEnabled == null) _isSoundEffectEnabled = true;
      return Right(_isSoundEffectEnabled);
    } on Exception catch (e) {
      AppLogger.error(e);
      return Left(Failure.databaseClientFailure());
    }
  }
}
