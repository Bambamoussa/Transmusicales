
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp3/aristes/artiste_list.dart';
import 'package:tp3/form/connexion.dart';
import 'package:tp3/form/inscription.dart';
import 'package:tp3/model/Artiste.dart';
import 'package:tp3/provider/artiste_provider.dart';
import 'package:tp3/provider/user_provider.dart';
import 'package:tp3/widgets/drawer_view.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeState createState() {
    return _HomeState();
  }
  }
class _HomeState extends State<HomeScreen>{
  @override
  Widget build(BuildContext context) {
    final String _username = ModalRoute.of(context)!.settings.arguments as String  ;
      final _artiste = Provider.of<ArtisteProvider>(context);
      final  _listArtiste = _artiste.fetchAllArtistes();
    return Scaffold(
      appBar: AppBar(title: const Text("TRANSMUSICAL"),
                backgroundColor: Colors.blue,
      ),
      backgroundColor:  Colors.blueGrey,
      body: StreamBuilder(
        stream: _listArtiste,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final _artiste = snapshot.data!.docs.map((data) => data ).toList();
          return  ArtisteListe(artisteList: _artiste);
        },
      ),
      drawer:DrawerView(username:_username),
    );
  }


}
