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

  fectRating(String recordid) {
    try {
      var counter = 0.0;
      var ratingSize =0;
       _database.collection('Rating')
          .where("recordid",isEqualTo:recordid)
          .snapshots().map((event) {
            event.docs.map((e) {
              ratingSize = e.data().length;
             counter = counter + e.data()['rating'];

            });
      });

       return counter/ratingSize;
    }catch(e){
      print("Failed to find rating: $e");
    }
  }
  addRating(double rating,String artisteName, String recordid) async {
    try {
      final _email = _auth.currentUser!.email!;
      var ratingUser = _database.collection('Rating');

      await ratingUser.add({
         'rating':rating,
        'email':_email,
        'recordid':recordid,
        'artisteName':artisteName
      });
    }
    catch (e) {
      print("Failed to add commentaire: $e");
    }
  }
}