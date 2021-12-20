part of '../page/quiz_result_page.dart';

class ResultDrawnArtefact extends StatelessWidget {
  const ResultDrawnArtefact();

  static const double _artefactNameFontSizeRatio = 0.22;
  static const double _artefactDescriptionFontSizeRatio = 0.17;
  static const double _rightMarginRatio = 0.2;
  static const int _artefactIconFlex = 9;
  static const int _spaceFlex = 1;
  static const int _artefactDescriptionFlex = 20;
  static const int _textMaxLines = 4;
  static const double _minFontSize = 12.0;
  static const double _maxFontSize = 16.0;

  @override
  Widget build(BuildContext context) => BlocBuilder<QuizResultCubit, QuizResultState>(
        buildWhen: (p, c) => c is UpdateDrawnArtefact,
        builder: (context, state) => state.maybeWhen(
          newArtefact: (entity) => _buildContent(artefact: entity),
          orElse: () => Container(),
        ),
      );

  Widget _buildContent({required ArtefactEntity artefact}) => Row(
        children: [
          Expanded(
            flex: _artefactIconFlex,
            child: _buildArtefactIcon(artefact),
          ),
          _buildSpace(),
          Expanded(
            flex: _artefactDescriptionFlex,
            child: _buildArtefactDescription(artefact),
          ),
        ],
      );

  Widget _buildSpace() => Expanded(flex: _spaceFlex, child: Container());

  Widget _buildArtefactIcon(ArtefactEntity artefact) => AssetBuilderWidget(
        asset: artefact.asset,
        fit: BoxFit.contain,
      );

  Widget _buildArtefactDescription(ArtefactEntity artefact) => LayoutBuilder(
        builder: (context, ui) => Container(
          margin: EdgeInsets.only(right: ui.maxWidth * _rightMarginRatio),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                artefact.description.artefactName,
                style: TextStyles.resultBold.copyWith(
                  fontSize: ui.maxHeight * _artefactNameFontSizeRatio,
                ),
              ),
              Expanded(
                child: buildBaseAutoSizeText(
                  text: artefact.description.actionDescription,
                  maxLines: _textMaxLines,
                  minFontSize: _minFontSize,
                  maxFontSize: _maxFontSize,
                  textAlign: TextAlign.left,
                  style: TextStyles.resultNormal.copyWith(
                    fontSize: ui.maxHeight * _artefactDescriptionFontSizeRatio,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
