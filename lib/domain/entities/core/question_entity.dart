import 'package:freezed_annotation/freezed_annotation.dart';

part 'question_entity.freezed.dart';

@freezed
class QuestionEntity with _$QuestionEntity {
  const factory QuestionEntity({
    required String question,
    required List<String> answers,
    required int correctAnswerIndex,
  }) = _QuestionEntity;
}
