import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../core/base_features/base/page/base_page.dart';
import '../../../core/language/localization.dart';
import '../../../core/presentation/styles/styles.dart';
import '../../../core/presentation/values/values.dart';
import '../../../core/presentation/widgets/app_widgets.dart';
import '../../../core/presentation/widgets/buttons/app_base_button.dart';

class CreditsPage extends BasePage {
  @override
  Widget buildChildWidget(BuildContext context) => _Body();
}

class _Body extends StatefulWidget {
  const _Body();

  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  late ScrollController _controller;

  static const double _appbarHeightRatio = 0.15;

  double _getAppbarSize(BuildContext context) => MediaQuery.of(context).size.height * _appbarHeightRatio;
  double _getTextHorizontalMargin(BuildContext context) => MediaQuery.of(context).size.width;
  double _getTextVerticalPadding(BuildContext context) => _getTextHorizontalMargin(context) / 2;

  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) => afterBuild());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _scrollJumpToEnd() => _controller.animateTo(
        _controller.position.maxScrollExtent,
        duration: AppDurations.creditsPageScrollAnimationDuration,
        curve: Curves.easeOut,
      );

  void afterBuild() {
    _scrollJumpToEnd();
  }

  @override
  Widget build(BuildContext context) => AppScaffold(
        body: BaseGameWindow(
          appBar: BaseGameWindowsAppBar(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: AppDimensions.largeEdgeInsets12),
              child: Text(
                '${context.translate(SKeys.credits_title)}',
                style: TextStyles.subtitleShadowWhite,
              ),
            ),
            padding: EdgeInsets.zero,
            height: _getAppbarSize(context),
            color: AppColors.barAppBack,
            leftChild: AppBaseButton.baseBackButton(
              onPressed: () => _didTapBackButton(context),
            ),
            rightChild: AppBaseButton.baseCancelButton(
              onPressed: () => _didTapCancelButton(context),
            ),
          ),
          child: _buildCredits(),
        ),
      );

  Widget _buildCredits() => FadingEdgeScrollView.fromSingleChildScrollView(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          controller: _controller,
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                  vertical: _getTextVerticalPadding(context),
                ),
                child: Text(
                  '${context.translate(SKeys.credits_quizofheroes)}',
                  style: TextStyles.creditsCodigee,
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text(
                      '${context.translate(SKeys.credits_codigee)}',
                      style: TextStyles.creditsHeadline,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '${context.translate(SKeys.credits_website)}',
                      style: TextStyles.creditsWebsite,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "\n ${context.translate(SKeys.credits_title)}",
                      style: TextStyles.creditsTitle,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '${context.translate(SKeys.credits)}',
                      style: TextStyles.introText,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}

Future<void> _didTapBackButton(BuildContext context) async => context.navigator.pop();

Future<void> _didTapCancelButton(BuildContext context) async => context.navigator.pushAndPopUntil(
      HomePageRoute(),
      predicate: (_) => false,
    );
