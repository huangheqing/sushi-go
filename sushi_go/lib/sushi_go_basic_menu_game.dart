import 'dart:async';

import 'package:flutter/material.dart';
import 'objects/game.dart';

class BasicMenuGame extends StatelessWidget {
  Game game;
  String userName;
  bool isOwner;

  BasicMenuGame(Game _game, String _userName) {
    game = _game;
    userName = _userName;
    isOwner = _game.owner == _userName;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basic Menu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _BasicMenuGame(),
    );
  }
}

class _BasicMenuGame extends StatefulWidget {
  @override
  _BasicMenuGameState createState() => _BasicMenuGameState();
}

class _BasicMenuGameState extends State<_BasicMenuGame> {
  List<String> gridViewTiles = new List<String>();
  List<String> questionPairs = new List<String>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reStart();
  }

  void reStart() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: <Widget>[
        GridView.count(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 9,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8),
              child: const Text("He'd have you all unravel at the"),
              color: Colors.teal[100],
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: const Text('Heed not the rabble'),
              color: Colors.teal[200],
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: const Text('Sound of screams but the'),
              color: Colors.teal[300],
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: const Text('Who scream'),
              color: Colors.teal[400],
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: const Text('Revolution is coming...'),
              color: Colors.teal[500],
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: const Text('Revolution, they...'),
              color: Colors.teal[600],
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child:
                  Text('Deliver features faster', textAlign: TextAlign.center),
            ),
            Expanded(
              child: Text('Craft beautiful UIs', textAlign: TextAlign.center),
            ),
          ],
        )
      ]),
    );
  }
}
