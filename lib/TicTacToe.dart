import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sudoku/ai.dart';
import 'package:sudoku/customDilog.dart';
import 'package:sudoku/logic.dart';

class TicTacToe extends StatefulWidget {
  final bool OneVSone;
  const TicTacToe({Key? key, required this.OneVSone}) : super(key: key);

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  late List<List<String>> controllers;
  late bool ovso = widget.OneVSone;
  late bool userTurn;
  int? rowAI;
  int? colAI;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(
      3,
      (_) => List.generate(3, (_) => ''),
    );
    userTurn = true;
    // ai_move();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tic Tac Toe')),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
  margin: EdgeInsets.all(20),
  height: 100,
  width: 340,
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(15),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.3),
        spreadRadius: 2,
        blurRadius: 4,
        offset: Offset(0, 2), // changes position of shadow
      ),
    ],
  ),
  child: (!ovso)
    ? Center(
      child: Text(
          (userTurn) ? 'Your turn: O' : "AI turn: X",
          style: TextStyle(fontSize: 25, color: Colors.black),
        ),
    )
    : Center(
      child: Text(
          (userTurn) ? 'Player 1 turn: O' : "Player 2 turn: X",
          style: TextStyle(fontSize: 25, color: Colors.black),
        ),
    ),
),

              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.all(1),
                width: 357,
                height: 360,
                decoration: BoxDecoration(
                  color:
                  
                   Color.fromARGB(197, 231, 227, 227),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    width: 4,
                    color: Color.fromARGB(255, 217, 239, 243),
                  ),
                ),
                child: Column(
                  children: List.generate(
                    3,
                    (i) => Row(
                      children: List.generate(
                        3,
                        (j) => Container(
                          margin: EdgeInsets.all(1),
                          width: 114.3,
                          height: 115.3,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(0),
                            border: Border(
                              top: BorderSide(
                                color: (i == 0 && j >= 0)
                                    ? const Color.fromARGB(255, 255, 255, 255)
                                    : Colors.cyan,
                                width: (i == 0 && j >= 0) ? 0 : 3,
                              ),
                              bottom: BorderSide(
                                  color: (i == 2 && j >= 0)
                                      ? const Color.fromARGB(255, 255, 255, 255)
                                      : Colors.cyan,
                                  width: (i == 2 && j >= 0) ? 0 : 3),
                              left: BorderSide(
                                color: (i >= 0 && j == 0)
                                    ? const Color.fromARGB(255, 255, 255, 255)
                                    : Colors.cyan,
                                width: (i >= 0 && j == 0) ? 0 : 3,
                              ),
                              right: BorderSide(
                                color: (i >= 0 && j == 2)
                                    ? const Color.fromARGB(255, 255, 255, 255)
                                    : Colors.cyan,
                                width: (i >= 0 && j == 2) ? 0 : 3,
                              ),
                            ),
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.white,
                            //     spreadRadius: 5,
                            //     blurRadius: 2,
                            //     offset: Offset(
                            //         0.2, 0.5), // changes position of shadow
                            //   ),
                            // ]
                          ),
                          child: TextButton(
                            onPressed: () {
                              if (!gameOver(controllers)) {
                                if (controllers[i][j] == '') {
                                  if(!ovso){
                                  setState(() {
                                    if(userTurn){
                                    controllers[i][j] = "O";
                                    userTurn =!userTurn;
                                  }
                                  ai_move();
                                  userTurn =!userTurn;
                                  
                                  
                                  });
                                  }else{
                                    setState(() {
                                    if(userTurn){
                                    controllers[i][j] = "O";
                                    userTurn =!userTurn;
                                  }else{
                                    controllers[i][j] = "X";
                                    userTurn =!userTurn;
                                  }
                                  
                                    });
                                  }
                                }
                              } else {
                                showDialog(
                            context: context,
                            builder: (BuildContext context) => CustomDialog(
                              title: "Opps!",
                              message: "You loss! Try again",
                              okButtonText: "Again",
                              cancelButtonText: "Cancel",
                              backgroundColor:
                                  const Color.fromARGB(255, 104, 187, 255),
                              iconData: Icons.emoji_people,
                            ),
                          );
                              }
                            },
                            child: Center(
                              child: Text(
                                controllers[i][j],
                                style: TextStyle(
                                  fontSize: 44,
                                  color: (controllers[i][j] == "X")
                                      ? Color.fromARGB(255, 230, 112, 112)
                                      : Color.fromARGB(255, 42, 82, 114),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void ai_move() {
    // Delay before AI's move
    Future.delayed(Duration(milliseconds: 500), () {
      if (!gameOver(controllers)) {
        setState(() {
          List<int>? bestMove = findBestMove(controllers);
          if (bestMove![0] != -1 && bestMove[1] != -1) {
            controllers[bestMove[0]][bestMove[1]] = "X";
          }
        });
      }
    });
  }
}
