import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/presentation/styles/styles.dart';
import '../../../core/presentation/values/values.dart';
import '../../../core/presentation/widgets/buttons/app_base_button.dart';
import '../../../domain/entities/artefacts/artefact_entity.dart';

class ArtefactsDisplay extends StatelessWidget {
  final List<ArtefactEntity> artefacts;
  final void Function(BuildContext, ArtefactEntity) onClick;

  const ArtefactsDisplay({required this.artefacts, required this.onClick});

  static const int _setNumbersOfItemsInRow = 2;
  static double _setNumbersOfItemsInColumn(int x) => x / 2 + 1;

  @override
  Widget build(BuildContext context) => GridView.builder(
    physics: const BouncingScrollPhysics(),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: _setNumbersOfItemsInRow,
      childAspectRatio: _setNumbersOfItemsInColumn(artefacts.length),
    ),
    itemCount: artefacts.length,
    itemBuilder: (context, index) => Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: AppDimensions.baseEdgeInsets8),
          child: AppBaseButton.artefactsButton(
            onPressed: () =>
                Future.delayed(Duration(microseconds: 500), () => onClick(context, artefacts[index])),
            child: SvgPicture.asset(artefacts[index].asset.path),
          ),
        ),
        Text(
          artefacts[index].description.artefactName,
          style: TextStyles.quizArtefactCountWidget,
        ),
      ],
    ),
  );
}
