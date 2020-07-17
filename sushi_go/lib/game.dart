import 'package:flutter/material.dart';

class Game extends StatelessWidget {
  String user_name;

  Game(String name) {
    //If there is a block of code.
    // Constructor body
    user_name = name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Sushi go' + user_name),
      ),
      body: Center(),
    );
  }
}
