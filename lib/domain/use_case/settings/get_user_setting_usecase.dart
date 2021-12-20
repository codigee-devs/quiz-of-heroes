import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/failures/failure.dart';
import '../../../data/repositories/config_settings_repository/config_setting_repository.dart';
import '../../entities/settings/user_setting_entity.dart';
import '../core/usecase.dart';

@Injectable()
class GetUserSettingUsecase implements UseCase<UserSettingEntity, void> {
  final UserSettingRepository _userSettingRepository;

  GetUserSettingUsecase(this._userSettingRepository);

  @override
  Future<Either<Failure, UserSettingEntity>> call([void noParams]) async =>
      (await _userSettingRepository.getUserSetting()).fold(
        (failure) => Left(failure),
        (r) => Right(UserSettingEntity.fromDto(r)),
      );
}
