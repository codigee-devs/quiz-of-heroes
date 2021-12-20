import 'package:freezed_annotation/freezed_annotation.dart';

import 'answer_dto.dart';

part 'question_dto.freezed.dart';
part 'question_dto.g.dart';

@freezed
 class QuestionDto with _$QuestionDto {
  const factory QuestionDto({
    required int id,
    @JsonKey(name: 'correct_answer_id') required int correctAnswerId,
    required QuestionCategory category,
    required Map<String, String> description,
    required List<AnswerDto> answers,
  }) = _QuestionDto;

  factory QuestionDto.fromJson(Map<String, dynamic> json) => _$QuestionDtoFromJson(json);
}

enum QuestionCategory {
  @JsonValue('history')
  history,
  @JsonValue('planet')
  planet,
  @JsonValue('random')
  random,
  @JsonValue('music')
  music,
  @JsonValue('tv_series')
  television,
}
