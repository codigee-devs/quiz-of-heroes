import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/utils.dart';
import '../../../data/dto/hero_description_dto.dart';

part 'hero_description_entity.freezed.dart';

@freezed
class HeroDescriptionEntity with _$HeroDescriptionEntity {
  const factory HeroDescriptionEntity({required String name}) = _HeroDescriptionEntity;

  factory HeroDescriptionEntity.fromDto(HeroDescriptionDto dto) => HeroDescriptionEntity(
        name: translateDescription(dto.name),
      );
}
