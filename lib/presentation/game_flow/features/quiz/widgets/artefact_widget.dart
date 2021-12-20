part of 'quiz_artefacts.dart';

class ArtefactWidget extends StatefulWidget {
  final double size;
  final bool isClickable;
  final bool isActive;
  final UserArtefactEntity userArtefact;
  final Function(ArtefactEntity) onPressedCallback;

  const ArtefactWidget({
    required this.size,
    required this.onPressedCallback,
    required this.isClickable,
    required this.isActive,
    required this.userArtefact,
  });

  @override
  ArtefactWidgetState createState() => ArtefactWidgetState();
}

class ArtefactWidgetState extends State<ArtefactWidget> {
  static const int _diamondArtefactId = 3;
  static const double _innerPadding = AppDimensions.quizWidgetArtefactInnerPadding;
  static const double _countValueWidgetPosition = -1.0;
  static const double _countValueWidgetSizeRatio = 0.4;
  static const double _artefactIconSizeRatio = 0.2;
  static const double _countValueWidgetMaxFontSize = 20.0;
  static const double _countValueWidgetMinFontSize = 6.0;
  static const double __countValueWidgetFontSizeRatio = 0.5;
  late double _countValueWidgetSize;
  late double _artefactIconSize;
  late int _artefactUsesCount;

  @override
  void initState() {
    super.initState();
    _countValueWidgetSize = widget.size * _countValueWidgetSizeRatio;
    _artefactIconSize = widget.size * _artefactIconSizeRatio;
    _artefactUsesCount = widget.userArtefact.count;
  }

  bool get _isCountMoreThanZero => _artefactUsesCount > 0;
  bool get _isArtefactActive => widget.userArtefact.count > _artefactUsesCount;

  void _onPointerUp() {
    if (_isCountMoreThanZero && widget.isClickable) {
      BaseActions.onClickButton(() => widget.onPressedCallback(widget.userArtefact.artefact));
      _artefactUsesCount--;
    }
  }

  ImageProvider _getDecorationImage({bool isDiamondArtefact = false}) {
    if (isDiamondArtefact) {
      precacheImage(AssetImage(AppImages.pngQuizDiamondArtefactButtonActive), context);
      return widget.isActive
          ? AssetImage(AppImages.pngQuizDiamondArtefactButtonActive)
          : AssetImage(AppImages.pngQuizArtefactButton);
    } else {
      precacheImage(AssetImage(AppImages.pngQuizArtefactButtonActive), context);
      return widget.isActive
          ? AssetImage(AppImages.pngQuizArtefactButtonActive)
          : AssetImage(AppImages.pngQuizArtefactButton);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isArtefactActive) {
      return _buildArtefactWidget();
    } else {
      return !_isCountMoreThanZero ? _buildEmptyWidget() : _buildArtefactWidget();
    }
  }

  Widget _buildEmptyWidget() => Container(
        height: widget.size,
        width: widget.size,
        padding: EdgeInsets.all(_innerPadding),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.pngQuizArtefactButtonDeactive),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      );

  Widget _buildArtefactWidget() => Container(
        width: widget.size,
        height: widget.size,
        child: Listener(
          onPointerUp: (_) => _onPointerUp(),
          child: Stack(
            children: [
              Positioned(
                left: _innerPadding,
                right: _innerPadding,
                top: _innerPadding,
                bottom: _innerPadding,
                child: _buildWidgetBackground(
                  isDiamondArtefact: (widget.userArtefact.artefact.id == _diamondArtefactId),
                ),
              ),
              Positioned.fill(
                child: Container(
                  height: _artefactIconSize,
                  width: _artefactIconSize,
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    widget.userArtefact.artefact.asset.path,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
                bottom: _countValueWidgetPosition,
                right: _countValueWidgetPosition,
                child: _buildWidgetCountValue(),
              )
            ],
          ),
        ),
      );

  Widget _buildWidgetBackground({required bool isDiamondArtefact}) => Container(
        height: widget.size,
        width: widget.size,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: _getDecorationImage(isDiamondArtefact: isDiamondArtefact),
            fit: BoxFit.fitWidth,
          ),
        ),
      );

  Widget _buildWidgetCountValue() => _artefactUsesCount > 1
      ? Container(
          height: _countValueWidgetSize,
          width: _countValueWidgetSize,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.pngQuizArtefactCount),
              fit: BoxFit.contain,
            ),
          ),
          child: AutoSizeText(
            '$_artefactUsesCount',
            textAlign: TextAlign.center,
            minFontSize: _countValueWidgetMinFontSize,
            maxFontSize: _countValueWidgetMaxFontSize,
            maxLines: 1,
            style: TextStyles.quizArtefactCountWidget
                .copyWith(fontSize: _countValueWidgetSize * __countValueWidgetFontSizeRatio),
          ),
        )
      : Container();
}
