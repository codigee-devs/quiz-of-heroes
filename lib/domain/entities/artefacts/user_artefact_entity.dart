import 'package:freezed_annotation/freezed_annotation.dart';

import 'artefact_entity.dart';

part 'user_artefact_entity.freezed.dart';

@freezed
class UserArtefactEntity with _$UserArtefactEntity {
  const factory UserArtefactEntity({
    required ArtefactEntity artefact,
    required int count,
  }) = _UserArtefactEntity;

}
