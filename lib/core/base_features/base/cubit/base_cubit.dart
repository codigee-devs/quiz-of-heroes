import 'package:flutter_bloc/flutter_bloc.dart';

part 'base_states.dart';

/// Base cubit is for extends all of cubits class in project, if we want to implement
/// common features, helpers etc.. it should included here.
abstract class BaseCubit<State> extends Cubit<State> {
  BaseCubit(State state) : super(state);

  /// BasePage shouldn't show content until init function has done.
  Future<void> init();
}
