import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class CommentaireProvider extends ChangeNotifier{
  final FirebaseFirestore _database = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future commentaire(String recordid, String commentairemsg  ) async {
    try {
     final _username = _auth.currentUser!.displayName!;
      var commentaire = _database.collection('CommentaireUser');

      await commentaire.add({
        'recordid':recordid,
        'name':_username,
        'commentaire':commentairemsg
      });
    }
    catch (e) {
      print("Failed to add commentaire: $e");
    }
  }

  fectAllCommentaire(String recordid) {
    try {
      return _database.collection('CommentaireUser')
          .where("recordid",isEqualTo:recordid)
          .snapshots();
    }catch(e){
      print("Failed to find recordid: $e");
    }
  }
}