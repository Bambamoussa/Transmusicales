import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tp3/form/connexion.dart';
import 'package:tp3/form/inscription.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("TWISTIC"),
                backgroundColor: Colors.blueGrey,
      ),
      backgroundColor:  Colors.blueGrey,
      body: Container(
        alignment: Alignment.center,
        child:  Text("bienvenue")
      )
    );
  }
}
