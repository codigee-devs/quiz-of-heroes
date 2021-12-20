import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../data/failures/failure.dart';
import '../../../../../data/repositories/config_settings_repository/config_setting_repository.dart';
import '../../../../../domain/use_case/core/usecase.dart';

@Injectable()
class GetSoundStateUsecase implements UseCase<bool, void> {
  final UserSettingRepository _userSettingRepository;
  GetSoundStateUsecase(this._userSettingRepository);

  @override
  Future<Either<Failure, bool>> call([void noParams]) => _userSettingRepository.getUserSoundSetting();
}
