part of '../page/quiz_page.dart';

class _UserLevel extends StatelessWidget {
  final UserInstanceEntity userInstance;
  final double height;

  const _UserLevel({
    required this.userInstance,
    required this.height,
  });

  static const double _spaceBetween = 5.0;
  static const double _fontSizeRatio = 0.6;
  static const double _marginHeightRatio = 0.05;
  static const double _starAssetSizeRatio = 0.4;

  @override
  Widget build(BuildContext context) => Container(
        height: height * (height - _marginHeightRatio),
        child: Row(
          children: [
            _buildLevelText(context),
            SizedBox(width: _spaceBetween * 2),
            _buildPoints(),
          ],
        ),
      );

  Widget _buildLevelText(BuildContext context) => Text(
        '${context.translate(SKeys.character_presentation_level)}: ${userInstance.level}',
        textAlign: TextAlign.center,
        style: TextStyles.outlinedWhite1.copyWith(fontSize: height * _fontSizeRatio),
      );

  Widget _buildPoints() => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildStartAsset(),
          SizedBox(width: _spaceBetween),
          Text(
            '${userInstance.points}',
            style: TextStyles.outlinedWhite1.copyWith(
              fontSize: height * _fontSizeRatio,
            ),
          ),
        ],
      );

  Widget _buildStartAsset() => Container(
        height: height * _starAssetSizeRatio,
        width: height * _starAssetSizeRatio,
        child: SvgPicture.asset(AppImages.svgAppPoint, fit: BoxFit.fill),
      );
}
