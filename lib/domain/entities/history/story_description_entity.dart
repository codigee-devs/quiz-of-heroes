import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/utils.dart';
import '../../../data/dto/story_description_dto.dart';

part 'story_description_entity.freezed.dart';

@freezed
class StoryDescriptionEntity with _$StoryDescriptionEntity {
  const factory StoryDescriptionEntity({
    required int id,
    required String description,
  }) = _StoryDescriptionEntity;

  factory StoryDescriptionEntity.fromDto(StoryDescriptionDto dto) => StoryDescriptionEntity(
        id: dto.id,
        description: translateDescription(dto.description),
      );
}
