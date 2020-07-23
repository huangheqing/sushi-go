import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'sushi_go_basic_menu_game.dart';
import 'objects/game.dart';

class Room extends StatelessWidget {
  Game game;
  String userName;
  bool isOwner;

  Room(Game _game, String _userName) {
    game = _game;
    userName = _userName;
    isOwner = _game.owner == _userName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to game: ' + game.roomName),
      ),
      body: Center(
          // if isOwner is true, then this user is the host of this room,
          // He has the start game button appeared
          // Other user does not have the start button but they have the ready button
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(height: 30),
          RaisedButton(
            onPressed: () {
              // Start game or state ready
              Firestore.instance
                  .collection('sushi-go')
                  .document(game.documentID)
                  .updateData({'in_game': true});
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BasicMenuGame(game, userName)),
              );
            },
            child: Text(isOwner ? 'Start game' : 'Ready',
                style: TextStyle(fontSize: 20)),
          ),
          const SizedBox(height: 30),
        ],
      )),
    );
  }
}
