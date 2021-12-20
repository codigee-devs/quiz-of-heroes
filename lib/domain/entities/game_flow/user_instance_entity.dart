import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/dto/user_instance_dto.dart';
import '../hero/hero_entity.dart';

part 'user_instance_entity.freezed.dart';

@freezed
class UserInstanceEntity with _$UserInstanceEntity {
  const factory UserInstanceEntity({
    required int level,
    required int points,
    required int lifes,
    required HeroEntity hero,
    required String name,
    required List<int> askedQuestions,
  }) = _UserInstanceEntity;

  factory UserInstanceEntity.fromDto({required UserInstanceDto dto, required HeroEntity hero}) => UserInstanceEntity(
        level: dto.level,
        points: dto.points,
        lifes: dto.lifes,
        name: dto.name,
        askedQuestions: dto.askedQuestions,
        hero: hero,
      );
}
