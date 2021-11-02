import 'package:flutter/material.dart';
import 'game.dart';
//Tic Tac Toe main splash page by Andrew Hsu 10/31/21
//this is the splash page for starting the game.
//a simple start new game button

class MainSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TicTacToe"),
      ),
      body: Container(
          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Container(
                  width: 100,
                  child:
                      RaisedButton(
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 6),
                        child: Container(
                            width: 100,
                            child: Center(
                              child: Text(
                                'Start New Game',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 30),
                              ),
                            )),
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return GamePage(true);
                          }));
                        },
                      ),
                ),
              )
            ],
          )),
    );
  }
}
