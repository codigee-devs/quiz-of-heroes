import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/base_features/base/page/base_page.dart';
import '../../../../../core/config/config.dart';
import '../../../../../core/injection/injection.dart';
import '../../../../../core/language/localization.dart';
import '../../../../../core/presentation/styles/styles.dart';
import '../../../../../core/presentation/values/values.dart';
import '../../../../../core/presentation/widgets/app_widgets.dart';
import '../../../../../core/presentation/widgets/asset_builder_widget.dart';
import '../../../../../core/presentation/widgets/buttons/app_base_button.dart';
import '../../../../../domain/entities/artefacts/artefact_entity.dart';
import '../../../../../domain/entities/artefacts/user_artefact_entity.dart';
import '../../../../../domain/entities/game_flow/question_entity.dart';
import '../../../../../domain/entities/game_flow/user_instance_entity.dart';
import '../../../cubit/game_flow_cubit.dart';
import '../cubit/quiz_cubit.dart';
import '../widgets/quiz_artefacts.dart';
import '../widgets/quiz_widget/quiz_widget.dart';

part '../widgets/bomb_animation_widget.dart';
part '../widgets/confirm_button.dart';
part '../widgets/quiz_time_indicator.dart';
part '../widgets/user_level.dart';
part '../widgets/user_lifes.dart';

class QuizPage extends BasePage {
  final QuestionEntity question;
  final UserInstanceEntity userInstance;
  final List<UserArtefactEntity> artefacts;
  const QuizPage({
    required this.question,
    required this.userInstance,
    required this.artefacts,
  });

  @override
  final double verticalPadding = 0;
  final double horizontalPadding = 0;

  @override
  Widget buildChildWidget(BuildContext context) => AppScaffold(
        body: BlocProvider(
          create: (_) => getIt<QuizCubit>()..init(),
          child: _Body(
            question: question,
            userInstance: userInstance,
            artefacts: artefacts,
          ),
        ),
      );
}

class _Body extends StatefulWidget {
  final QuestionEntity question;
  final UserInstanceEntity userInstance;
  final List<UserArtefactEntity> artefacts;
  const _Body({
    required this.question,
    required this.userInstance,
    required this.artefacts,
  });

  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> with TickerProviderStateMixin {
  late AnimationController _timeController;
  int _selectedButtonId = -1;
  bool _isDiamondActionActive = false;

  static const _horizontalPadding = 30.0;
  static const _timeIndicatorHeightRatio = 0.03;
  static const _userInformationsHeightRatio = 0.12;
  static const _quizWidgetHeightRatio = 0.65;
  static const _artefactsHeightRatio = 0.20;
  static const _userLifesSizeRatio = 0.5;
  static const _confirmButtonWidthToHeightRatio = 2.5;

  @override
  void initState() {
    super.initState();
    _timeController = AnimationController(duration: AppDurations.quizBaseQuestionTime, vsync: this);
  }

  int get _pointsByTime {
    if (_timeController.lastElapsedDuration!.inMilliseconds == 0) {
      _timeController.forward();
    }
    return AppDurations.quizBaseQuestionTime.inMilliseconds - _timeController.lastElapsedDuration!.inMilliseconds;
  }

  String get _correctAnswer => widget.question.answers[widget.question.correctAnswerId].description;

  bool _isAnswerCorrect(int id) => id == widget.question.correctAnswerId;

  QuizResult _getResult({required int id}) => _isAnswerCorrect(id) ? QuizResult.correct : QuizResult.wrong;

  void _onCompleteLoadedWidget(BuildContext context) {
    _didChangeArtefactsClickability(context, areClickable: true);
    _didStartTimer(context);
  }

  void _onArtefactUse(BuildContext context, {required ArtefactEntity artefact}) {
    _didChangeArtefactsClickability(context, areClickable: true);
    _didRunArtefactAction(context, artefact: artefact);
  }

  @override
  Widget build(BuildContext context) => BlocListener<QuizCubit, QuizState>(
        listener: (context, state) => state.maybeWhen(
          godQuestion: () => _isDiamondActionActive = true,
          orElse: () => null,
        ),
        child: Stack(
          children: [
            _buildContent(context),
            BombAnimationWidget(
              onAnimationCompleteCallback: () => _didShowNewQuestion(context),
            ),
          ],
        ),
      );

  Widget _buildContent(BuildContext context) => LayoutBuilder(
        builder: (context, ui) => Column(
          children: [
            _buildTimeIndicator(context, height: ui.maxHeight * _timeIndicatorHeightRatio),
            Container(
              padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
              child: Column(
                children: [
                  _buildUserInformations(context,
                      height: ui.maxHeight * _userInformationsHeightRatio, width: ui.maxWidth),
                  _buildQuizWidget(context, height: ui.maxHeight * _quizWidgetHeightRatio),
                  _buildArtefactsConfirm(
                    context,
                    height: ui.maxHeight * _artefactsHeightRatio,
                    width: ui.maxWidth - (2 * _horizontalPadding),
                  ),
                ],
              ),
            )
          ],
        ),
      );

  Widget _buildTimeIndicator(BuildContext context, {required double height}) => QuizTimeIndicator(
        height: height,
        onCompleteCallback: () => _didQuizTimeout(context),
        controler: _timeController,
        startTimerCallback: () => _didStartTimer(context),
      );

  Widget _buildUserInformations(BuildContext context, {required double height, required double width}) => Container(
        height: height,
        width: width,
        padding: EdgeInsets.symmetric(vertical: AppDimensions.smallEdgeInsets4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _UserLifes(
              userInstance: widget.userInstance,
              height: height,
              width: width * _userLifesSizeRatio,
            ),
            _UserLevel(
              userInstance: widget.userInstance,
              height: height,
            ),
          ],
        ),
      );

