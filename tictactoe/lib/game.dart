import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//TicTacToe Game logic and Ui
//Andrew Hsu 11/2/2021

int currentMoves = 0;
List<String> _board = ['', '', '', '', '', '', '', '', '']; //empty board
String status = '';
String winner = '';
var _gamePageState;
var _turnState;
var _context;
String _turn = 'Your Turn';
bool loading = false;
bool vsBot = true;

class GamePage extends StatefulWidget {
  bool isBot;
  GamePage(this.isBot) {
    _resetGame();
    vsBot = this.isBot;
    if (vsBot) _turn = 'Your Turn';
  }
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    _gamePageState = this;
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic-Tac-Toe'),
      ),
      body: Container(
        decoration: BoxDecoration(color: Color(0xFFe6ebf2)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[_BoxContainer(), Status()],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            awaitfn('Reset?', 'Want to reset the current game?', 'Go Back',
                'Reset');
          });
        },
        tooltip: 'Restart',
        child: Icon(Icons.refresh),
      ),
    );
  }
}

class _BoxContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _context = context;
    return Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
            color: Colors.white,
            border: new Border.all(color: Colors.blue),
         ),
        child: Center(
            child: GridView.count(
          primary: false,
          crossAxisCount: 3,
          children: List.generate(9, (index) {
            return Box(index);
          }),
        )));
  }
}

class Box extends StatefulWidget {
  final int index;
  Box(this.index);
  @override
  _BoxState createState() => _BoxState();
}

class _BoxState extends State<Box> {
  void pressed() {
    print(currentMoves);
    setState(() {
      currentMoves++;
      if (_checkGame()) {
        awaitfnn();
      } else if (currentMoves >= 9) {
        awaitfn('It\'s a Draw', 'Want to try again?', 'Go Back', 'New Game');
      }
      _turnState.setState(() {
        if (currentMoves % 2 == 0)
          _turn = 'Your Turn';
        else
          _turn = 'Thinking...';
        _gamePageState.setState(() {});
      });
    });
  }

