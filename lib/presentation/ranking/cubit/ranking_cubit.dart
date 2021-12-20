import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/base_features/base/cubit/base_cubit.dart';
import '../../../domain/entities/game_flow/user_instance_entity.dart';
import '../../../domain/use_case/core/get_user_instance_usecase.dart';
import '../../../domain/use_case/ranking/get_entire_rank_usecase.dart';

part 'ranking_cubit.freezed.dart';
part 'ranking_state.dart';

@Injectable()
class RankingCubit extends BaseCubit<RankingState> {
  final GetUserInstanceUsecase _getUserInstanceUsecase;
  final GetEntireRankUseCase _getEntireRanksUsecase;

  RankingCubit(
    this._getUserInstanceUsecase,
    this._getEntireRanksUsecase,
  ) : super(RankingState.initial());

  @override
  Future<void> init() async {
    (await _getEntireRanksUsecase()).fold((failure) => emit(RankingState.failure()),
        (entities) => emit(RankingState.showRankingList(entities: entities)));
    (await _getUserInstanceUsecase()).fold(
      (failure) => emit(RankingState.failure()),
      (entity) => emit(RankingState.showCurrentScore(
        entity: entity,
      )),
    );
  }

  Future<void> didTapBackButton() async {
    emit(RankingState.backToPreviousPageState());
    emit(RankingState.clearState());
  }

  Future<void> didTapCancelButton() async => emit(RankingState.exitToMenuState());
}
