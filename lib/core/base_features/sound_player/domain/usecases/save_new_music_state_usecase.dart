import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../data/failures/failure.dart';
import '../../../../../data/repositories/config_settings_repository/config_setting_repository.dart';
import '../../../../../domain/use_case/core/usecase.dart';

@Injectable()
class SaveNewMusicStateUsecase implements UseCase<void, bool> {
  final UserSettingRepository _repository;
  SaveNewMusicStateUsecase(this._repository);

  @override
  Future<Either<Failure, void>> call(bool setting) => _repository.saveUserMusicSetting(value: setting);
}
