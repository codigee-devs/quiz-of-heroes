import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_artefact_dto.freezed.dart';
part 'user_artefact_dto.g.dart';



@freezed
class UserArtefactDto with _$UserArtefactDto {
  const factory UserArtefactDto({
   @JsonKey(name: 'artefact_id') required int artefactId,
   required int count,
  }) = _UserArtefactDto;

  factory UserArtefactDto.fromJson(Map<String, dynamic> json) => _$UserArtefactDtoFromJson(json);

}
