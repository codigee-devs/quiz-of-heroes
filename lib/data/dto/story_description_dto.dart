import 'package:freezed_annotation/freezed_annotation.dart';

part 'story_description_dto.freezed.dart';
part 'story_description_dto.g.dart';

@freezed
class StoryDescriptionDto with _$StoryDescriptionDto {
  const factory StoryDescriptionDto({
    required int id,
    required Map<String, String> description,
  }) = _StoryDescriptionDto;

  factory StoryDescriptionDto.fromJson(Map<String, dynamic> json) => _$StoryDescriptionDtoFromJson(json);
}
