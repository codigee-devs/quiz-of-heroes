import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/config/config.dart';
import '../../../../../core/presentation/styles/styles.dart';
import '../../../../../core/presentation/values/values.dart';
import '../../../../../core/presentation/widgets/base_actions/base_actions.dart';
import '../../../../../domain/entities/artefacts/artefact_entity.dart';
import '../../../../../domain/entities/artefacts/user_artefact_entity.dart';
import '../cubit/quiz_cubit.dart';

part 'artefact_widget.dart';

class QuizArtefacts extends HookWidget {
  final List<UserArtefactEntity> userArtefacts;
  final Function(ArtefactEntity) onPressedCallback;
  final double size;

  QuizArtefacts({
    required this.userArtefacts,
    required this.onPressedCallback,
    required this.size,
  });

  static const int _deactiveArtefactId = -1;
  final List<int> _usedArtefactsId = [];

  @override
  Widget build(BuildContext context) {
    final artefacts = List<UserArtefactEntity>.from(userArtefacts);
    final activeArtefactId = useState(_deactiveArtefactId);

    return BlocBuilder<QuizCubit, QuizState>(
      buildWhen: (p, c) => c is UpdateArtefactsButtonsState,
      builder: (context, state) => state.maybeWhen(
        orElse: () => Container(),
        clickableArtefacts: (areClickable) => Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: _buildArtefactsWidgets(
              artefacts: artefacts,
              areClickable: areClickable,
              activeArtefactId: activeArtefactId.value,
              onArtefactPressed: (artefact) {
                _usedArtefactsId.add(artefact.id);
                activeArtefactId.value = artefact.id;
                onPressedCallback(artefact);
              },
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildArtefactsWidgets({
    required List<UserArtefactEntity> artefacts,
    required bool areClickable,
    required int activeArtefactId,
    required Function(ArtefactEntity) onArtefactPressed,
  }) {
    artefacts..sort((a, b) => b.count.compareTo(a.count));
    return _mapArtefactsToWidgets(artefacts, areClickable, activeArtefactId, onArtefactPressed);
  }

  List<Widget> _mapArtefactsToWidgets(List<UserArtefactEntity> artefacts, bool areClickable, int activeArtefactId,
      Function(ArtefactEntity) onArtefactPressed) {
    List<Widget> widgets = artefacts
        .map(
          (artefact) => ArtefactWidget(
            size: size,
            userArtefact: artefact,
            onPressedCallback: onArtefactPressed,
            isClickable: (activeArtefactId != artefact.artefact.id) && !_usedArtefactsId.contains(artefact.artefact.id),
            isActive: (artefact.artefact.id == activeArtefactId) || _usedArtefactsId.contains(artefact.artefact.id),
          ),
        )
        .toList();

    if (widgets.length > AppConfig.artefactSlotsCount) {
      widgets.sublist(AppConfig.artefactSlotsCount);
    } else if (widgets.length < AppConfig.artefactSlotsCount) {
      final emptyWidgetsCount = AppConfig.artefactSlotsCount - widgets.length;
      widgets = List.from(widgets)..addAll(_generateEmptyWidgets(emptyWidgetsCount));
    }

    return widgets.toList();
  }

  List<Widget> _generateEmptyWidgets(int count) => List<Widget>.generate(count, (_) => _buildEmptyWidget());

  Widget _buildEmptyWidget() => Container(
        height: size,
        width: size,
        padding: EdgeInsets.all(AppDimensions.quizWidgetArtefactInnerPadding),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.pngQuizArtefactButtonDeactive),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      );
}
