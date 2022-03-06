import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp3/provider/artiste_provider.dart';

class ListeFavoris extends StatelessWidget {
  static String routeName = "/listeFavoris";
  const ListeFavoris({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _artisteFavoris = Provider.of<ArtisteProvider>(context);
    final _listeFavoris = _artisteFavoris.fetchAllArtistesFavoris();
    return Scaffold(
      appBar: AppBar(title: const Text("TRANSMUSICAL"),
        backgroundColor: Colors.blue,
      ),
      backgroundColor:  Colors.blueGrey,
      body: StreamBuilder(
        stream: _listeFavoris,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final _artisteFavoris = snapshot.data!.docs.map((data) => data ).toList();
          return  Container(
            child:ListView.builder(
                itemCount: _artisteFavoris.length,
                itemBuilder: (context,index){
                  var _artiste = _artisteFavoris[index];
                  return Card(
                    child :ListTile(
                      leading: const CircleAvatar(child: Icon(Icons.person)),
                      title: Text(_artiste["artisteName"], style: Theme.of(context).textTheme.bodyText1,),
                      subtitle:_artiste["artisteName"] != null? Text(_artiste["artisteName"] ):const Text("inconnu"),
                    ),
                  );
                }
            ),
          );
        },
      )

    );
  }
  }
