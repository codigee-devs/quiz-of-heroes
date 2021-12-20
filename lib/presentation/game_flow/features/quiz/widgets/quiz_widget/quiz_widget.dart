import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../core/presentation/styles/app_button_style.dart';
import '../../../../../../core/presentation/styles/styles.dart';
import '../../../../../../core/presentation/values/values.dart';
import '../../../../../../core/presentation/widgets/app_widgets.dart';
import '../../../../../../core/presentation/widgets/buttons/app_base_button.dart';
import '../../../../../../domain/entities/game_flow/answer_entity.dart';
import '../../../../../../domain/entities/game_flow/question_entity.dart';
import '../../cubit/quiz_cubit.dart';

part 'answers_buttons.dart';
part 'question_text.dart';

///
/// [widgetLoadedCallback] - calls when all animations have been built, for example after that you can run time counter
/// [questionAnimationCompleteCallback] - calls when the whole question is visible
/// [updateButtonsCallback] - callback for cubit to control which button is activated
///

class QuizWidget extends StatelessWidget {
  final QuestionEntity question;
  final double height;
  final double width;
  final Function? widgetLoadedCallback;
  final Function? questionAnimationCompleteCallback;
  final Function(int)? updateButtonsCallback;
  const QuizWidget({
    required this.question,
    this.height = AppDimensions.quizWidgetBaseHeight,
    this.width = AppDimensions.quizWidgetBaseWidth,
    this.questionAnimationCompleteCallback,
    this.widgetLoadedCallback,
    this.updateButtonsCallback,
  });

  @override
  Widget build(BuildContext context) => _Body(
        question: question,
        height: height,
        width: width,
        widgetLoadedCallback: widgetLoadedCallback ?? () {},
        questionAnimationCompleteCallback: questionAnimationCompleteCallback ?? () {},
        updateButtonsCallback: updateButtonsCallback ?? (_) {},
      );
}

class _Body extends StatelessWidget {
  final QuestionEntity question;
  final double height;
  final double width;
  final Function widgetLoadedCallback;
  final Function questionAnimationCompleteCallback;
  final Function(int) updateButtonsCallback;
  const _Body({
    required this.question,
    required this.height,
    required this.width,
    required this.widgetLoadedCallback,
    required this.questionAnimationCompleteCallback,
    required this.updateButtonsCallback,
  });

  static const double _childsHeightRatio = 0.48;

  @override
  Widget build(BuildContext context) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: AppColors.quizBackground,
          border: Border.all(
            color: AppColors.quizBorder,
            width: AppDimensions.quizWidgetBorderSize,
          ),
          borderRadius: BorderRadius.circular(AppDimensions.quizWidgetCornerRadius),
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.quizInnerBorder,
              width: AppDimensions.quizWidgetBorderSize,
            ),
            borderRadius: BorderRadius.circular(AppDimensions.quizWidgetCornerRadius),
          ),
          child: Column(
            children: [
              _BuildQuestionTextWidget(
                height: height * _childsHeightRatio,
                question: question,
                onComplete: questionAnimationCompleteCallback,
              ),
              _BuildAnswersButtons(
                answers: question.answers,
                height: height * _childsHeightRatio,
                width: width,
                onComplete: widgetLoadedCallback,
                updateButtonsCallback: updateButtonsCallback,
              ),
            ],
          ),
        ),
      );
}
