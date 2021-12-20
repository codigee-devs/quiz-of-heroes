import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/base_features/base/cubit/base_cubit.dart';
import '../../../../../core/base_features/base/page/base_page.dart';
import '../../../../../core/injection/injection.dart';
import '../../../../../core/language/localization.dart';
import '../../../../../core/presentation/styles/styles.dart';
import '../../../../../core/presentation/values/values.dart';
import '../../../../../core/presentation/widgets/app_widgets.dart';
import '../../../../../core/presentation/widgets/asset_builder_widget.dart';
import '../../../../../core/presentation/widgets/buttons/app_base_button.dart';
import '../../../../../domain/entities/artefacts/user_artefact_entity.dart';
import '../../../../../domain/entities/core/asset_entity.dart';
import '../../../../../domain/entities/game_flow/question_entity.dart';
import '../../../../../domain/entities/game_flow/user_instance_entity.dart';
import '../../../cubit/game_flow_cubit.dart';
import '../cubit/character_presentation_cubit.dart';

class CharacterPresentationPage extends BasePage {
  final UserInstanceEntity instance;

  const CharacterPresentationPage({required this.instance});

  @override
  final double horizontalPadding = 0;
  final double verticalPadding = 0;

  @override
  Widget buildChildWidget(BuildContext context) => BlocProvider(
        create: (_) => getIt<CharacterPresentationCubit>()..init(instance: instance),
        child: _Body(
          instance: instance,
        ),
      );
}

class _Body extends StatefulWidget {
  final UserInstanceEntity instance;
  const _Body({required this.instance});
  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  late UserInstanceEntity _instance;
  late List<UserArtefactEntity> _artefacts;
  late QuestionEntity _question;

  static const double _verticalMarginRatio = 0.03;
  static const double _horizontalMarginRatio = 0.05;
  static const double _heroAssetSizeRatio = 0.8;
  static const double _levelTextSizeRatio = 0.2;

  @override
  Widget build(BuildContext context) => AppScaffold(
        body: BlocBuilder<CharacterPresentationCubit, CharacterPresentationState>(
          buildWhen: (p, c) => c is LayoutBuilderState,
          builder: (context, state) => state.maybeWhen(
            loaded: (instance, artefacts, question) {
              _instance = instance;
              _artefacts = artefacts;
              _question = question;
              return _buildContent(context);
            },
            orElse: () => Container(),
          ),
        ),
      );

  Widget _buildContent(BuildContext context) => Container(
        margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * _verticalMarginRatio,
          horizontal: MediaQuery.of(context).size.width * _horizontalMarginRatio,
        ),
        child: LayoutBuilder(
          builder: (context, ui) => Column(
            children: [
              _BuildMenuButton(
                onPressed: () => _didTapMenuButton(context),
              ),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, ui) => Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _BuildCharacterWidget(
                        size: ui.maxHeight * _heroAssetSizeRatio,
                        asset: _instance.hero.asset,
                      ),
                      _BuildLevelTextWidget(
                        size: ui.maxHeight * _levelTextSizeRatio,
                        level: _instance.level,
                      ),
                    ],
                  ),
                ),
              ),
              _BuildStartButton(
                onPressedCallback: () => _didTapStartButton(context),
              ),
            ],
          ),
        ),
      );

  void _didTapStartButton(BuildContext context) => context.read<GameFlowCubit>().didTapStartButton(
        instance: _instance,
        artefacts: _artefacts,
        question: _question,
      );

  void _didTapMenuButton(BuildContext context) => context.read<GameFlowCubit>().didBackToMenu();
}

class _BuildLevelTextWidget extends StatelessWidget {
  final int level;
  final double size;
  const _BuildLevelTextWidget({
    required this.level,
    required this.size,
  });

  static const double _textSizeRatio = 0.5;
  @override
  Widget build(BuildContext context) => Text(
        '${context.translate(SKeys.character_presentation_level)} $level',
        style: TextStyles.subtitleShadowWhite.copyWith(fontSize: size * _textSizeRatio),
      );
}

class _BuildCharacterWidget extends StatelessWidget {
  final AssetEntity asset;
  final double size;
  const _BuildCharacterWidget({
    required this.asset,
    required this.size,
  });
  static const double _assetSizeRatio = 0.8;
  @override
  Widget build(BuildContext context) => AssetBuilderWidget(
        asset: asset,
        height: size * _assetSizeRatio,
        width: size * _assetSizeRatio,
        fit: BoxFit.contain,
      );
}

class _BuildMenuButton extends StatelessWidget {
  final Function onPressed;
  const _BuildMenuButton({required this.onPressed});
  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppMenuButton(onPressed: onPressed, size: AppDimensions.menuButtonHeight),
        ],
      );
}

class _BuildStartButton extends StatelessWidget {
  final Function onPressedCallback;
  const _BuildStartButton({required this.onPressedCallback});

  @override
  Widget build(BuildContext context) => AppBaseButton.characterPresentation(
        onPressed: onPressedCallback,
        child: Text(
          '${context.translate(SKeys.character_presentation_start)}',
          style: TextStyles.baseButtonStyle,
        ),
      );
}
