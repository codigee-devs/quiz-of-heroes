import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/dto/hero_dto.dart';
import '../core/asset_entity.dart';
import 'hero_description_entity.dart';

part 'hero_entity.freezed.dart';

@freezed
class HeroEntity with _$HeroEntity {
  const factory HeroEntity({
    required int id,
    required HeroDescriptionEntity description,
    required AssetEntity asset,
    required int health,
    required int itemsCount,
  }) = _HeroEntity;

  factory HeroEntity.fromDto(HeroDto dto) => HeroEntity(
        id: dto.id,
        health: dto.health,
        description: HeroDescriptionEntity.fromDto(dto.description),
        asset: AssetEntity.fromDto(dto.asset),
        itemsCount: dto.items.length,
      );
}
