import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/base_features/base/cubit/base_cubit.dart';
import '../../../core/base_features/base/page/base_page.dart';
import '../../../core/injection/injection.dart';
import '../../../core/language/localization.dart';
import '../../../core/presentation/styles/styles.dart';
import '../../../core/presentation/values/values.dart';
import '../../../core/presentation/widgets/app_widgets.dart';
import '../../../domain/entities/hero/hero_entity.dart';
import '../cubit/choosing_hero_cubit.dart';
import '../widget/heroes_display.dart';

class ChoosingHeroPage extends BasePage {
  @override
  Widget buildChildWidget(BuildContext context) => BlocProvider(
        create: (_) => getIt<ChoosingHeroCubit>()..init(),
        child: _Body(),
      );
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) => AppScaffold(
        body: BaseGameWindow(
          child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.only(
                    top: AppDimensions.xxLargeEdgeInsets24,
                  ),
                  alignment: Alignment.topCenter,
                  child: Text(
                    '${context.translate(SKeys.heroChoosingInstruction)}',
                    style: TextStyles.baseButtonStyle,
                  )),
              Expanded(
                child: BlocConsumer<ChoosingHeroCubit, ChoosingHeroState>(
                  listener: (context, state) => state.maybeWhen(
                    chooseHero: (hero) => context.navigator.push(CreatingHeroPageRoute(hero: hero)),
                    orElse: () => null,
                  ),
                  buildWhen: (p, c) => c is LayoutBuilderState,
                  builder: (context, state) => state.maybeWhen(
                    getHeroes: (listHeroes) => HeroesDisplay(
                      heroes: listHeroes,
                      onClick: (hero) => _didTapChooseHero(context, hero),
                    ),
                    orElse: () => Container(),
                  ),
                ),
              )
            ],
          ),
        ),
      );

  void _didTapChooseHero(BuildContext context, HeroEntity hero) =>
      context.read<ChoosingHeroCubit>().didTapChooseHero(hero);
}
