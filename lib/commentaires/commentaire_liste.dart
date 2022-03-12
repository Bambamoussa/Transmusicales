import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp3/provider/commentaire_provider.dart';

class CommentaireListe extends StatelessWidget {
  static const String routeName = '/commentaireList';
  const CommentaireListe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String _recordid= ModalRoute.of(context)!.settings.arguments as String  ;
    final _commentaire = Provider.of<CommentaireProvider>(context);
    final _listeCommentaire= _commentaire.fectAllCommentaire(_recordid);
    return Scaffold(
        appBar: AppBar(title: const Text("TRANSMUSICAL"),
          backgroundColor: Colors.blue,
        ),
        backgroundColor:  Colors.blueGrey,
        body: StreamBuilder(
          stream: _listeCommentaire,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final _listeCommentaire = snapshot.data!.docs.map((data) => data ).toList();
            return  Container(
              child:ListView.builder(
                  itemCount: _listeCommentaire.length,
                  itemBuilder: (context,index){
                    var _Commentaire = _listeCommentaire[index];
                    return Card(
                      child :ListTile(
                        leading: const CircleAvatar(child: Icon(Icons.person)),
                        title: Text(_Commentaire["name"], style: Theme.of(context).textTheme.bodyText1,),
                        subtitle:_Commentaire["commentaire"] != null? Text(_Commentaire["commentaire"] ):const Text("inconnu"),
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
