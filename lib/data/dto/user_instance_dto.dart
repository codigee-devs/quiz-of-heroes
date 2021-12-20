import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_instance_dto.freezed.dart';
part 'user_instance_dto.g.dart';

@freezed
class UserInstanceDto with _$UserInstanceDto {
  factory UserInstanceDto({
    required int level,
    required int points,
    required int lifes,
    @JsonKey(name: 'hero_id') required int heroId,
    required String name,
    @JsonKey(name: 'questions') required List<int> askedQuestions,
  }) = _UserInstanceDto;

  factory UserInstanceDto.fromJson(Map<String, dynamic> json) => _$UserInstanceDtoFromJson(json);

}
