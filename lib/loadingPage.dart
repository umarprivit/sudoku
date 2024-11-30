// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class sudokuLoadingScreen extends StatelessWidget {
  final int
      nextPageDelay; // Delay in seconds before navigating to the next page
  final Widget Function() nextPageBuilder; // Builder function for the next page

  const sudokuLoadingScreen({
    Key? key,
    required this.nextPageDelay,
    required this.nextPageBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Schedule navigation to the next page after a delay
    Future.delayed(Duration(seconds: nextPageDelay), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => nextPageBuilder()),
      );
    });

    return Scaffold(
      body: Center(
        child: Container(
          width: 200,
          height: 250,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border:  Border.all(
                    color: Color.fromARGB(255, 232, 225, 252),
                    width: 2,
                  ),
                  
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  image: DecorationImage(
                    image: AssetImage("asserts/Images/sudokuLogo.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20),
              LinearProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(Colors.deepPurpleAccent),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
