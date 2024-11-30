// // ignore_for_file: prefer_const_constructors, unnecessary_import, camel_case_types, use_super_parameters, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_final_fields

// import 'dart:async';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:sudoku/logic.dart';
// import 'package:sudoku/stackUndo.dart';

// class gameBoard extends StatefulWidget {
//   final int miss;
//   final int seconds;
//   const gameBoard({Key? key, required this.miss, required this.seconds})
//       : super(key: key);

//   @override
//   State<gameBoard> createState() => _gameBoardState();
// }

// class _gameBoardState extends State<gameBoard> {
//   late logic logicObj;
//   late List<List<TextEditingController>> controllers;
//   late List<List<FocusNode>> focusNodes;
//   late int tappedRow = 0;
//   late int tappedColumn = 0;
//   int hint = 3;
//   int mistake = 3;
//   bool pause = false;
//   late List<List<List<String>>> cellsNotesList;
//   String value = "";
//   late Timer timer;

//   List<String> notesList = List.generate(9, (index) => "");
//   bool isNOteSelected = false;
//   late stackUndo Undo;
//   late bool challangeMood = widget.seconds > 0;
//   late int _seconds = (challangeMood) ? widget.seconds : 0;

//   @override
//   void initState() {
//     super.initState();
//     logicObj = logic();
//     Undo = stackUndo();
//     controllers = List.generate(
//       9,
//       (_) => List.generate(9, (_) => TextEditingController()),
//     );
//     focusNodes = List.generate(
//       9,
//       (_) => List.generate(9, (_) => FocusNode()),
//     );
//     cellsNotesList = List.generate(
//       9,
//       (_) => List.generate(9, (_) => List.generate(9, (_) => "")),
//     );
//     create(widget.miss);

//     // Initialize and start the timer
//     timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       if (!pause) {
//         setState(() {
//           if (challangeMood) {
//             if (_seconds == 0) {
//               _seconds;
//             } else {
//               _seconds--;
//             }
//           } else {
//             _seconds++;
//           }
//         });
//       }
//     });
//   }

//   void dispose() {
//     timer.cancel(); // Cancel the timer when the widget is disposed
//     super.dispose();
//   }

//   void create(int number) {
//     logicObj.generatePuzzle(number);
//     for (int i = 0; i < 9; i++) {
//       for (int j = 0; j < 9; j++) {
//         if (logic.arr[i][j] == 0) {
//           controllers[i][j].text = "";
//         } else {
//           controllers[i][j].text = logic.arr[i][j].toString();
//         }
//       }
//     }
//   }

//   Color rightColor() {
//     if (_seconds % 2 == 0) {
//       return Color.fromARGB(255, 247, 165, 165);
//     } else {
//       return Color.fromARGB(255, 238, 58, 58);
//     }
//   }

