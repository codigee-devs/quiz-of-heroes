part of '../page/quiz_page.dart';

class _ConfirmButton extends StatefulWidget {
  final double height;
  final double width;
  final Function(int) confirmCallback;
  const _ConfirmButton({
    required this.height,
    required this.width,
    required this.confirmCallback,
  });

  static const int _textMaxLines = 1;
  static const double _fontMinSize = 8.0;
  static const double _fontMaxSize = 32.0;

  @override
  __ConfirmButtonState createState() => __ConfirmButtonState();
}

class __ConfirmButtonState extends State<_ConfirmButton> {
  late int _activeButtonId;

  static const int _deactiveButtonId = -1;

  @override
  void initState() {
    super.initState();
    _activeButtonId = _deactiveButtonId;
  }

  @override
  Widget build(BuildContext context) => BlocConsumer<QuizCubit, QuizState>(
      listener: (context, state) => state.maybeWhen(
            updateButtons: (id) => _activeButtonId = id,
            orElse: () => null,
          ),
      buildWhen: (p, c) => c is UpdateButtonsState,
      builder: (context, state) => _buildButton());

  Widget _buildButton() => Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: AppDimensions.quizWidgetArtefactInnerPadding),
        child: AppBaseButton.quizConfirmButton(
          width: widget.width,
          height: widget.height,
          onPressed: () => widget.confirmCallback(_activeButtonId),
          isDeactive: (_activeButtonId == _deactiveButtonId),
          child: AutoSizeText(
            '${context.translate(SKeys.quiz_confirm)}',
            maxLines: _ConfirmButton._textMaxLines,
            minFontSize: _ConfirmButton._fontMinSize,
            maxFontSize: _ConfirmButton._fontMaxSize,
            style: TextStyles.quizConfirm,
          ),
        ),
      );
}
