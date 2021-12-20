part of '../page/quiz_page.dart';

class _UserLifes extends StatefulWidget {
  final UserInstanceEntity userInstance;
  final double height;
  final double width;

  const _UserLifes({
    required this.userInstance,
    required this.height,
    required this.width,
  });

  static const double _characterSizeRatio = 0.6;
  static const double _hearthSizeRatio = 0.50;
  static const double _spaceBetween = 3.0;

  @override
  __UserLifesState createState() => __UserLifesState();
}

class __UserLifesState extends State<_UserLifes> {
  late int _userLifes;

  @override
  void initState() {
    super.initState();
    _userLifes = widget.userInstance.lifes;
  }

  void _addLife(int count) {
    if (_userLifes < AppConfig.lifesMax) {
      setState(() => _userLifes += count);
    }
  }

  @override
  Widget build(BuildContext context) => BlocListener<QuizCubit, QuizState>(
        listenWhen: (p, c) => c is UpdateInstanceState,
        listener: (context, state) => state.maybeWhen(
          addLife: _addLife,
          orElse: () => null,
        ),
        child: Container(
          width: widget.width,
          height: widget.height,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildCharacter(),
              _buildSpace(),
              Expanded(
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, _) => _buildSpace(),
                  itemCount: _userLifes,
                  itemBuilder: (context, _) => _buildHearth(),
                ),
              )
            ],
          ),
        ),
      );

  Widget _buildSpace() => SizedBox(width: _UserLifes._spaceBetween);

  Widget _buildHearth() => Container(
        alignment: Alignment.center,
        height: widget.height * _UserLifes._hearthSizeRatio,
        child: SvgPicture.asset(
          AppImages.svgAppLife,
          height: widget.height * _UserLifes._hearthSizeRatio,
          fit: BoxFit.fill,
        ),
      );

  Widget _buildCharacter() => AssetBuilderWidget(
        asset: widget.userInstance.hero.asset,
        height: widget.height,
        width: widget.height * _UserLifes._characterSizeRatio,
        fit: BoxFit.fitHeight,
      );
}
