import 'package:freezed_annotation/freezed_annotation.dart';

import 'asset_dto.dart';
import 'hero_description_dto.dart';
import 'user_artefact_dto.dart';

part 'hero_dto.freezed.dart';
part 'hero_dto.g.dart';

@freezed
class HeroDto with _$HeroDto {
  const factory HeroDto({
    required int id,
    required int health,
    required List<UserArtefactDto> items,
    required AssetDto asset,
    required HeroDescriptionDto description,
  }) = _HeroDto;

  const HeroDto._();

  factory HeroDto.fromJson(Map<String, dynamic> json) => _$HeroDtoFromJson(json);
}
