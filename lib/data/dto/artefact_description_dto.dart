import 'package:freezed_annotation/freezed_annotation.dart';

part 'artefact_description_dto.freezed.dart';
part 'artefact_description_dto.g.dart';

@freezed
 class ArtefactDescriptionDto with _$ArtefactDescriptionDto {
  factory ArtefactDescriptionDto({
    @JsonKey(name: 'visible-name') required Map<String, String> artefactName,
    @JsonKey(name: 'action-description') required Map<String, String> actionDescription,
    @JsonKey(name: 'artefact-description') required Map<String, String> artefactDescription,
  }) = _ArtefactDescriptionDto;

  factory ArtefactDescriptionDto.fromJson(Map<String, dynamic> json) => _$ArtefactDescriptionDtoFromJson(json);

}
