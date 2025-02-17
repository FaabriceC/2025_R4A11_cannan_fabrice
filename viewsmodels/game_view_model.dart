
import 'package:demineur/models/map_model.dart';
import 'package:flutter/cupertino.dart';

import '../models/case_model.dart';

class GameViewModel extends ChangeNotifier {
  static const double size = 40;
  final MapModel _mapModel = MapModel();

  int get nbLine => _mapModel.nbLine;
  int get nbCol => _mapModel.nbCol;
  int get nbBomb => _mapModel.nbBomb;

  CaseModel? getCase(int x, int y) => _mapModel.getCase(x, y);
  bool isHiddenAt(int x, int y) => _mapModel.isHiddenAt(x, y);
  bool hasFlagAt(int x, int y) => _mapModel.hasFlagAt(x, y);
  bool hasExplodedAt(int x, int y) => _mapModel.hasExplodedAt(x, y);
  int numberAround(int x, int y) => _mapModel.numberAround(x, y);

  void generateMap(int lines, int cols, int bombs) {
    _mapModel.nbLine = lines;
    _mapModel.nbCol = cols;
    _mapModel.nbBomb = bombs;
    _mapModel.generateMap();
    notifyListeners();
  }

  void click(int x, int y) {
    if (!hasFlagAt(x, y)) {
      _mapModel.reveal(x, y);
      if (hasExplodedAt(x, y)) {
        _mapModel.revealAll();
      }
      notifyListeners();
    }
  }

  void onLongPress(int x, int y) {
    _mapModel.toggleFlag(x, y);
    notifyListeners();
  }

  Image getIcon(int x, int y) {
    final cell = _mapModel.cases[x][y];
    if (cell.hidden) {
      return Image.asset('assets/images/hidden.png', height: 40);
    } else if (cell.hasFlag) {
      return Image.asset('assets/images/flag.png', height: 40);
    } else if (cell.hasExploded) {
      return Image.asset('assets/images/explosion.png', height: 40);
    } else if (cell.hasBomb) {
      return Image.asset('assets/images/bomb.png', height: 40);
    } else {
      return Image.asset('assets/images/${cell.number}.png', height: 40);
    }
  }

}
