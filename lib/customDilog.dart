import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String message;
  final String okButtonText;
  final String cancelButtonText;
  final Color backgroundColor;
  final IconData iconData;
  final VoidCallback? onOkPressed;
  final VoidCallback? onCancelPressed;

  CustomDialog({
    required this.title,
    required this.message,
    required this.okButtonText,
    required this.cancelButtonText,
    required this.backgroundColor,
    required this.iconData,
    this.onOkPressed,
    this.onCancelPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  top: 10.0,
                  bottom: 16.0,
                  left: 16.0,
                  right: 16.0,
                ),
                margin: EdgeInsets.only(top: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      offset: Offset(0.0, 10.0),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 40),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 24.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: onCancelPressed ??
                              () {
                                Navigator.of(context)
                                    .pop(); // To close the dialog
                              },
                          child: Text(
                            cancelButtonText,
                            style: TextStyle(
                              color: backgroundColor,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 16.0),
                        TextButton(
                          onPressed: onOkPressed ??
                              () {
                                Navigator.of(context)
                                    .pop(); // To close the dialog
                              },
                          child: Text(
                            okButtonText,
                            style: TextStyle(
                              color: backgroundColor,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Center(
              child: Column(
                children: [
                   SizedBox(height: 180,),
                  Positioned(
                    child: CircleAvatar(
                      backgroundColor: backgroundColor,
                      radius: 50.0,
                      child: Icon(
                        iconData,
                        color: Colors.white,
                        size: 60.0,
                      ),
                    ),
                  ),
                 
                ],
              ),
            ),
          
        ],
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Dialog'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => CustomDialog(
                title: "Congratulations!",
                message: "You Win!",
                okButtonText: "OK",
                cancelButtonText: "Cancel",
                backgroundColor: const Color.fromARGB(255, 104, 187, 255),
                iconData: Icons.emoji_emotions,
                onOkPressed: () {
                  // Handle OK button press here
                },
                onCancelPressed: () {
                  // Handle cancel button press here
                },
              ),
            );
          },
          child: Text('Show Win Dialog'),
        ),
      ),
    );
  }
}
