import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      body: Center(child: new BookList()),
    );
  }
}

class BookList extends StatelessWidget {
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
                );
              }).toList(),
            );
        }
      },
    );
  }
}
