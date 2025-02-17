import 'package:demineur/viewsmodels/game_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demineur/models/case_model.dart';

class MapButton extends StatelessWidget {
  final int x;
  final int y;

  const MapButton({
    super.key,
    required this.x,
    required this.y,
    required GameViewModel viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<GameViewModel>(
      builder: (context, viewModel, child) {
        final CaseModel? currentCase = viewModel.getCase(x, y);

        if (currentCase == null) {
          return SizedBox.shrink();
        }

        final bool isHidden = currentCase.hidden;
        final bool hasFlag = currentCase.hasFlag;
        final bool hasBomb = currentCase.hasBomb;

        final double buttonSize = GameViewModel.size;

        return InkWell(
          onTap: () => viewModel.click(x, y),
          onLongPress: () => viewModel.onLongPress(x, y),
          child: Container(
            width: buttonSize,
            height: buttonSize,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              color: isHidden ? Colors.blueGrey : Colors.white,
            ),
            child: Center(
              child: _buildCellContent(
                isHidden: isHidden,
                hasFlag: hasFlag,
                hasBomb: hasBomb,
                buttonSize: buttonSize,
                viewModel: viewModel,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCellContent({
    required bool isHidden,
    required bool hasFlag,
    required bool hasBomb,
    required double buttonSize,
    required GameViewModel viewModel,
  }) {
    if (hasFlag) {
      return Image.asset(
        'assets/images/flag.png',
        height: buttonSize,
      );
    } else if (isHidden) {
      return Image.asset(
        'assets/images/hidden.png',
        height: buttonSize,
      );
    } else {
      return viewModel.getIcon(x, y);
    }
  }
}
