import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sushi_go/room.dart';
import 'objects/game.dart';

class GameLobby extends StatelessWidget {
  String userName;

  GameLobby(String name) {
    //If there is a block of code.
    // Constructor body
    userName = name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Sushi go' + userName),
      ),
      body: Center(child: new BookList(userName)),
    );
  }
}

class BookList extends StatelessWidget {
  String userName;

  BookList(String _userName) {
    userName = _userName;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('sushi-go').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Text('Loading...');
          default:
            return new ListView(
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return new ListTile(
                  title: new Text(document['room_name']),
                  subtitle: new Text(document['owner']),
                  onTap: () {
                    /*Join the room*/
                    Firestore.instance
                        .collection('sushi-go')
                        .document(document.documentID)
                        .updateData({
                      'players': FieldValue.arrayUnion([userName])
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Room(Game.fromSnapshot(document), userName)),
                    );
                  },
                );
              }).toList(),
            );
        }
      },
    );
  }
}
