import 'dart:collection';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';


class ArtisteProvider extends ChangeNotifier {
  final FirebaseFirestore _database = FirebaseFirestore.instance;
  List<DatabaseEvent> _artistes = [];


  UnmodifiableListView<DatabaseEvent> get artistes => UnmodifiableListView(_artistes);


    fetchAllArtistes()  {
    try {
       return _database.collection('artiste').snapshots();
    }catch(e){
       print("Failed to add artiste: $e");
    }
  }

  fetchArtiste(String search ) async{
     try {
       var _result = await _database
           .collection("artiste")
           .where("annee", isEqualTo: search)
           .snapshots().toList();
        return _result;
     } catch(e){
       print("Failed to add artiste: $e");
     }
  }

  Future<void>allData() async {


  }


}