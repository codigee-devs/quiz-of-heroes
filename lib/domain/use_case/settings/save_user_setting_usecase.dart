import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/dto/user_setting_dto.dart';
import '../../../data/failures/failure.dart';
import '../../../data/repositories/config_settings_repository/config_setting_repository.dart';
import '../../entities/settings/user_setting_entity.dart';
import '../core/usecase.dart';

@Injectable()
class SaveUserSettingUsecase implements UseCase<void, UserSettingEntity> {
  final UserSettingRepository _userSettingRepository;

  SaveUserSettingUsecase(this._userSettingRepository);

  @override
  Future<Either<Failure, void>> call([UserSettingEntity? setting]) async {
    if (setting != null) {
      return Right(_userSettingRepository.saveUserSetting(
        UserSettingDto(
          isMusicEnabled: setting.isMusicEnabled,
          isSoundEffectEnabled: setting.isSoundEffectEnabled,
          isCountingEnabled: setting.isCountingEnabled,
          isStoryEnabled: setting.isStoryEnabled,
        ),
      ));
    }
    return Left(Failure());
  }
}
