import 'package:freezed_annotation/freezed_annotation.dart';

part 'answer_dto.freezed.dart';
part 'answer_dto.g.dart';

@freezed
class AnswerDto with _$AnswerDto {
  const factory AnswerDto({
    required int id,
    required Map<String, String> description,
  }) = _AnswerDto;

  factory AnswerDto.fromJson(Map<String, dynamic> json) => _$AnswerDtoFromJson(json);
}
