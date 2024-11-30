// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, annotate_overrides, camel_case_types

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sudoku/customDilog.dart';
import 'package:sudoku/loadingPage.dart';
import 'package:sudoku/logic.dart';
import 'package:sudoku/modesPage.dart';
import 'package:sudoku/stackUndo.dart';

class gameBoard extends StatefulWidget {
  final int miss;
  final int seconds;
  final int hints;
  const gameBoard(
      {Key? key,
      required this.miss,
      required this.seconds,
      required this.hints})
      : super(key: key);

  @override
  State<gameBoard> createState() => _gameBoardState();
}

class _gameBoardState extends State<gameBoard> {
  late logic logicObj;
  late List<List<TextEditingController>> controllers;
  late List<List<FocusNode>> focusNodes;
  late int tappedRow = 0;
  late int tappedColumn = 0;
  late int hint;
  int mistake = 3;
  bool pause = false;
  late List<List<List<String>>> cellsNotesList;
  String value = "";
  late Timer timer;

  List<String> notesList = List.generate(9, (index) => "");
  bool isNOteSelected = false;
  late stackUndo Undo;
  late bool challangeMood = widget.seconds > 1;
  late int _seconds = widget.seconds;

  @override
  void initState() {
    super.initState();
    logicObj = logic();
    hint = widget.hints;
    Undo = stackUndo();
    _seconds = widget.seconds;
    challangeMood = widget.seconds > 1;
    controllers = List.generate(
      9,
      (_) => List.generate(9, (_) => TextEditingController()),
    );
    focusNodes = List.generate(
      9,
      (_) => List.generate(9, (_) => FocusNode()),
    );
    cellsNotesList = List.generate(
      9,
      (_) => List.generate(9, (_) => List.generate(9, (_) => "")),
    );
    create(widget.miss);

    // Initialize and start the timer
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      
        setState(() {
          if( mistake>0 ){
          if (challangeMood) {
            if (_seconds == 0) {  
              showDialog(
              context: context,
              builder: (BuildContext context) => CustomDialog(
                title: "Time is End",
                message: "You Loss!",
                okButtonText: "Start Again",
                cancelButtonText: "Back",
                backgroundColor: const Color.fromARGB(255, 104, 187, 255),
                iconData: Icons.emoji_emotions,
                onOkPressed: () {
                   super.dispose(); 
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => sudokuLoadingScreen(
                    nextPageDelay: 1, 
                    nextPageBuilder: () => gameBoard(miss: widget.miss, seconds: widget.seconds, hints: widget.hints),)),);},
                onCancelPressed: () {
                  super.dispose();
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => sudokuLoadingScreen(
                    nextPageDelay: 1, 
                    nextPageBuilder: () => ModesPage(),)),);},));
            } else if(!boxfull() && !pause){
              _seconds--;}
          } else if(!boxfull() && !pause){
            _seconds++;}
          }else{
            showDialog(
              context: context,
              builder: (BuildContext context) => CustomDialog(
                title: "Mistake End ",
                message: "You Loss!",
                okButtonText: "Start Again",
                cancelButtonText: "Back",
                backgroundColor: const Color.fromARGB(255, 104, 187, 255),
                iconData: Icons.emoji_emotions,
                onOkPressed: () {
                   super.dispose(); 
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => sudokuLoadingScreen(
                    nextPageDelay: 1, 
                    nextPageBuilder: () => gameBoard(miss: widget.miss, seconds: widget.seconds, hints: widget.hints),)),);},
                onCancelPressed: () {
                  super.dispose();
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => sudokuLoadingScreen(
                    nextPageDelay: 1, 
                    nextPageBuilder: () => ModesPage(),)),);},));
          }
          
        });
    });
  }

  void dispose() {
    timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  void create(int number) {
    logicObj.generatePuzzle(number);
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        if (logic.arr[i][j] == 0) {
          controllers[i][j].text = "";
        } else {
          controllers[i][j].text = logic.arr[i][j].toString();
        }
      }
    }
  }
  bool boxfull(){
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        
          if(controllers[i][j].text == ""){
              return false;
          }
        
      }
    }
    return true;
  }

  Color rightColor() {
    if (_seconds % 2 == 0) {
      return Color.fromARGB(255, 247, 165, 165);
    } else {
      return Color.fromARGB(255, 238, 58, 58);
    }
  }

  Color leftColor() {
    if (_seconds % 2 == 0) {
      return Color.fromARGB(255, 247, 58, 58);
    } else {
      return const Color.fromARGB(255, 247, 165, 165);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SUDOKU')),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                width: 356,
                height: 95,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      (challangeMood && _seconds < widget.seconds * 0.20)
                          ? leftColor()
                          : Color.fromARGB(255, 255, 255, 255),
                      (challangeMood && _seconds < widget.seconds * 0.20)
                          ? Colors.white
                          : Color.fromARGB(255, 198, 215, 250),
                      (challangeMood && _seconds < widget.seconds * 0.20)
                          ? rightColor()
                          : Color.fromARGB(255, 126, 166, 245)
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("hostName"),
                            
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Mistakes: ${3 - mistake}/3',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(width: 25),
                            Text(
                              'Hints: ${widget.hints - hint}/${widget.hints}',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(width: 25),
                            Container(
                              margin: EdgeInsets.only(right: 5),
                              child: Row(
                                children: [
                                  Text(
                                      'Time: ${_seconds ~/ 60}:${(_seconds % 60).toString().padLeft(2, '0')}'),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        pause = !pause;
                                      });
                                    },
                                    child: Icon(
                                      pause ? Icons.play_arrow : Icons.pause,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: 356,
                height: 401,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    width: 2.3,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                child: Column(
                  children: List.generate(
                    9,
                    (i) => Row(
                      children: List.generate(
                        9,
                        (j) => Stack(
                          children: [
                            Container(
                              width: 39,
                              height: 44,
                              decoration: BoxDecoration(
                                color: (!pause)
                                    ? ((value == "")
                                        ? (((tappedRow == i ||
                                                    tappedColumn == j) ||
                                                (i ~/ 3 == tappedRow ~/ 3 &&
                                                    j ~/ 3 ==
                                                        tappedColumn ~/ 3))
                                            ? (tappedRow == i &&
                                                    tappedColumn == j)
                                                ? Colors.transparent
                                                : Color.fromARGB(
                                                    255, 166, 207, 241)
                                            : Colors.transparent)
                                        : ((controllers[i][j].text == value)
                                            ? Color.fromARGB(255, 166, 207, 241)
                                            : Colors.transparent))
                                    : Colors.white,
                              ),
                              child: GridView.count(
                                crossAxisCount: 3,
                                children: List.generate(
                                  9,
                                  (index) => Center(
                                    child: (controllers[i][j].text == '')
                                        ? Text(
                                            cellsNotesList[i][j][index],
                                            style: TextStyle(
                                              color: (!pause)
                                                  ? Colors.black
                                                  : Colors.transparent,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          )
                                        : Text(''),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 39,
                              height: 44,
                              decoration: BoxDecoration(
                                border: Border(
                                  top: (i % 3 == 0)
                                      ? BorderSide(
                                          color: Colors.black, width: 2)
                                      : BorderSide.none,
                                  bottom: BorderSide(
                                      color: Colors.black, width: 0.5),
                                  left: (j % 3 == 0)
                                      ? BorderSide(
                                          color: Colors.black, width: 2)
                                      : BorderSide.none,
                                  right: BorderSide(
                                      color: Colors.black, width: 0.5),
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: (i == 0 && j == 0)
                                      ? Radius.circular(15)
                                      : Radius.zero,
                                  topRight: (i == 0 && j == 8)
                                      ? Radius.circular(15)
                                      : Radius.zero,
                                  bottomLeft: (i == 8 && j == 0)
                                      ? Radius.circular(15)
                                      : Radius.zero,
                                  bottomRight: (i == 8 && j == 8)
                                      ? Radius.circular(15)
                                      : Radius.zero,
                                ),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    if (!pause) {
                                      Undo.push(tappedRow, tappedColumn);
                                      tappedRow = i;
                                      tappedColumn = j;
                                      value = controllers[i][j].text;

                                      FocusScope.of(context)
                                          .requestFocus(focusNodes[i][j]);
                                    }
                                  });
                                },
                                child: Center(
                                  child: Text(
                                    controllers[i][j].text,
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: (!pause)
                                          ? ((controllers[i][j].text !=
                                                  logic.filledarr[i][j]
                                                      .toString())
                                              ? Color.fromARGB(
                                                  255, 230, 112, 112)
                                              : Color.fromARGB(
                                                  255, 42, 82, 114))
                                          : Colors.transparent,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildActionButton(
                      Icons.undo,
                      (Undo.size() == 0) ? Colors.blueGrey : Colors.blue,
                      (Undo.size() == 0)
                          ? Colors.blueGrey
                          : Colors.blue.withOpacity(0.5),
                      'Undo',
                      () {
                        setState(() {
                          List<dynamic>? UndoItem = Undo.pop();
                          if (UndoItem != null) {
                            tappedRow = UndoItem[0];
                            tappedColumn = UndoItem[1];
                            controllers[tappedRow][tappedColumn].text =
                                (controllers[tappedRow][tappedColumn].text ==
                                        logic.filledarr[tappedRow][tappedColumn]
                                            .toString())
                                    ? controllers[tappedRow][tappedColumn].text
                                    : "";
                          }
                        });
                      },
                    ),
                    buildActionButton(
                      Icons.delete,
                      Colors.red,
                      Colors.red.withOpacity(0.5),
                      'Erase',
                      () {
                        setState(() {
                          
                          (controllers[tappedRow][tappedColumn].text !=
                                  logic.filledarr[tappedRow][tappedColumn]
                                      .toString())
                              ? controllers[tappedRow][tappedColumn].clear()
                              : null;
                        });
                      },
                    ),
                    buildActionButton(
                      Icons.note,
                      (isNOteSelected)
                          ? Color.fromARGB(255, 1, 94, 4)
                          : Colors.green,
                      (isNOteSelected)
                          ? Color.fromARGB(255, 26, 102, 48)
                          : Color.fromARGB(255, 107, 172, 110).withOpacity(0.5),
                      'Notes',
                      () {
                        setState(() {
                          isNOteSelected = !isNOteSelected;
                        });
                      },
                    ),
                    buildActionButton(
                      Icons.lightbulb,
                      (hint == 0)
                          ? Colors.grey
                          : Color.fromARGB(255, 206, 177, 47),
                      (hint == 0)
                          ? Colors.grey
                          : Colors.orange.withOpacity(0.5),
                      'Hint',
                      () {
                        setState(() {
                          if (controllers[tappedRow][tappedColumn].text !=
                              logic.filledarr[tappedRow][tappedColumn]
                                  .toString()) {
                            if (hint != 0) {
                              controllers[tappedRow][tappedColumn].text = logic
                                  .filledarr[tappedRow][tappedColumn]
                                  .toString();
                              hint--;
                            }
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  9,
                  (index) => Container(
                    height: 80,
                    width: 40,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          
                          if (mistake > 0 && _seconds != 0 && !pause) {
                            if (!isNOteSelected) {
                              if (controllers[tappedRow][tappedColumn].text !=
                                  logic.filledarr[tappedRow][tappedColumn]
                                      .toString()) {
                                controllers[tappedRow][tappedColumn].text =
                                    (index + 1).toString();
                                Undo.push(tappedRow, tappedColumn);
                                if (controllers[tappedRow][tappedColumn].text !=
                                    logic.filledarr[tappedRow][tappedColumn]
                                        .toString()) {
                                  mistake--;
                                }
                              }
                            } else {
                              if (cellsNotesList[tappedRow][tappedColumn]
                                      [index] ==
                                  '${index + 1}') {
                                cellsNotesList[tappedRow][tappedColumn][index] =
                                    '';
                              } else {
                                cellsNotesList[tappedRow][tappedColumn][index] =
                                    '${index + 1}';
                              }
                            }
                          
                          }else{
                            



                          }
                            
                            
                          
                          
                        });
                      },
                      child: Text(
                        (index + 1).toString(),
                        style: TextStyle(fontSize: 35),
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

  Widget buildActionButton(IconData iconData, Color iconColor,
      Color backgroundColor, String label, Function() onPressed) {
    return Column(
      children: [
        GestureDetector(
          onTap: (!pause && _seconds != 0 && mistake > 0) ? onPressed : () {},
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: backgroundColor.withOpacity(0.5),
            ),
            child: Icon(
              iconData,
              size: 35,
              color: iconColor,
            ),
          ),
        ),
        SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: iconColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
