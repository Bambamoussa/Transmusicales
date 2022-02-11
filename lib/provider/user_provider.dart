import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:tp3/auth_firebase.dart';
import 'package:tp3/model/user.dart';

class UserProvider extends ChangeNotifier {

  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future signInWithEmailAndPassword(String email, String password ) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return result.user;
    }  on FirebaseAuthException  catch(e) {
       if(e.code == "user-not-found") {
         print("No user found for that email");
       }
      else if(e.code == "wrong-password"){
        print("wrong password provided for that user");
       }
    }
  }

  Future   registerWithEmailAndPassword(String email, String password, String username) async {
    try {
      final  result =
      await _auth.createUserWithEmailAndPassword(email: email,password: password);
      result.user?.updateDisplayName(username);
      return result.user;
    } on FirebaseAuthException  catch(e) {
      if(e.code == "weak-password") {
        print("The password provided is too weak");
      }
      else if(e.code == "email-already-in-use"){
        print("the account already existe for that email");
      }
    }
  }

  Future createUser(String username, String email, String password) async {
    try {
      CollectionReference users = FirebaseFirestore.instance.collection('Users');
      await  users.add({
        'username': username,
        ' email':email,
       'password':password
      });

    notifyListeners();
    }catch(e){
      return print("Failed to add user: $e");
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }
  /*AuthFirebase auth = AuthFirebase.disconnected;
  String? email;

  //Crea
  UserProvider() {
    init();
  }

  Future<void>init() async {
    //Init app
    await Firebase.initializeApp();
    //Ecoute auth
    FirebaseAuth.instance.userChanges().listen((newUser) {
      auth = (newUser == null) ? AuthFirebase.disconnected : AuthFirebase.connected;
      notifyListeners();
    });
  }

//StartFlow
  start() {
    auth = AuthFirebase.mail;
    notifyListeners();
  }
//CheckMail
  checkMail(String email, void Function(FirebaseAuthException authException) errorCallback) async {
    try {
      final allMethods =  await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (allMethods.contains('password')) {
        auth = AuthFirebase.signIn;
      } else {
        auth = AuthFirebase.createAccount;
      }
      this.email = email;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }
//SignIn
  Future  signIn(String email, String password) async {
    try {
      UserCredential result =await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

    }   catch (e) {
       rethrow;
    }
  }
//CreateAccount
  createAccount(String mail, String password, String username, void Function(FirebaseAuthException authException) errorCallback) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: mail, password: password);
      await credential.user!.updateDisplayName(username);
      //Ajoutera plus tard sur Cloud l'user
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }
//Disconnect
  logOut() {
    FirebaseAuth.instance.signOut();
  }
//Cancel
  cancel() {
    if (auth == AuthFirebase.mail) {
      auth = AuthFirebase.disconnected;
    } else {
      auth = AuthFirebase.mail;
    }
    notifyListeners();
  }*/
}