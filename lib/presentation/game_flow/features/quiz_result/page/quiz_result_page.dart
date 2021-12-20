import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/base_features/base/page/base_page.dart';
import '../../../../../core/injection/injection.dart';
import '../../../../../core/language/localization.dart';
import '../../../../../core/presentation/styles/styles.dart';
import '../../../../../core/presentation/values/values.dart';
import '../../../../../core/presentation/widgets/app_widgets.dart';
import '../../../../../core/presentation/widgets/asset_builder_widget.dart';
import '../../../../../core/presentation/widgets/buttons/app_base_button.dart';
import '../../../../../domain/entities/artefacts/artefact_entity.dart';
import '../../../../game_flow/cubit/game_flow_cubit.dart';
import '../cubit/quiz_result_cubit.dart';
import '../widgets/result_game_window_appbar.dart';

part '../widgets/result_drawn_artefact.dart';
part '../widgets/result_lifes_subpage.dart';
part '../widgets/result_points_artefacts_subpage.dart';

class QuizResultPage extends BasePage {
  final QuizResult result;
  final int points;
  final String correctAnswer;
  final bool isDiamondActionActive;
  const QuizResultPage({
    required this.result,
    required this.points,
    required this.correctAnswer,
    this.isDiamondActionActive = false,
  });

  @override
  final double horizontalPadding = 0;

  @override
  Widget buildChildWidget(BuildContext context) => BlocProvider(
        create: (_) => getIt<QuizResultCubit>()
          ..init(
            result: result,
            points: points,
            isDiamondActionActive: isDiamondActionActive,
          ),
        child: _Body(
          result: result,
          points: points,
          correctAnswer: correctAnswer,
          isDiamondActionActive: isDiamondActionActive,
        ),
      );
}

class _Body extends StatefulWidget {
  final QuizResult result;
  final int points;
  final String correctAnswer;
  final bool isDiamondActionActive;
  const _Body({
    required this.result,
    required this.points,
    required this.correctAnswer,
    required this.isDiamondActionActive,
  });
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late PageController _controller;

  static const Curve _animationCurve = Curves.easeInCubic;

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  void _animateToNextPage() =>
      _controller.nextPage(duration: AppDurations.pageControllerAnimation, curve: _animationCurve);

  Future<bool> _onWillPop() async {
    _controller.previousPage(duration: AppDurations.pageControllerAnimation, curve: _animationCurve);
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) => AppScaffold(
        body: WillPopScope(
          onWillPop: _onWillPop,
          child: PageView(
            controller: _controller,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: [
              _QuizResultLifesSubpage(
                result: widget.result,
                isDiamondActionActive: widget.isDiamondActionActive,
                buttonCallback: _didTapNextButton,
                correctAnswer: widget.correctAnswer,
                menuButtonCallback: () => _didTapMenuButton(context),
              ),
              _QuizResultPointsArtefactsSubpage(
                result: widget.result,
                buttonCallback: () => _didTapNextLevelButton(context),
                menuButtonCallback: () => _didTapMenuButton(context),
                points: widget.points,
              ),
            ],
          ),
        ),
      );

  void _didTapNextButton() => _animateToNextPage();
  void _didTapNextLevelButton(BuildContext context) => context.read<GameFlowCubit>().goToTheLevel();

  void _didTapMenuButton(BuildContext context) => context.read<GameFlowCubit>().didBackToMenu();
}
