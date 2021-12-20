import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/base_features/base/cubit/base_cubit.dart';
import '../../../domain/entities/artefacts/artefact_entity.dart';
import '../../../domain/use_case/artefacts/get_artefacts_usecase.dart';

part 'artefacts_list_cubit.freezed.dart';
part 'artefacts_list_state.dart';

@Injectable()
class ArtefactsListCubit extends BaseCubit<ArtefactsListState> {
  final GetArtefactsUseCase _getArtefactsUsecase;
  ArtefactsListCubit(this._getArtefactsUsecase) : super(ArtefactsListState.initial());

  @override
  Future<void> init() async {
    final artefacts = await _getArtefactsUsecase();
    artefacts.fold(
      (failue) => emit(ArtefactsListState.failure()),
      (artefacts) => emit(ArtefactsListState.getArtefacts(artefacts: artefacts)),
    );
  }

  Future<void> didTapSelectArtefact(ArtefactEntity artefact) async {
    emit(ArtefactsListState.chooseArtefact(artefacts: artefact));
    emit(ArtefactsListState.clearState());
  }

  Future<void> didTapBackButton() async {
    emit(ArtefactsListState.onTapBackButton());
    emit(ArtefactsListState.clearState());
  }

  Future<void> didTapCancelButton() async => emit(ArtefactsListState.onTapExitButton());
}