//   Color leftColor() {
//     if (_seconds % 2 == 0) {
//       return Color.fromARGB(255, 247, 58, 58);
//     } else {
//       return const Color.fromARGB(255, 247, 165, 165);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('SUDOKU')),
//       body: SingleChildScrollView(
//         child: Center(
//           child: Column(
//             children: [
//               Container(
//                   margin: EdgeInsets.all(10),
//                   padding: EdgeInsets.all(10),
//                   width: 356,
//                   height: 90,
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         (challangeMood && _seconds < 60)
//                             ? leftColor()
//                             : Color.fromARGB(255, 255, 255, 255),
//                         (challangeMood && _seconds < 60)
//                             ? Colors.white
//                             : Color.fromARGB(255, 198, 215, 250),
//                         (challangeMood && _seconds < 60)
//                             ? rightColor()
//                             : Color.fromARGB(255, 126, 166, 245)
//                       ],
//                       begin: Alignment.bottomLeft,
//                       end: Alignment.topRight,
//                     ),
//                     borderRadius: BorderRadius.circular(10),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.5),
//                         spreadRadius: 2,
//                         blurRadius: 5,
//                         offset: Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Row(
//   children: [
//     Text("hostName"),
//     IconButton(
//       onPressed: () {
//        setState(() {
//          Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => gameBoard(miss: widget.miss, seconds: widget.seconds)));
//        });
//       },
//       icon: Icon(Icons.refresh), // Replace 'restart' with the correct icon
//     ),
//   ],
// ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Text(
//                                 'Mistakes: ${3 - mistake}/3',
//                                 style: TextStyle(fontSize: 16),
//                               ), // Display mistakes left
//                               SizedBox(
//                                 width: 25,
//                               ),
//                               Text('Hints: ${3 - hint}/3',
//                                   style: TextStyle(fontSize: 16)),
//                               SizedBox(
//                                 width: 25,
//                               ),
//                               Row(
//                                 children: [
//                                   Text(
//                                       'Time: ${_seconds ~/ 60}:${(_seconds % 60).toString().padLeft(2, '0')}'),
//                                   GestureDetector(
//                                     onTap: () {
//                                       setState(() {
//                                         pause = !pause;
//                                       });
//                                     },
//                                     child: Icon(
//                                         pause ? Icons.play_arrow : Icons.pause),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ],
//                   )),
//               Container(
//                 width: 356,
//                 height: 401,
//                 decoration: BoxDecoration(
//                     borderRadius:
//                         BorderRadius.circular(15), // Adjust the value as needed
//                     border: Border.all(
//                         width: 2.3, color: Color.fromARGB(255, 0, 0, 0))),
//                 child: Column(
//                   children: List.generate(
//                     9,
//                     (i) => Row(
//                       children: List.generate(
//                         9,
//                         (j) => Stack(children: [
//                           Container(
//                             width: 39,
//                             height: 44,
//                             decoration: BoxDecoration(
//                               color: (!pause)
//                                   ? ((value == "")
//                                       ? (((tappedRow == i ||
//                                                   tappedColumn == j) ||
//                                               (i ~/ 3 == tappedRow ~/ 3 &&
//                                                   j ~/ 3 == tappedColumn ~/ 3))
//                                           ? (tappedRow == i &&
//                                                   tappedColumn == j)
//                                               ? Colors.transparent
//                                               : Color.fromARGB(
//                                                   255, 166, 207, 241)
//                                           : Colors.transparent)
//                                       : ((controllers[i][j].text == value)
//                                           ? Color.fromARGB(255, 166, 207, 241)
//                                           : Colors.transparent))
//                                   : Colors.white,
//                             ),
//                             child: GridView.count(
//                               crossAxisCount: 3,
//                               children: List.generate(
//                                 9,
//                                 (index) => Center(
//                                   child: (controllers[i][j].text == '')
//                                       ? Text(
//                                           cellsNotesList[i][j][
//                                               index], // Display note from cellsNotesList
//                                           style: TextStyle(
//                                               fontSize: 10,
//                                               fontWeight: FontWeight.w900),
//                                         )
//                                       : Text(
//                                           ''), // Empty Text widget if cell is filled
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             width: 39,
//                             height: 44,
//                             decoration: BoxDecoration(
//                               border: Border(
//                                 top: (i % 3 == 0)
//                                     ? BorderSide(color: Colors.black, width: 2)
//                                     : BorderSide.none,
//                                 bottom:
//                                     BorderSide(color: Colors.black, width: 0.5),
//                                 left: (j % 3 == 0)
//                                     ? BorderSide(color: Colors.black, width: 2)
//                                     : BorderSide.none,
//                                 right:
//                                     BorderSide(color: Colors.black, width: 0.5),
//                               ),
//                               borderRadius: BorderRadius.only(
//                                 topLeft: (i == 0 && j == 0)
//                                     ? Radius.circular(15)
//                                     : Radius.zero,
//                                 topRight: (i == 0 && j == 8)
//                                     ? Radius.circular(15)
//                                     : Radius.zero,
//                                 bottomLeft: (i == 8 && j == 0)
//                                     ? Radius.circular(15)
//                                     : Radius.zero,
//                                 bottomRight: (i == 8 && j == 8)
//                                     ? Radius.circular(15)
//                                     : Radius.zero,
//                               ),
//                             ),
//                             child: TextButton(
//                               onPressed: () {
//                                 setState(() {
//                                   if (!pause) {
//                                     Undo.push(tappedRow, tappedColumn);
//                                     tappedRow = i;
//                                     tappedColumn = j;
//                                     value = controllers[i][j].text;

//                                     FocusScope.of(context)
//                                         .requestFocus(focusNodes[i][j]);
//                                   }
//                                 });
//                               }, // Disable button if not tapped

