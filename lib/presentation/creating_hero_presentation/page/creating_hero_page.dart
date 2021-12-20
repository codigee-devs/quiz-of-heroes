import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/base_features/base/page/base_page.dart';
import '../../../core/injection/injection.dart';
import '../../../core/language/localization.dart';
import '../../../core/presentation/styles/styles.dart';
import '../../../core/presentation/values/values.dart';
import '../../../core/presentation/widgets/app_widgets.dart';
import '../../../core/presentation/widgets/buttons/app_base_button.dart';
import '../../../domain/entities/hero/hero_entity.dart';
import '../cubit/creating_hero_cubit.dart';

class CreatingHeroPage extends BasePage {
  final HeroEntity hero;

  const CreatingHeroPage({required this.hero});
  @override
  Widget buildChildWidget(BuildContext context) => BlocProvider(
        create: (_) => getIt<CreatingHeroCubit>()..init(),
        child: _Body(hero, displaySnackBar),
      );
}

class _Body extends StatefulWidget {
  final void Function(BuildContext, String) displaySnackBar;
  final HeroEntity hero;

  const _Body(this.hero, this.displaySnackBar);

  @override
  State<StatefulWidget> createState() => _BodyState(hero: hero, displaySnackBar: displaySnackBar);
}

class _BodyState extends State<_Body> {
  final RegExp _buildNormalMarksRegex = RegExp("[a-zA-Z0-9 _]");
  final _textController = TextEditingController();
  final HeroEntity hero;
  final void Function(BuildContext, String) displaySnackBar;

  static const double _baseBarScale = 0.05;
  static const double _appbarHeightRatio = 0.15;

  double _getAppbarSize(BuildContext context) => MediaQuery.of(context).size.height * _appbarHeightRatio;
  double _getMarginVerticalContinueButton(BuildContext context) => MediaQuery.of(context).size.height * 0.2;

  _BodyState({required this.hero, required this.displaySnackBar});
  @override
  Widget build(BuildContext context) => Scaffold(
          body: BlocListener<CreatingHeroCubit, CreatingHeroState>(
        listener: (context, state) => state.maybeWhen(
          savedInstance: (story) async => context.navigator.push(
            StoryPartPageRoute(
              storyText: story,
              onConfirmButtonCallback: () => context.navigator.pushAndPopUntil(
                GameFlowPageRoute(),
                predicate: (_) => false,
              ),
            ),
          ),
          backButton: () async => await context.navigator.pop(),
          textFieldEmpty: () =>
              displaySnackBar(context, '${context.translate(SKeys.creating_hero_snack_bar_no_input)}'),
          textTooManySigns: () =>
              displaySnackBar(context, '${context.translate(SKeys.creating_hero_snack_bar_too_much_signs)}'),
          orElse: () => null,
        ),
        child: _buildContent(context),
      ));

  Widget _buildContent(BuildContext context) => Stack(
        children: [
          Scaffold(
            body: BaseGameWindow(
              appBar: BaseGameWindowsAppBar(
                padding: EdgeInsets.zero,
                height: _getAppbarSize(context),
                color: AppColors.barAppBack,
                leftChild: AppBaseButton.baseBackButton(
                  onPressed: () => _didTapBackButton(context),
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: AppDimensions.largeEdgeInsets12),
                  child: Text(
                    hero.description.name,
                    style: TextStyles.subtitleShadowWhite
                        .copyWith(fontSize: MediaQuery.of(context).size.height * _baseBarScale),
                  ),
                ),
              ),
              child: ListView(
                primary: false,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  SizedBox(
                    height: AppDimensions.baseBigSpace,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SvgPicture.asset(hero.asset.path),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${context.translate(SKeys.creating_hero_name)}', style: TextStyles.heroName),
                          Container(
                            width: AppDimensions.creatingHeroTextFieldWidth,
                            height: AppDimensions.creatingHeroTextFieldHeight,
                            margin: EdgeInsets.only(top: AppDimensions.baseSpace),
                            child: TextField(
                              controller: _textController,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  _buildNormalMarksRegex,
                                ),
                              ],
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.black),
                                    borderRadius: BorderRadius.zero,
                                  ),
                                  fillColor: AppColors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: AppDimensions.xxLargeEdgeInsets24,
                        vertical: _getMarginVerticalContinueButton(context)),
                    alignment: Alignment.bottomRight,
                    child: AppBaseButton.creatingHeroContinueButton(
                      child: Text('${context.translate(SKeys.creating_hero_continue)}', style: TextStyles.button),
                      onPressed: () => _didTapContinueButton(context, _textController.text, hero),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );

  void _didTapContinueButton(BuildContext context, String name, HeroEntity heroId) =>
      context.read<CreatingHeroCubit>().didTapContinueButton(name, heroId);

  void _didTapBackButton(BuildContext context) => context.read<CreatingHeroCubit>().didTapBackButton();
}
