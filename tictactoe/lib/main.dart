import 'package:flutter/material.dart';
import 'mainsplash.dart';
//Tic Tac Toe project initial start 10/31/2021
//A simple tic tac toe game with a bot that utilizes minimax

//this is the main that calls our main splash page
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TicTacToe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainSplash(),
    );
  }
}

