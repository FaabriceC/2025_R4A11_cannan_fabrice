import 'dart:math';
import 'package:demineur/models/case_model.dart';
import 'package:flutter/cupertino.dart';

class MapModel {
  int nbLine = 0;
  int nbCol = 0;
  int nbBomb = 0;
  late List<List<CaseModel>> _cases;

  List<List<CaseModel>> get cases => _cases;

  void initCases() {
    _cases = List.generate(
      nbLine,
          (i) => List.generate(nbCol, (j) => CaseModel()),
    );
  }

  void initBombs() {
    int nbBombSet = 0;

    while (nbBombSet < nbBomb) {
      int x = Random().nextInt(nbCol);
      int y = Random().nextInt(nbLine);

      if (!_cases[y][x].hasBomb) {
        _cases[y][x].hasBomb = true;
        nbBombSet++;
      }
    }
  }

  void initNumbers() {
    for (var y = 0; y < nbLine; y++) {
      for (var x = 0; x < nbCol; x++) {
        final currentCase = _cases[y][x];
        if (!currentCase.hasBomb) {
          currentCase.number = computeNumber(x, y);
        }
      }
    }
  }

  int computeNumber(int x, int y) {
    const directions = [
      [-1, -1], [-1, 0], [-1, 1],
      [0, -1],          [0, 1],
      [1, -1], [1, 0], [1, 1]
    ];

    return directions
        .where((d) => tryGetCase(x + d[0], y + d[1])?.hasBomb ?? false)
        .length;
  }

  CaseModel? tryGetCase(int x, int y) {
    if (x >= 0 && x < nbCol && y >= 0 && y < nbLine) {
      return _cases[y][x];
    }
    return null;
  }

  void generateMap() {
    initCases();
    initBombs();
    initNumbers();
  }

  void reveal(int x, int y) {
    final currentCase = _cases[y][x];
    if (currentCase.hidden && !currentCase.hasFlag) {
      currentCase.hidden = false;

      if (currentCase.hasBomb) {
        explode(x, y);
      } else if (currentCase.number == 0) {
        revealAdjacent(x, y);
      }
    }
  }

  void revealAll() {
    for (var row in _cases) {
      for (var cell in row) {
        cell.hidden = false;
      }
    }
  }

  void explode(int x, int y) {
    _cases[y][x].hasExploded = true;
    revealAll();
  }

  void toggleFlag(int x, int y) {
    if (_cases[y][x].hidden) {
      _cases[y][x].hasFlag = !_cases[y][x].hasFlag;
    }
  }

  void revealAdjacent(int x, int y) {
    const directions = [
      [-1, -1], [-1, 0], [-1, 1],
      [0, -1],          [0, 1],
      [1, -1], [1, 0], [1, 1]
    ];

    for (var dir in directions) {
      final nvX = x + dir[0];
      final nvY = y + dir[1];

      if (nvX >= 0 && nvX < nbCol && nvY >= 0 && nvY < nbLine) {
        final neighbor = _cases[nvY][nvX];
        if (neighbor.hidden && !neighbor.hasBomb) {
          reveal(nvX, nvY);
        }
      }
    }
  }

  CaseModel? getCase(int x, int y) => tryGetCase(x, y);

  bool hasBombAt(int x, int y) => getCase(x, y)?.hasBomb ?? false;

  int numberAround(int x, int y) => getCase(x, y)?.number ?? 0;

  bool isHiddenAt(int x, int y) => getCase(x, y)?.hidden ?? false;

  bool hasFlagAt(int x, int y) => getCase(x, y)?.hasFlag ?? false;

  bool hasExplodedAt(int x, int y) => getCase(x, y)?.hasExploded ?? false;
}
