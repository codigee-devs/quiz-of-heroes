import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/base_features/base/page/base_page.dart';
import '../../../../../core/injection/injection.dart';
import '../../../../../core/language/localization.dart';
import '../../../../../core/presentation/styles/styles.dart';
import '../../../../../core/presentation/values/values.dart';
import '../../../../../core/presentation/widgets/app_widgets.dart';
import '../../../../../core/presentation/widgets/asset_builder_widget.dart';
import '../../../../../core/presentation/widgets/buttons/app_base_button.dart';
import '../../../../../domain/entities/game_flow/user_instance_entity.dart';
import '../../../../ranking/page/ranking_page.dart';
import '../../../cubit/game_flow_cubit.dart';
import '../../quiz_result/widgets/result_game_window_appbar.dart';
import '../cubit/game_over_cubit.dart';

part '../widgets/game_over_lifes_subpage.dart';
part '../widgets/game_over_score_subpage.dart';
part '../widgets/game_over_subpage.dart';

class GameOverPage extends BasePage {
  final UserInstanceEntity instance;
  final String correctAnswer;
  const GameOverPage({
    required this.instance,
    this.correctAnswer = '',
  });

  @override
  final double horizontalPadding = 0;

  @override
  Widget buildChildWidget(BuildContext context) => BlocProvider(
        create: (_) => getIt<GameOverCubit>()..init(),
        child: _Body(
          instance: instance,
          correctAnswer: correctAnswer,
        ),
      );
}

class _Body extends StatefulWidget {
  final UserInstanceEntity instance;
  final String correctAnswer;
  const _Body({
    required this.instance,
    required this.correctAnswer,
  });
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late PageController _controller;

  static const Curve _animationCurve = Curves.easeInCubic;

  @override
  void initState() {
    final _skipFirstSubpageIfCorrectAnswerNotExist = (widget.correctAnswer.isNotEmpty) ? 0 : 1;
    _controller = PageController(initialPage: _skipFirstSubpageIfCorrectAnswerNotExist);
    super.initState();
  }

  void _animateToNextPage() => _controller.nextPage(duration: AppDurations.instant, curve: _animationCurve);
  void _animateToPreviousPage() => _controller.previousPage(duration: AppDurations.instant, curve: _animationCurve);

  @override
  Widget build(BuildContext context) => AppScaffold(
        body: PageView(
          controller: _controller,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: [
            _GameOverLifesSubpage(
              buttonCallback: _animateToNextPage,
              correctAnswer: widget.correctAnswer,
            ),
            _GameOverSubpage(
              buttonCallback: () => _didConfirmGameOver(context),
            ),
            _GameOverScoreSubpage(
              buttonCallback: _animateToNextPage,
              instance: widget.instance,
            ),
            RankingPage(
              onTapBackArrow: _animateToPreviousPage,
            ),
          ],
        ),
      );

  Future<void> _didConfirmGameOver(BuildContext context) async {
    context.read<GameOverCubit>().confirmGameOver(instance: widget.instance);
    _animateToNextPage();
  }
}