  Widget _buildQuizWidget(BuildContext context, {required double height}) => QuizWidget(
        question: widget.question,
        height: height,
        widgetLoadedCallback: () => _onCompleteLoadedWidget(context),
        questionAnimationCompleteCallback: () => _didShowAnswers(context),
        updateButtonsCallback: (id) => _didUpdateButtons(context, id),
      );

  Widget _buildArtefactsConfirm(BuildContext context, {required double height, required double width}) {
    final childSize = width / 11;
    return Container(
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildArtefacts(context, height: childSize),
          SizedBox(width: AppDimensions.baseSpace),
          _buildConfirmButton(context, height: childSize),
        ],
      ),
    );
  }

  Widget _buildArtefacts(BuildContext context, {required double height}) => QuizArtefacts(
        userArtefacts: widget.artefacts,
        onPressedCallback: (artefact) => _onArtefactUse(context, artefact: artefact),
        size: height,
      );

  Widget _buildConfirmButton(BuildContext context, {required double height}) => _ConfirmButton(
        height: height,
        width: height * _confirmButtonWidthToHeightRatio,
        confirmCallback: (id) => _didConfirmAnswer(context, id),
      );

  Future<void> _didShowAnswers(BuildContext context) async => context.read<QuizCubit>().didShowAnswers();

  Future<void> _didStartTimer(BuildContext context) => context.read<QuizCubit>().didStartTimer();
  Future<void> _didChangeArtefactsClickability(BuildContext context, {required bool areClickable}) =>
      context.read<QuizCubit>().changeArtefactsClickability(areClickable: areClickable);

  Future<void> _didShowNewQuestion(BuildContext context) => context.read<GameFlowCubit>().didShowNewQuestion(
        instance: widget.userInstance,
      );

  Future<void> _didUpdateButtons(BuildContext context, int id) async {
    _selectedButtonId = id;
    context.read<QuizCubit>().didUpdateButtons(id: id);
  }

  Future<void> _didQuizTimeout(BuildContext context) => context.read<GameFlowCubit>().didQuizTimeout(
        correctAnswer: _correctAnswer,
        isDiamondActionActive: _isDiamondActionActive,
      );

  Future<void> _didConfirmAnswer(BuildContext context, int id) async => context.read<GameFlowCubit>().didConfirmAnswer(
        result: _getResult(id: id),
        isDiamondActionActive: _isDiamondActionActive,
        newPoints: _isAnswerCorrect(id) ? _pointsByTime : 0,
        correctAnswer: _correctAnswer,
      );

  Future<void> _didRunArtefactAction(
    BuildContext context, {
    required ArtefactEntity artefact,
  }) =>
      context.read<QuizCubit>().didTapArtefactButton(
            artefact: artefact,
            activeButton: _selectedButtonId,
            question: widget.question,
          );
}