//                               child: Center(
//                                 child: Text(
//                                   controllers[i][j]
//                                       .text, // Set text of the button
//                                   style: TextStyle(
//                                     fontSize: 24,
//                                     color: (!pause)
//                                         ? ((controllers[i][j].text !=
//                                                 logic.filledarr[i][j]
//                                                     .toString())
//                                             ? Color.fromARGB(255, 230, 112, 112)
//                                             : Color.fromARGB(255, 42, 82, 114))
//                                         : Colors.transparent,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ]),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Container(
//                 height: 80,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     buildActionButton(
//                         Icons.undo,
//                         (Undo.size() == 0) ? Colors.blueGrey : Colors.blue,
//                         (Undo.size() == 0)
//                             ? Colors.blueGrey
//                             : Colors.blue.withOpacity(0.5),
//                         'Undo', () {
//                       setState(() {
//                         List<dynamic>? UndoItem = Undo.pop();
//                         if (UndoItem != null) {
//                           tappedRow = UndoItem[0];
//                           tappedColumn = UndoItem[1];
//                           controllers[tappedRow][tappedColumn].text =
//                               (controllers[tappedRow][tappedColumn].text ==
//                                       logic.filledarr[tappedRow][tappedColumn]
//                                           .toString())
//                                   ? controllers[tappedRow][tappedColumn].text
//                                   : "";
//                         }
//                       });
//                     }),
//                     buildActionButton(Icons.delete, Colors.red,
//                         Colors.red.withOpacity(0.5), 'Erase', () {
//                       setState(() {
//                         (controllers[tappedRow][tappedColumn].text !=
//                                 logic.filledarr[tappedRow][tappedColumn]
//                                     .toString())
//                             ? controllers[tappedRow][tappedColumn].clear()
//                             : null;
//                       });
//                     }),
//                     buildActionButton(
//                         Icons.note,
//                         (isNOteSelected)
//                             ? Color.fromARGB(255, 1, 94, 4)
//                             : Colors.green,
//                         (isNOteSelected)
//                             ? Color.fromARGB(255, 26, 102,
//                                 48) // Dark shade of green when selected
//                             : Color.fromARGB(255, 107, 172, 110)
//                                 .withOpacity(0.5),
//                         'Notes', () {
//                       setState(() {
//                         isNOteSelected = !isNOteSelected;
//                       });
//                     }),
//                     buildActionButton(
//                         Icons.lightbulb,
//                         (hint == 0 )?Colors.grey:Color.fromARGB(255, 206, 177, 47),
//                         (hint == 0 )?Colors.grey:Colors.orange.withOpacity(0.5),
//                         'Hint', () {
//                       setState(() {
//                         if (controllers[tappedRow][tappedColumn].text !=
//                             logic.filledarr[tappedRow][tappedColumn]
//                                 .toString()) {
//                           if (hint > 0) {
//                             controllers[tappedRow][tappedColumn].text = logic
//                                 .filledarr[tappedRow][tappedColumn]
//                                 .toString();
//                             hint--;
//                           }
//                         }
//                       });
//                     }),
//                   ],
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: List.generate(
//                   9,
//                   (index) => Container(
//                     height: 80,
//                     width: 40,
//                     child: TextButton(
//                       onPressed: () {
//                         setState(() {
//                           if (mistake > 0 && !pause) {
//                             if (!isNOteSelected) {
//                               if (controllers[tappedRow][tappedColumn].text !=
//                                   logic.filledarr[tappedRow][tappedColumn]
//                                       .toString()) {
//                                 controllers[tappedRow][tappedColumn].text =
//                                     (index + 1).toString();
//                                 Undo.push(tappedRow, tappedColumn);
//                                 if (controllers[tappedRow][tappedColumn].text !=
//                                     logic.filledarr[tappedRow][tappedColumn]
//                                         .toString()) {
//                                   mistake--;
//                                 }
//                               }
//                             } else {
//                               if (cellsNotesList[tappedRow][tappedColumn]
//                                       [index] ==
//                                   '${index + 1}') {
//                                 cellsNotesList[tappedRow][tappedColumn][index] =
//                                     '';
//                               } else {
//                                 cellsNotesList[tappedRow][tappedColumn][index] =
//                                     '${index + 1}';
//                               }
//                             }
//                           }
//                         });
//                       },
//                       child: Text(
//                         (index + 1).toString(),
//                         style: TextStyle(fontSize: 35),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildActionButton(IconData iconData, Color iconColor,
//       Color backgroundColor, String label, Function() onPressed) {
//     return Column(
//       children: [
//         GestureDetector(
//           onTap: (!pause) ? onPressed : () {},
//           child: Container(
//             padding: EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: backgroundColor.withOpacity(0.5),
//             ),
//             child: Icon(
//               iconData,
//               size: 35,
//               color: iconColor,
//             ),
//           ),
//         ),
//         SizedBox(height: 5),
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 14,
//             color: iconColor,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ],
//     );
//   }
// }



// void main() {
//   runApp(MaterialApp(
//     home: SettingsPage(),
//   ));
// }

// class SettingsPage extends StatefulWidget {
//   const SettingsPage({Key? key}) : super(key: key);

//   @override
//   State<SettingsPage> createState() => _SettingsPageState();
// }

// class _SettingsPageState extends State<SettingsPage> {
//   bool _darkMode = false;
//   bool _soundEffects = true;
//   bool _vibrations = true;
//   int _timerValue = 30;
//   bool _lightningMode = false;
//   bool _magicNote = false;
//   bool _displayScores = true;
//   bool _showActualScore = true;
//   int _mistakeLimit = 3;
//   bool _hideUsedNumber = true;
//   bool _highlightAreas = true;
//   bool _highlightIdenticalNumbers = true;
//   bool _autoRemoveNotes = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Settings'),
//       ),
//       body: ListView(
//         children: [
//           SwitchListTile(
//             title: const Text('Dark Mode'),
//             value: _darkMode,
//             onChanged: (value) {
//               setState(() {
//                 _darkMode = value;
//               });
//             },
//           ),
//           SwitchListTile(
//             title: const Text('Sound Effects'),
//             value: _soundEffects,
//             onChanged: (value) {
//               setState(() {
//                 _soundEffects = value;
//               });
//             },
//           ),
//           SwitchListTile(
//             title: const Text('Vibrations'),
//             value: _vibrations,
//             onChanged: (value) {
//               setState(() {
//                 _vibrations = value;
//               });
//             },
//           ),
//           ListTile(
//             title: const Text('Timer'),
//             trailing: DropdownButton<int>(
//               value: _timerValue,
//               items: [
//                 for (int value in [30, 60, 120])
//                   DropdownMenuItem<int>(
//                     value: value,
//                     child: Text('$value seconds'),
//                   ),
//               ],
//               onChanged: (value) {
//                 setState(() {
//                   _timerValue = value!;
//                 });
//               },
//             ),
//           ),
//           SwitchListTile(
//             title: const Text('Lightning Mode'),
//             value: _lightningMode,
//             onChanged: (value) {
//               setState(() {
//                 _lightningMode = value;
//               });
//             },
//           ),
//           SwitchListTile(
//             title: const Text('Magic Note'),
//             value: _magicNote,
//             onChanged: (value) {
//               setState(() {
//                 _magicNote = value;
//               });
//             },
//           ),
//           SwitchListTile(
//             title: const Text('Display Scores'),
//             value: _displayScores,
//             onChanged: (value) {
//               setState(() {
//                 _displayScores = value;
//               });
//             },
//           ),
//           SwitchListTile(
//             title: const Text('Show Actual Score'),
//             value: _showActualScore,
//             onChanged: (value) {
//               setState(() {
//                 _showActualScore = value;
//               });
//             },
//           ),
//           ListTile(
//             title: const Text('Mistake Limit'),
//             trailing: DropdownButton<int>(
//               value: _mistakeLimit,
//               items: [
//                 for (int value in [3, 5, 7])
//                   DropdownMenuItem<int>(
//                     value: value,
//                     child: Text('$value mistakes'),
//                   ),
//               ],
//               onChanged: (value) {
//                 setState(() {
//                   _mistakeLimit = value!;
//                 });
//               },
//             ),
//           ),
//           SwitchListTile(
//             title: const Text('Hide Used Number'),
//             value: _hideUsedNumber,
//             onChanged: (value) {
//               setState(() {
//                 _hideUsedNumber = value;
//               });
//             },
//           ),
//           SwitchListTile(
//             title: const Text('Highlight Areas'),
//             value: _highlightAreas,
//             onChanged: (value) {
//               setState(() {
//                 _highlightAreas = value;
//               });
//             },
//           ),
//           SwitchListTile(
//             title: const Text('Highlight Identical Numbers'),
//             value: _highlightIdenticalNumbers,
//             onChanged: (value) {
//               setState(() {
//                 _highlightIdenticalNumbers = value;
//               });
//             },
//           ),
//           SwitchListTile(
//             title: const Text('Auto Remove Notes'),
//             value: _autoRemoveNotes,
//             onChanged: (value) {
//               setState(() {
//                 _autoRemoveNotes = value;
//               });
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
