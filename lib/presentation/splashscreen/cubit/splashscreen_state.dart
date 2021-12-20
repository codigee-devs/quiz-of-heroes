part of 'splashscreen_cubit.dart';

@freezed
abstract class SplashscreenState with _$SplashscreenState {
  const factory SplashscreenState.initial() = _Initial;

  const factory SplashscreenState.loading(double value) = _Loading;
}
