import 'dart:collection';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';


class ArtisteProvider extends ChangeNotifier {
  final FirebaseFirestore _database = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<DatabaseEvent> _artistes = [];
   static  bool ajouterName = false;
  static  bool ajouterEmail = false;


  UnmodifiableListView<DatabaseEvent> get artistes => UnmodifiableListView(_artistes);


    fetchAllArtistes()  {
    try {
       return _database.collection('artiste').snapshots();
    }catch(e){
       print("Failed to add artiste: $e");
    }
  }

  fetchUserEmail(){
    final _email = _auth.currentUser!.email!;
    return _email;
  }
  fetchAllArtistesFavoris()  {
    try {

      var mail = fetchUserEmail();
      return _database.collection('ArtisteFavoris')
          .where("email",isEqualTo:mail)
          .snapshots();
    }catch(e){
      print("Failed to add artiste: $e");
    }
  }

  Future artisteFavoris(String artisteName,String? email) async {
    try {
      CollectionReference users = _database.collection('ArtisteFavoris');
      await users.add({
        'email': email,
        'artisteName': artisteName
      });
    }
    catch (e) {
      print("Failed to add artisteFavoris: $e");
    }
  }
   fetchArtisteName (String name )  async {
    try {
       var email = fetchUserEmail();
      var _result = await  _database
          .collection("ArtisteFavoris")
          .where("artisteName", isEqualTo: name)
          .where("email", isEqualTo: email)
          .get();

       if(_result.docs.first.exists) {
          ajouterName = true;
       }
       else{
         ajouterName = false;
       }
    } catch (e) {
      print("Failed to find artiste: $e");
    }
  }


}