import 'package:flutter/material.dart';
import 'package:demineur/viewsmodels/game_view_model.dart';
import 'package:demineur/widgets/map_button.dart';
import 'package:provider/provider.dart';

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GameViewModel()..generateMap(10, 10, 20),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Démineur', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          backgroundColor: Colors.blueAccent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<GameViewModel>(
            builder: (context, viewModel, child) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        "Cliquez sur les cases pour révéler ou marquer avec un drapeau!",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                      ),
                    ),
                    Table(
                      border: TableBorder.all(color: Colors.black, width: 2),
                      children: List.generate(viewModel.nbLine, (x) {
                        return TableRow(
                          children: List.generate(viewModel.nbCol, (y) {
                            return MapButton(
                              x: x,
                              y: y,
                              viewModel: viewModel,
                            );
                          }),
                        );
                      }),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
