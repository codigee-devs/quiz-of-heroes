import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/base_features/base/cubit/base_cubit.dart';

part 'artefact_info_cubit.freezed.dart';
part 'artefact_info_state.dart';

@Injectable()
class ArtefactInfoCubit extends BaseCubit<ArtefactInfoState> {
  ArtefactInfoCubit() : super(ArtefactInfoState.initial());

  @override
  Future<void> init() async => emit(ArtefactInfoState.initial());

  Future<void> didTapBackButton() async => emit(ArtefactInfoState.onTapBackButton());

  Future<void> didTapCancelButton() async => emit(ArtefactInfoState.onTapExitButton());
}
