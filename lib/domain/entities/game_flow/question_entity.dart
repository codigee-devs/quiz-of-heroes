import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/utils.dart';
import '../../../data/dto/question_dto.dart';
import 'answer_entity.dart';

part 'question_entity.freezed.dart';

@freezed
class QuestionEntity with _$QuestionEntity {
  const factory QuestionEntity({
    required int id,
    required int correctAnswerId,
    required QuestionCategory category,
    required String description,
    required List<AnswerEntity> answers,
  }) = _QuestionDto;

  factory QuestionEntity.fromDto(QuestionDto dto) => QuestionEntity(
        id: dto.id,
        correctAnswerId: dto.correctAnswerId,
        category: dto.category,
        description: translateDescription(dto.description),
        answers: dto.answers.map((dto) => AnswerEntity.fromDto(dto)).toList(),
      );
}
