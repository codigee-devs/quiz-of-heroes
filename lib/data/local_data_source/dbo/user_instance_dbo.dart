import 'package:hive/hive.dart';

import '../../dto/user_instance_dto.dart';
import '../database/database_client/database_client_type_id.dart';

part 'user_instance_dbo.g.dart';

@HiveType(typeId: DatabaseClientTypeId.userInstance)
class UserInstanceDbo extends HiveObject {
  @HiveField(0)
  final int level;
  @HiveField(1)
  final int points;
  @HiveField(2)
  final int lifes;
  @HiveField(3)
  final int heroId;
  @HiveField(4)
  final String name;
  @HiveField(5)
  final List<int> askedQuestions;

  UserInstanceDbo({
    required this.level,
    required this.points,
    required this.lifes,
    required this.heroId,
    required this.name,
    required this.askedQuestions,
  });

  factory UserInstanceDbo.fromDto(UserInstanceDto dto) => UserInstanceDbo(
        level: dto.level,
        points: dto.points,
        lifes: dto.lifes,
        heroId: dto.heroId,
        name: dto.name,
        askedQuestions: dto.askedQuestions,
      );

  UserInstanceDto toDto() => UserInstanceDto(
        level: level,
        points: points,
        lifes: lifes,
        heroId: heroId,
        name: name,
        askedQuestions: askedQuestions,
      );
}
