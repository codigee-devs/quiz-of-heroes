import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/dto/asset_dto.dart';

part 'asset_entity.freezed.dart';

@freezed
class AssetEntity with _$AssetEntity {
  const factory AssetEntity({
    required String path,
    required AssetType type,
  }) = _AssetEntity;

  factory AssetEntity.fromDto(AssetDto dto) => AssetEntity(path: dto.path, type: dto.type);
}
