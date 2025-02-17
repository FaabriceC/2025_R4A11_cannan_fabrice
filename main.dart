import 'package:demineur/models/map_model.dart';
import 'package:flutter/material.dart';
import 'package:demineur/views/game_view.dart';
import 'package:demineur/viewsmodels/game_view_model.dart'; // Import du modèle

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: GameView()
        ),
      ),
    );
  }
}