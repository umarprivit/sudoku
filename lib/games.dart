// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sudoku/TicTacToe.dart';
import 'package:sudoku/TicTacToeModes.dart';
import 'package:sudoku/TicTactoeLoadingScreen.dart';
import 'package:sudoku/loadingPage.dart';
import 'package:sudoku/modesPage.dart';



class games extends StatefulWidget {
  const games({super.key});

  @override
  State<games> createState() => _gamesState();
}


class _gamesState extends State<games> {
  List<Map<String, String>> gamelist = [
    {
      "name": "Sudoku",
      "image": "asserts/Images/sudokuLogo.png",
    },
    {
      "name": "TicTac",
      "image": "asserts/Images/tictactoLogo.png",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: gamelist.length,
          itemBuilder: (BuildContext context, int index) {
            final game = gamelist[index];
            return GestureDetector(
              onTap: () {
               if(game["name"] == "Sudoku"){
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => sudokuLoadingScreen(
                    nextPageDelay: 1, // Delay for 3 seconds
                    nextPageBuilder: () => ModesPage(),
                  )),
                );
               }else{
                 Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TicTacToeLoadingScreen(
                                nextPageDelay: 2, // Delay for 3 seconds
                                nextPageBuilder: () =>
                                    TicTacToeModes(),
                              )),
                    );
               }
              },
              child: Container(
                child: Column(
                  children: [
                    SizedBox(height: 90),
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Color.fromARGB(255, 255, 255, 255),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Image.asset(
                        game['image'] ?? "",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
