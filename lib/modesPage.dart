// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sudoku/challengeMode.dart';
import 'package:sudoku/gameBoard.dart';
import 'package:sudoku/loadingPage.dart';

class ModesPage extends StatefulWidget {
  @override
  _ModesPageState createState() => _ModesPageState();
}

class _ModesPageState extends State<ModesPage> {
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
            //   gradient: LinearGradient(
            //     begin: Alignment.topLeft,
            //     end: Alignment.bottomRight,
            //     colors: [
            //       const Color.fromARGB(255, 255, 255, 255),
            //       const Color.fromARGB(255, 54, 144, 189)
            //     ], // Change gradient colors as needed
            //   ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ModeButton(
                  label: 'Easy',
                  onPressed: () {
                    // Navigate to LoadingScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => sudokuLoadingScreen(
                                nextPageDelay: 2, // Delay for 3 seconds
                                nextPageBuilder: () =>
                                    gameBoard(hints: 3, miss: 30, seconds: 1),
                              )),
                    );
                  },
                ),
                SizedBox(height: 20),
                ModeButton(
                  label: 'Medium',
                  onPressed: () {
                    // Navigate to LoadingScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => sudokuLoadingScreen(
                                nextPageDelay: 2, // Delay for 3 seconds
                                nextPageBuilder: () =>
                                    gameBoard(hints: 3, miss: 40, seconds: 1),
                              )),
                    );
                  },
                ),
                SizedBox(height: 20),
                ModeButton(
                  label: 'Hard',
                  onPressed: () {
                    // Navigate to LoadingScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => sudokuLoadingScreen(
                                nextPageDelay: 2, // Delay for 3 seconds
                                nextPageBuilder: () =>
                                    gameBoard(hints: 3, miss: 50, seconds: 1),
                              )),
                    );
                  },
                ),
                SizedBox(height: 20),
                ModeButton(
                  label: 'Challenge Mode',
                  onPressed: () {
                    // Navigate directly to ChallengeMode
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ChallengeMode()));
                  },
                ),
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
