import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/language/localization.dart';
import '../../../../../core/presentation/styles/styles.dart';
import '../../../../../core/presentation/values/values.dart';
import '../../../../../core/presentation/widgets/app_widgets.dart';
import '../../../cubit/game_flow_cubit.dart';

class ResultGameWindowAppbar extends StatelessWidget {
  final QuizResult result;
  final Function menuButtonCallback;
  const ResultGameWindowAppbar({
    required this.result,
    required this.menuButtonCallback,
  });

  static const double _appbarHeightRatio = 0.15;
  static const double _appbarTextSizeRatio = 0.4;
  static const double _menuButtonMarginRatio = 0.15;
  static const double _menuButtonSizeRatio = 0.5;

  bool get _isResultCorrect => result == QuizResult.correct;

  double _getAppbarSize(BuildContext context) => MediaQuery.of(context).size.height * _appbarHeightRatio;

  @override
  Widget build(BuildContext context) => BaseGameWindowsAppBar(
        color: _isResultCorrect ? AppColors.quizResultCorrect : AppColors.quizResultWrong,
        height: _getAppbarSize(context),
        leftChild: _buildMenuButton(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              _isResultCorrect ? AppImages.svgQuizResultCorrect : AppImages.svgQuizResultWrong,
              height: _getAppbarSize(context) * _appbarTextSizeRatio,
            ),
            SizedBox(width: AppDimensions.baseAppBarSpacing),
            Text(
              _isResultCorrect
                  ? '${context.translate(SKeys.quiz_result_correct)}'
                  : '${context.translate(SKeys.quiz_result_wrong)}',
              style: TextStyles.subtitleShadowWhite.copyWith(
                fontSize: _getAppbarSize(context) * _appbarTextSizeRatio,
              ),
            ),
          ],
        ),
      );

  Widget _buildMenuButton(BuildContext context) => Container(
        margin: EdgeInsets.all(_getAppbarSize(context) * _menuButtonMarginRatio),
        alignment: Alignment.center,
        child: AppMenuButton(
          onPressed: menuButtonCallback,
          size: _getAppbarSize(context) * _menuButtonSizeRatio,
        ),
      );
}
