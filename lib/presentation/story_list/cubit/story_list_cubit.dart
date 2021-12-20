import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/base_features/base/cubit/base_cubit.dart';
import '../../../domain/entities/history/story_description_entity.dart';
import '../../../domain/use_case/gainedStory/get_gained_story_usecase.dart';
import '../../../domain/use_case/history/get_hero_history_usecase.dart';

part 'story_list_cubit.freezed.dart';
part 'story_list_state.dart';

@Injectable()
class StoryListCubit extends BaseCubit<StoryListState> {
  final GetGainedStoryUseCase _getGainedStoryUseCase;
  final GetHeroHistoryUsecase _getHeroHistoryUsecase;

  StoryListCubit(this._getGainedStoryUseCase, this._getHeroHistoryUsecase) : super(StoryListState.initial());

  @override
  Future<void> init() async {
    final result = await _getGainedStoryUseCase();
    result.fold(
      (l) => emit(StoryListState.failure()),
      (r) => emit(StoryListState.displayButtons(howMuchRevel: r)),
    );
  }

  Future<void> didTapBackButton() async {
    emit(StoryListState.onTapBackButton());
    emit(StoryListState.clearState());
  }

  Future<void> didTapCancelButton() async => emit(StoryListState.onTapExitButton());

  Future<void> didTapDisplayStory(int id, int number) async {
    final result = await _getHeroHistoryUsecase(id, number);
    result.fold(
      (l) => emit(StoryListState.failure()),
      (r) => emit(StoryListState.displayStory(story: r)),
    );
  }
}
