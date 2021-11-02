import 'package:flutter/material.dart';
import 'game.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart' as neomorphicTheme;
import 'package:flutter_glow/flutter_glow.dart';
import 'Uieffects.dart';

//Tic Tac Toe main splash page by Andrew Hsu 10/31/21
//this is the splash page for starting the game.
//a simple start new game button

//these variables are for the ui gloweffect/mask effect for the play button
bool iconSelected = false;
double playbuttondepth = 8;
//init app
void main() {
  runApp(MainSplash());
}

class MainSplash extends StatefulWidget {
  @override
  TicTacToeApp createState() => TicTacToeApp();
}

//app background/adding neumorphic theme to overall app
class TicTacToeApp extends State<MainSplash> {
  @override
  Widget build(BuildContext context) {
    return neomorphicTheme.NeumorphicApp(
      debugShowCheckedModeBanner: false,
      title: 'Tic-Tac-Toe',
      themeMode: ThemeMode.light,
      theme: neomorphicTheme.NeumorphicThemeData(
        baseColor: Color(0xFFe6ebf2),
        lightSource: neomorphicTheme.LightSource.topLeft,
        depth: 10,
      ),
      darkTheme: neomorphicTheme.NeumorphicThemeData(
        baseColor: Color(0xFFe6ebf2),
        lightSource: neomorphicTheme.LightSource.topLeft,
        depth: 6,
      ),
      home: TicTacToe(),
    );
  }
}

class TicTacToe extends StatefulWidget {
  @override
  playButtonState createState() => playButtonState();
}
//play button ui and logic code
class playButtonState extends State<TicTacToe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: neomorphicTheme.NeumorphicAppBar(
        title: Text("Tic-Tac-Toe"),
      ),
      body: Container(
          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                //main ui and logic for play button here
                child: Container(
                    height: 100,
                    width: 100,
                    child: neomorphicTheme.NeumorphicButton(
                      onPressed: () {
                        setState(() {
                          if (playbuttondepth == 8) {
                            playbuttonmask1 = Colors.lightBlueAccent;
                            playbuttonmask2 = Colors.lightBlueAccent;
                            playbuttondepth = -2;
                            iconSelected = true;
                          } else {
                            playbuttonmask1 = Colors.lightBlueAccent;
                            playbuttonmask2 = Colors.pinkAccent;
                            playbuttondepth = 8;
                            iconSelected = false;
                          }
                        });
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return GamePage(true);
                        }));
                      },
                      style: neomorphicTheme.NeumorphicStyle(
                          intensity: 0.9,
                          shape: neomorphicTheme.NeumorphicShape.flat,
                          boxShape:
                              neomorphicTheme.NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(15)),
                          depth: playbuttondepth,
                          lightSource: neomorphicTheme.LightSource.topLeft,
                          color: Color(0xFFe6ebf2)),
                      padding: const EdgeInsets.all(12.0),
                      child: playButtonMask(
                        child: GlowIcon(
                          iconSelected
                              ? Icons.play_arrow_outlined
                              : Icons.play_arrow_outlined,
                          color: Colors.white,
                          glowColor: iconSelected
                              ? Colors.lightBlue
                              : Colors.transparent,
                          size: 55,
                          blurRadius: 4,
                        ),
                      ),
                    )),
              ),
              Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Lets Play!",
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                  )),
            ],
          )),
    );
  }
}
