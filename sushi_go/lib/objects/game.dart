import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'round.dart';

class Game {
  // Header members
  String documentID;
  String roomName;
  String owner;
  bool isInGame;
  List<String> players = new List<String>();
  List<Round> rounds = new List<Round>();

  Game(String id, String _roomName, String ownerName, bool inGame,
      List<String> playersList) {
    documentID = id;
    roomName = _roomName;
    owner = ownerName;
    isInGame = inGame;
    players = playersList;
  }

  Game.fromSnapshot(DocumentSnapshot snapshot)
      : documentID = snapshot.documentID,
        roomName = snapshot['room_name'],
        owner = snapshot['owner'],
        isInGame = snapshot['in_game'],
        players = List.from(snapshot['players']);
}
