import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/dto/user_setting_dto.dart';

part 'user_setting_entity.freezed.dart';

@freezed
class UserSettingEntity with _$UserSettingEntity {
  const factory UserSettingEntity({
    required bool isMusicEnabled,
    required bool isSoundEffectEnabled,
    required bool isCountingEnabled,
    required bool isStoryEnabled,
  }) = _UserSettingEntity;

  factory UserSettingEntity.fromDto(UserSettingDto dto) => UserSettingEntity(
        isCountingEnabled: dto.isCountingEnabled,
        isMusicEnabled: dto.isMusicEnabled,
        isSoundEffectEnabled: dto.isSoundEffectEnabled,
        isStoryEnabled: dto.isStoryEnabled,
      );
}
