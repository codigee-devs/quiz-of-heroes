import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../data/dto/asset_dto.dart';
import '../../../domain/entities/core/asset_entity.dart';
import '../values/values.dart';

class AssetBuilderWidget extends StatelessWidget {
  final AssetEntity asset;
  final double height;
  final double width;
  final BoxFit fit;
  const AssetBuilderWidget({
    required this.asset,
    this.height = AppDimensions.baseAssetBuilderSize,
    this.width = AppDimensions.baseAssetBuilderSize,
    this.fit = BoxFit.contain,
  });
  @override
  Widget build(BuildContext context) {
    switch (asset.type) {
      case AssetType.png:
        return _buildPngAsset(context);
      case AssetType.svg:
        return _buildSvgAsset(context);
      default:
        return Container();
    }
  }

  Widget _buildSvgAsset(BuildContext context) => Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        child: SvgPicture.asset(
          asset.path,
          fit: fit,
          height: height,
          width: width,
        ),
      );

  Widget _buildPngAsset(BuildContext context) => Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        child: Image.asset(asset.path, fit: fit),
      );
}
