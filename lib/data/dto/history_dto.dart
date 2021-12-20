import 'package:freezed_annotation/freezed_annotation.dart';

import 'story_description_dto.dart';

part 'history_dto.freezed.dart';
part 'history_dto.g.dart';

@freezed
class HistoryDto with _$HistoryDto {
  const factory HistoryDto({
    required int id,
    required List<StoryDescriptionDto> story,
  }) = _HistoryDto;

  factory HistoryDto.fromJson(Map<String, dynamic> json) => _$HistoryDtoFromJson(json);
}
