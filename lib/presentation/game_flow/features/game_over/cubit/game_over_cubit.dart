import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/base_features/base/cubit/base_cubit.dart';
import '../../../../../domain/entities/game_flow/user_instance_entity.dart';
import '../../../../../domain/use_case/ranking/create_rank_instance_usecase.dart';

part 'game_over_cubit.freezed.dart';
part 'game_over_state.dart';

@Injectable()
class GameOverCubit extends BaseCubit<GameOverState> {
  final CreateRankInstanceUseCase _createRankInstanceUseCase;
  GameOverCubit(this._createRankInstanceUseCase) : super(GameOverState.initial());

  @override
  Future<void> init() async => GameOverState.initial();

  Future<void> confirmGameOver({required UserInstanceEntity instance}) async => _createRankInstanceUseCase(instance);
}
