import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sushi_go/room.dart';
import 'objects/game.dart';
import 'package:uuid/uuid.dart';

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
        title: Text('Welcome to the Lobby :' + userName),
      ),
      body: Center(child: new BookList(userName)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          TextEditingController _textFieldController = TextEditingController();
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Create new room'),
                  content: TextField(
                    controller: _textFieldController,
                    decoration:
                        InputDecoration(hintText: "Type your room name here"),
                  ),
                  actions: <Widget>[
                    new FlatButton(
                      child: new Text('CANCEL'),
                      onPressed: () {
                        _textFieldController.clear();
                        Navigator.pop(context);
                      },
                    ),
                    new FlatButton(
                        child: new Text('CREATE'),
                        onPressed: () {
                          var uuid = new Uuid();
                          // Create a new game room
                          String uuidStr = uuid.v1();
                          Firestore.instance
                              .collection('sushi-go')
                              .document(uuidStr)
                              .setData({
                            'room_name': _textFieldController.text,
                            'owner': userName,
                            'players': [userName],
                            'in_game': false
                          }).whenComplete(() => {
                                    Navigator.pop(context),
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Room(
                                              new Game(
                                                  uuidStr,
                                                  _textFieldController.text,
                                                  userName,
                                                  false,
                                                  [userName]),
                                              userName)),
                                    )
                                  });
                        })
                  ],
                );
              });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
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
                    joinARoom(document, context, userName);
                  },
                );
              }).toList(),
            );
        }
      },
    );
  }
}

void joinARoom(
    DocumentSnapshot document, BuildContext context, String userName) {
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
        builder: (context) => Room(Game.fromSnapshot(document), userName)),
  );
}
