import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/dto/artefact_dto.dart';
import '../core/asset_entity.dart';
import 'artefact_description_entity.dart';

part 'artefact_entity.freezed.dart';

@freezed
class ArtefactEntity with _$ArtefactEntity {
  const factory ArtefactEntity({
    required int id,
    required String name,
    required List<ArtefactAction> actions,
    required AssetEntity asset,
    required ArtefactDescriptionEntity description,
  }) = _ArtefactEntity;

  factory ArtefactEntity.fromDto(ArtefactDto dto) => ArtefactEntity(
        id: dto.id,
        name: dto.name,
        actions: dto.actions,
        asset: AssetEntity.fromDto(dto.asset),
        description: ArtefactDescriptionEntity.fromDto(dto.description),
      );
}
