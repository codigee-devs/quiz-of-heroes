import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'asset_dto.freezed.dart';
part 'asset_dto.g.dart';

enum AssetType {
  @JsonValue('image/png')
  png,
  @JsonValue('image/svg')
  svg,
}

@freezed
 class AssetDto with _$AssetDto {
  const factory AssetDto({
    required String path,
    required AssetType type,
  }) = _AssetDto;

  factory AssetDto.fromJson(Map<String, dynamic> json) => _$AssetDtoFromJson(json);
}
