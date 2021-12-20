part of 'story_list_cubit.dart';

@freezed
abstract class StoryListState with _$StoryListState {
  const factory StoryListState.initial() = _StoryListStateInitial;

  const factory StoryListState.failure() = _StoryListStateFailure;

  const factory StoryListState.onTapBackButton() = _StoryListStateOnTapBackButton;

  const factory StoryListState.clearState() = _StoryListStateClearState;

  @Implements(StoryListStateDisplayButtons)
  const factory StoryListState.displayButtons({required List<int> howMuchRevel}) = _StoryListStateDisplayButtons;

  const factory StoryListState.displayStory({required StoryDescriptionEntity story}) = _StoryListStateDisplayStory;

  const factory StoryListState.onTapExitButton() = _StoryListStateOnTapExitButton;
}

abstract class StoryListStateDisplayButtons {}
