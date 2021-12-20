import 'package:dartz/dartz.dart';

import '../../dto/user_setting_dto.dart';
import '../../failures/failure.dart';

abstract class UserSettingRepository {
  Future<Either<Failure, UserSettingDto>> getUserSetting();
  Future<Either<Failure, bool>> getUserStorySetting();
  Future<Either<Failure, bool>> getUserSoundSetting();
  Future<Either<Failure, bool>> getUserMusicSetting();
  Future<Either<Failure, void>> saveUserSetting(UserSettingDto value);
  Future<Either<Failure, void>> saveUserSoundSetting({required bool value});
  Future<Either<Failure, void>> saveUserMusicSetting({required bool value});
}
