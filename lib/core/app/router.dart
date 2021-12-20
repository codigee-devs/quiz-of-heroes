import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../presentation/artefact_info/page/artefact_info_page.dart';
import '../../presentation/artefacts_list/page/artefacts_list_page.dart';
import '../../presentation/choosing_hero/page/choosing_hero_page.dart';
import '../../presentation/creating_hero_presentation/page/creating_hero_page.dart';
import '../../presentation/credits/page/credits_page.dart';
import '../../presentation/game_flow/page/game_page.dart';
import '../../presentation/home_presentation/page/home_page.dart';
import '../../presentation/load_game/page/load_game_page.dart';
import '../../presentation/ranking/page/ranking_page.dart';
import '../../presentation/setting_game/page/setting_game_page.dart';
import '../../presentation/splashscreen/widgets/splashscreen.dart';
import '../../presentation/story_list/page/story_list_page.dart';
import '../../presentation/story_part/page/story_part_page.dart';
import '../base_features/base/page/base_page.dart';
import 'router.gr.dart';

export 'router.gr.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: Splashscreen, initial: true),
    MaterialRoute(page: HomePage),
    MaterialRoute(page: ArtefactInfoPage),
    MaterialRoute(page: ArtefactsListPage),
    MaterialRoute(page: ChoosingHeroPage),
    MaterialRoute(page: CreatingHeroPage),
    MaterialRoute(page: CreditsPage),
    MaterialRoute(page: GameFlowPage),
    MaterialRoute(page: StoryPartPage),
    MaterialRoute(page: LoadGamePage),
    MaterialRoute(page: RankingPage),
    MaterialRoute(page: SettingGamePage),
    MaterialRoute(page: StoryListPage),
  ],
)
class $CodigeeRouter {}

extension RouterExtension on BuildContext {
  static final CodigeeRouter _instance = CodigeeRouter();
  StackRouter get navigator => AutoRouter.of(this);
  CodigeeRouter get router => _instance;
}
