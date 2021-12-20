import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/utils.dart';
import '../../../data/dto/answer_dto.dart';

part 'answer_entity.freezed.dart';

@freezed
class AnswerEntity with _$AnswerEntity {
  const factory AnswerEntity({
    required int id,
    required String description,
  }) = _AnswerEntity;

  factory AnswerEntity.fromDto(AnswerDto dto) => AnswerEntity(
        id: dto.id,
        description: translateDescription(dto.description),
      );
}
