import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/utils.dart';
import '../../../data/dto/artefact_description_dto.dart';

part 'artefact_description_entity.freezed.dart';

@freezed
class ArtefactDescriptionEntity with _$ArtefactDescriptionEntity {
  const factory ArtefactDescriptionEntity({
    required String artefactName,
    required String actionDescription,
    required String artefactDescription,
  }) = _ArtefactDescriptionEntity;

  factory ArtefactDescriptionEntity.fromDto(ArtefactDescriptionDto dto) => ArtefactDescriptionEntity(
      artefactName: translateDescription(dto.artefactName),
      actionDescription: translateDescription(dto.actionDescription),
      artefactDescription: translateDescription(dto.artefactDescription));
}
