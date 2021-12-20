import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/dto/history_dto.dart';
import 'story_description_entity.dart';

part 'history_entity.freezed.dart';

@freezed
class HistoryEntity with _$HistoryEntity {
  const factory HistoryEntity({
    required int id,
    required List<StoryDescriptionEntity> story,
  }) = _HistoryEntity;

  factory HistoryEntity.fromDto(HistoryDto dto) => HistoryEntity(
        id: dto.id,
        story: dto.story.map((dto) => StoryDescriptionEntity.fromDto(dto)).toList(),
      );
}
