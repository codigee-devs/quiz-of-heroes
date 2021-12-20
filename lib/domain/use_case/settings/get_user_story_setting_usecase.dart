import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/failures/failure.dart';
import '../../../data/repositories/config_settings_repository/config_setting_repository.dart';
import '../core/usecase.dart';

@Injectable()
class GetUserStorySettingUsecase implements UseCase<bool, void> {
  final UserSettingRepository _userSettingRepository;

  GetUserStorySettingUsecase(this._userSettingRepository);

  @override
  Future<Either<Failure, bool>> call([void noParams]) async =>
      (await _userSettingRepository.getUserStorySetting()).fold(
        (failure) => Left(failure),
        (r) => Right(r),
      );
}
