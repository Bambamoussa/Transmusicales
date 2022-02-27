import 'dart:collection';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';


class ArtisteProvider extends ChangeNotifier {
  FirebaseDatabase _database = FirebaseDatabase.instance;
  List<DatabaseEvent> _artistes = [];


  UnmodifiableListView<DatabaseEvent> get artistes => UnmodifiableListView(_artistes);


    fetchArtistes()  {
    try {
       return FirebaseFirestore.instance.collection('artiste').snapshots();
    }catch(e){
       print("Failed to add artiste: $e");
    }
  }

  Future<void>allData() async {

    DatabaseReference ref = _database.ref("fields");
    DatabaseEvent event = await ref.once();
    print(event.snapshot.value);
    artistes.add(event);
    notifyListeners();

  }


}