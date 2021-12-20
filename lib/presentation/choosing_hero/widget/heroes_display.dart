import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/presentation/values/values.dart';
import '../../../domain/entities/hero/hero_entity.dart';

class HeroesDisplay extends StatelessWidget {
  final List<HeroEntity> heroes;
  final void Function(HeroEntity) onClick;

  const HeroesDisplay({required this.heroes, required this.onClick});

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
            child: _buildHero(context, hero: heroes[0]),
          ),
          Expanded(
            child: _buildHero(context, hero: heroes[1]),
          ),
        ],
      );

  Widget _buildHero(BuildContext context, {required HeroEntity hero}) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => onClick(hero),
            child: SvgPicture.asset(hero.asset.path),
          ),
          Container(
            margin: const EdgeInsets.only(
              bottom: AppDimensions.baseEdgeInsets8,
              top: AppDimensions.baseEdgeInsets8,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: AppDimensions.baseAppSmallAssetSize,
                  height: AppDimensions.baseAppSmallAssetSize,
                  child: SvgPicture.asset(AppImages.svgAppHeart),
                ),
                SizedBox(width: AppDimensions.smallEdgeInsets4),
                Container(
                  margin: const EdgeInsets.only(top: AppDimensions.smallEdgeInsets4),
                  child: Text('${hero.health}', style: Theme.of(context).textTheme.headline6),
                ),
                SizedBox(width: AppDimensions.largeEdgeInsets12),
                Container(
                  width: AppDimensions.baseAppSmallAssetSize,
                  height: AppDimensions.baseAppSmallAssetSize,
                  child: SvgPicture.asset(AppImages.svgAppPotion),
                ),
                SizedBox(width: AppDimensions.smallEdgeInsets4),
                Container(
                  margin: const EdgeInsets.only(top: AppDimensions.smallEdgeInsets4),
                  child: Text(
                    '${hero.itemsCount}',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ],
            ),
          ),
          Text(
            hero.description.name,
            style: Theme.of(context).textTheme.headline5,
          ),
        ],
      );
}
