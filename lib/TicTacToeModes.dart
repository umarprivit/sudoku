// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sudoku/TicTacToe.dart';
import 'package:sudoku/TicTactoeLoadingScreen.dart';
import 'package:sudoku/challengeMode.dart';
import 'package:sudoku/gameBoard.dart';
import 'package:sudoku/loadingPage.dart';

class TicTacToeModes extends StatefulWidget {
  @override
  _TicTacToeModesState createState() => _TicTacToeModesState();
}

class _TicTacToeModesState extends State<TicTacToeModes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Difficulty',
          style: TextStyle(fontFamily: 'Pacifico'), // Example of custom font
        ),
        centerTitle: true,
      ),
      body: Container(

        child: Center(
          child: Container(
            width: 250,
            height: 350,
            padding: EdgeInsets.all(20),
            
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 239, 246, 247),
              borderRadius: BorderRadius.circular(10),
              
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(204, 0, 0, 0).withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ModeButton(
                  label: 'ONE Vs ONE',
                  onPressed: () {
                    // Navigate to LoadingScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TicTacToeLoadingScreen(
                                nextPageDelay: 2, // Delay for 3 seconds
                                nextPageBuilder: () =>
                                    TicTacToe(OneVSone: true,),
                              )),
                    );
                  },
                ),
                SizedBox(height: 20),
                ModeButton(
                  label: "ONE Vs AI",
                  onPressed: () {
                    // Navigate to LoadingScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TicTacToeLoadingScreen(
                                nextPageDelay: 2, // Delay for 3 seconds
                                nextPageBuilder: () =>
                                    TicTacToe( OneVSone: false,),
                              )),
                    );
                  },
                ),
                SizedBox(height: 20),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget ModeButton({
  required String label,
  required VoidCallback onPressed,
}) {
  return Container(
    width: 200,
    height: 50,
    child: TextButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            Color.fromARGB(255, 23, 129, 216), // Button background color
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Button border radius
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(color: Colors.white,fontSize: 19),
          ),
        ],
      ),
    ),
  );
}
