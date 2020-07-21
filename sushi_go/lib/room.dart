import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'objects/game.dart';

class Room extends StatelessWidget {
  Game game;
  String userName;

  Room(Game _game, String _userName) {
    game = _game;
    userName = _userName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to game: ' + game.roomName),
      ),
      body: Center(),
    );
  }
}
