part of 'values.dart';

///
/// File to store all the duration in the app
/// [1 second = 1000 milliseconds]
///

abstract class AppDurations {
  // animation durations
  static const Duration artefactActionPauseTimeDuration = Duration(milliseconds: 15000);
  static const Duration creditsPageScrollAnimationDuration = Duration(milliseconds: 15000);
  static const Duration instant = Duration(microseconds: 1);
  static const Duration pageControllerAnimation = Duration(milliseconds: 500);
  static const Duration quizAnswersAnimtaionDuration = Duration(milliseconds: 1000);
  static const Duration quizBaseQuestionTime = Duration(milliseconds: 30000);
  static const Duration quizBombArtefactBackgroundAnimationDuration = Duration(milliseconds: 500);
  static const Duration quizQuestionAnimationDuration = Duration(milliseconds: 2000);
  static const Duration splashscreenLoadingDuration = Duration(milliseconds: 2000);
  static const Duration storyPartScrollAnimationDuration = Duration(milliseconds: 500);
}