  @override
  Widget build(context) {
    return MaterialButton(
        padding: EdgeInsets.all(0),
        child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: new Border.all(color: Colors.blue)),
            child: Center(
              child: Text(
                _board[widget.index].toUpperCase(),
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
        onPressed: () {
          if (_board[widget.index] == '') {
            if (vsBot == false) {
              if (currentMoves % 2 == 0)
                _board[widget.index] = 'x';
              else
                _board[widget.index] = 'o';
            } else if (!loading) {
              loading = true;
              _board[widget.index] = 'o';
              if (currentMoves >= 8) {
              } else
                _bestMove(_board);
              //print(_board);
            }
            //print(vsBot);
            pressed();
          }
        });
  }
}

class Status extends StatefulWidget {
  @override
  _StatusState createState() => _StatusState();
}

class _StatusState extends State<Status> {
  @override
  Widget build(BuildContext context) {
    _turnState = this;
    return Card(
        margin: EdgeInsets.all(40),
        child: Container(
          width: 220,
          height: 60,
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Text(
            _turn,
            style: TextStyle(fontSize: 30),
            textAlign: TextAlign.center,
          ),
        ));
  }
}

//This is ingame logic for checking game winner
//Andrew Hsu 11/2/21

bool _checkGame() {
  for (int i = 0; i < 9; i += 3) {
    if (_board[i] != '' &&
        _board[i] == _board[i + 1] &&
        _board[i + 1] == _board[i + 2]) {
      winner = _board[i];
      return true;
    }
  }
  for (int i = 0; i < 3; i++) {
    if (_board[i] != '' &&
        _board[i] == _board[i + 3] &&
        _board[i + 3] == _board[i + 6]) {
      winner = _board[i];
      return true;
    }
  }
  if (_board[0] != '' && (_board[0] == _board[4] && _board[4] == _board[8]) ||
      (_board[2] != '' && _board[2] == _board[4] && _board[4] == _board[6])) {
    winner = _board[4];
    return true;
  }
  return false;
}

//Reset Game function
void _resetGame() {
  currentMoves = 0;
  status = '';
  _board = ['', '', '', '', '', '', '', '', ''];
  _turn = 'Your Turn';
  loading = false;
}
//Alert user of winner via alert dialog function
void awaitfnn() async {
  bool? result = await showDialog<bool>(
      context: _context,
      barrierDismissible: false,
      builder: (BuildContext _context) => AlertDialog(
        title: Text('$winner won!'.toUpperCase()),
        content: Text('Start a new Game?'),
        actions: <Widget>[
          RaisedButton(
            color: Colors.white,
            child: Text('Exit'),
            onPressed: () {
              Navigator.of(_context).pop(false);
            },
          ),
          RaisedButton(
            color: Colors.white,
            child: Text('New Game'),
            onPressed: () {
              Navigator.of(_context).pop(true);
            },
          )
        ],
      ));

  if (result!=null && result ==true) {
    _gamePageState.setState(() {
      _resetGame();
    });
  } else {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
}

//show alert dialog function, Run reset game function based off prompt
awaitfn(String title, String content, String btn1, String btn2) async {
  bool? result = await showDialog<bool>(
      context: _context,
      barrierDismissible: false,
      builder: (BuildContext _context) => AlertDialog(
        title: Text(title.toUpperCase()),
        content: Text(content),
        actions: <Widget>[
          RaisedButton(
            color: Colors.white,
            child: Text(btn1),
            onPressed: () {
              Navigator.of(_context).pop(false);
            },
          ),
          RaisedButton(
            color: Colors.white,
            child: Text(btn2),
            onPressed: () {
              Navigator.of(_context).pop(true);
            },
          )
        ],
      ));


  if (result!=null && result ==true) {
    _gamePageState.setState(() {
      _resetGame();
    });
  }
}

//Minimax logic for bot moves
int max(int a, int b) {
  return a > b ? a : b;
}

int min(int a, int b) {
  return a < b ? a : b;
}

String player = 'x', opponent = 'o';
//function to eval if there are any possible moves left in the game
bool isMovesLeft(List<String> _board) {
  int i;
  for (i = 0; i < 9; i++) {
    if (_board[i] == '') return true;
  }
  return false;
}
//Function to eval if board has winner
int _eval(List<String> _board) {
  for (int i = 0; i < 9; i += 3) {
    if (_board[i] != '' &&
        _board[i] == _board[i + 1] &&
        _board[i + 1] == _board[i + 2]) {
      winner = _board[i];
      return (winner == player) ? 10 : -10;
    }
  }
  for (int i = 0; i < 3; i++) {
    if (_board[i] != '' &&
        _board[i] == _board[i + 3] &&
        _board[i + 3] == _board[i + 6]) {
      winner = _board[i];
      return (winner == player) ? 10 : -10;
    }
  }
  if (_board[0] != '' && (_board[0] == _board[4] && _board[4] == _board[8]) ||
      (_board[2] != '' && _board[2] == _board[4] && _board[4] == _board[6])) {
    winner = _board[4];
    return (winner == player) ? 10 : -10;
  }
  return 0;
}
//Minimax logic function
int minmax(List<String> _board, int depth, bool isMax) {

  int score = _eval(_board);
  //print(score);
  int best = 0, i;

  if (score == 10 || score == -10) return score;
  if (!isMovesLeft(_board)) return 0;
  if (isMax) {
    best = -1000;
    for (i = 0; i < 9; i++) {
      if (_board[i] == '') {
        _board[i] = player;
        best = max(best, minmax(_board, depth + 1, !isMax));
        _board[i] = '';
      }
    }
    return best;
  } else {
    best = 1000;
    for (i = 0; i < 9; i++) {
      if (_board[i] == '') {
        _board[i] = opponent;
        best = min(best, minmax(_board, depth + 1, !isMax));
        _board[i] = '';
      }
    }
    //print(best);
    return best;
  }
}
//Function to determine best move for bot
Future<int> _bestMove(List<String> _board) async {

  int bestMove = -1000, moveVal;
  await Future.delayed(Duration(seconds: 1), () {

    int i;
    int bi=0;
    for (i = 0; i < 9; i++) {
      if (_board[i] == '') {
        moveVal = -1000;
        _board[i] = player;
        moveVal = minmax(_board, 0, false);
        _board[i] = '';
        if (moveVal > bestMove) {
          bestMove = moveVal;
          bi = i;
        }
      }
    }
    _board[bi] = player;
    _gamePageState.setState(() {});
    loading = false;
    _turnState.setState(() {

      _turn = 'Your Turn';

      currentMoves++;
    });
  });
  return bestMove;
}
