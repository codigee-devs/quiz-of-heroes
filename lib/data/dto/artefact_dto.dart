import 'package:freezed_annotation/freezed_annotation.dart';

import 'artefact_description_dto.dart';
import 'asset_dto.dart';

part 'artefact_dto.freezed.dart';
part 'artefact_dto.g.dart';

enum ArtefactAction {
  @JsonValue(0)
  destroyQuestion,
  @JsonValue(1)
  hideOneAnswer,
  @JsonValue(2)
  pauseTime,
  @JsonValue(3)
  godQuestion,
  @JsonValue(4)
  hideTwoAnswers,
  @JsonValue(5)
  selectHalfAnswers,
  @JsonValue(6)
  lessOpacityTwoWrongAnswers,
  @JsonValue(7)
  addOneLife,
}

@freezed
class ArtefactDto with _$ArtefactDto {
  const factory ArtefactDto({
    required int id,
    required String name,
    @JsonKey(name: 'actions_ids') required List<ArtefactAction> actions,
    required AssetDto asset,
    required ArtefactDescriptionDto description,
  }) = _ArtefactDto;

  const ArtefactDto._();

  factory ArtefactDto.fromJson(Map<String, dynamic> json) => _$ArtefactDtoFromJson(json);
}
