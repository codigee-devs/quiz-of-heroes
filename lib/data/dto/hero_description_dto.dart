import 'package:freezed_annotation/freezed_annotation.dart';

part 'hero_description_dto.freezed.dart';
part 'hero_description_dto.g.dart';

@freezed
class HeroDescriptionDto with _$HeroDescriptionDto {
  const factory HeroDescriptionDto({
    @JsonKey(name: 'visible-name') required Map<String, String> name,
  }) = _HeroDescriptionDto;

  const HeroDescriptionDto._();

  factory HeroDescriptionDto.fromJson(Map<String, dynamic> json) => _$HeroDescriptionDtoFromJson(json);
}
