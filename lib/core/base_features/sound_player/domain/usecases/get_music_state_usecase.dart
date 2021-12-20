import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../data/failures/failure.dart';
import '../../../../../data/repositories/config_settings_repository/config_setting_repository.dart';
import '../../../../../domain/use_case/core/usecase.dart';

@Injectable()
class GetMusicStateUsecase implements UseCase<bool, void> {
  final UserSettingRepository _userSettingRepository;
  GetMusicStateUsecase(this._userSettingRepository);

  @override
  Future<Either<Failure, bool>> call([void noParams]) => _userSettingRepository.getUserMusicSetting();
}
