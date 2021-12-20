import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_setting_dto.freezed.dart';
part 'user_setting_dto.g.dart';

@freezed
abstract class UserSettingDto with _$UserSettingDto {
  factory UserSettingDto({
    required bool isMusicEnabled,
    required bool isSoundEffectEnabled,
    required bool isCountingEnabled,
    required bool isStoryEnabled,
  }) = _UserSettingDto;

  factory UserSettingDto.fromJson(Map<String, dynamic> json) => _$UserSettingDtoFromJson(json);
}
