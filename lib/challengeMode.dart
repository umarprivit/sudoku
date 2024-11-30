import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sudoku/gameBoard.dart';
import 'package:sudoku/loadingPage.dart';

class ChallengeMode extends StatefulWidget {
  const ChallengeMode({Key? key}) : super(key: key);

  @override
  State<ChallengeMode> createState() => _ChallengeModeState();
}

class _ChallengeModeState extends State<ChallengeMode> {
  bool hint = true;
  String _difficulty = 'Easy';
  late int _minutes = 1;
  late int _seconds = 00;
  int totalSeconds = 0;
  int miss = 0;
  String? _secondsError;

  TextEditingController _minutesController = TextEditingController();
  TextEditingController _secondsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _minutesController.text = '$_minutes';
    _secondsController.text = '$_seconds';
  }

  void _setDifficulty() {
    if (_difficulty == "Easy") {
      miss = 30;
    } else if (_difficulty == "Medium") {
      miss = 40;
    } else if (_difficulty == "Hard") {
      miss = 50;
    }
  }

  void _setTime() {
    totalSeconds = (_minutes * 60) + _seconds;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Challenge '),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: SwitchListTile(
              title: const Text('Hints'),
              value: hint,
              onChanged: (value) {
                setState(() {
                  hint = !hint;
                });
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  'Select Difficulty:',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Radio<String>(
                            value: 'Easy',
                            groupValue: _difficulty,
                            onChanged: (value) {
                              setState(() {
                                _difficulty = value!;
                              });
                            }),
                        Text('Easy'),
                      ],
                    ),
                    Row(
                      children: [
                        Radio<String>(
                            value: 'Medium',
                            groupValue: _difficulty,
                            onChanged: (value) {
                              setState(() {
                                _difficulty = value!;
                              });
                            }),
                        Text('Medium'),
                      ],
                    ),
                    Row(
                      children: [
                        Radio<String>(
                            value: 'Hard',
                            groupValue: _difficulty,
                            onChanged: (value) {
                              setState(() {
                                _difficulty = value!;
                              });
                            }),
                        Text('Hard'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Container(
            padding: EdgeInsets.all(15.0),
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 244, 245, 247),
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Set Time:',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: _secondsError != null
                              ? Colors.red
                              : Colors
                                  .transparent, // Change border color based on error
                        ),
                        borderRadius:
                            BorderRadius.circular(5.0), // Add border radius
                      ),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              IconButton(
                                padding: EdgeInsets.all(0),
                                icon: Icon(Icons.arrow_drop_up),
                                onPressed: () {
                                  setState(() {
                                    if (_minutes == 60) {
                                    } else {
                                      _minutes++;
                                      _minutesController.text = '$_minutes';
                                    }
                                  });
                                },
                              ),
                              IconButton(
                                padding: EdgeInsets.all(0),
                                icon: Icon(Icons.arrow_drop_down),
                                onPressed: () {
                                  setState(() {
                                    if (_minutes > 0) {
                                      _minutes--;
                                      _minutesController.text = '$_minutes';
                                    }
                                  });
                                },
                              ),
                            ],
                          ),
                          SizedBox(width: 10.0),
                          Container(
                            width: 50.0,
                            child: TextFormField(
                              controller: _minutesController,
                              keyboardType: TextInputType.number,
                              maxLength: 2,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 18.0),
                              decoration: InputDecoration(
                                hintText: '00',
                                counterText: "",
                                border: OutlineInputBorder(),
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 8.0),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _minutes =
                                      (value == "") ? 0 : int.parse(value);
                                });
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                FilteringTextInputFormatter.deny(
                                    RegExp(r'^[6-9]')),
                              ],
                            ),
                          ),
                          Text(
                            ' : ',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            width: 50.0,
                            child: TextFormField(
                              controller: _secondsController,
                              keyboardType: TextInputType.number,
                              maxLength: 2,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 18.0),
                              decoration: InputDecoration(
                                hintText: '00',
                                counterText: "",
                                border: OutlineInputBorder(),
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 8.0),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _seconds =
                                      (value == "") ? 0 : int.parse(value);

                                  _secondsError = (totalSeconds > 59)
                                      ? null
                                      : 'Seconds should be less than 60';
                                });
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                FilteringTextInputFormatter.deny(
                                    RegExp(r'^[6-9]')),
                              ],
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Column(
                            children: [
                              IconButton(
                                icon: Icon(Icons.arrow_drop_up),
                                onPressed: () {
                                  setState(() {
                                    if (_seconds == 59) {
                                      _seconds = 0;
                                      _minutes++;
                                      _minutesController.text = '$_minutes';
                                    } else {
                                      _seconds++;
                                      _secondsController.text = '$_seconds';
                                    }
                                  });
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.arrow_drop_down),
                                onPressed: () {
                                  setState(() {
                                    if (_seconds > 0) {
                                      _seconds--;
                                      _secondsController.text = '$_seconds';
                                    }
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    (_secondsError != null) ? Text(_secondsError!) : Text("")
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Center(
            child: ElevatedButton(
              onPressed: () {
                _setDifficulty();
                _setTime();

                if (totalSeconds <= 59 || miss == 0) {
                  setState(() {
                    _secondsError = 'Seconds should be less than 60';
                  });
                } else {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => sudokuLoadingScreen(
                                nextPageDelay: 3, // Delay for 3 seconds
                                nextPageBuilder: () => gameBoard(
                                    hints: (hint) ? 3 : 0,
                                    miss: miss,
                                    seconds: totalSeconds),
                              )),
                    );
                  });
                }
              },
              child: Text(
                'Set Time & Difficulty',
                style: TextStyle(fontSize: 18.0),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
