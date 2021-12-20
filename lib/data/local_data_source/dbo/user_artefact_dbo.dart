import 'package:hive/hive.dart';

import '../../dto/user_artefact_dto.dart';
import '../database/database_client/database_client_type_id.dart';

part 'user_artefact_dbo.g.dart';

@HiveType(typeId: DatabaseClientTypeId.userArtefact)
class UserArtefactDbo extends HiveObject {
  @HiveField(0)
  final int artefactId;
  @HiveField(1)
  final int count;

  UserArtefactDbo({
    required this.artefactId,
    required this.count,
  });

  factory UserArtefactDbo.fromDto(UserArtefactDto dto) => UserArtefactDbo(artefactId: dto.artefactId, count: dto.count);

  UserArtefactDto toDto() => UserArtefactDto(artefactId: artefactId, count: count);
}
