import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'artiste_details.dart';


class ArtisteListe extends StatelessWidget {
  final List  artisteList;
  const ArtisteListe({Key? key, required this.artisteList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child:ListView.builder(
          itemCount: artisteList.length,
          itemBuilder: (context,index){
            var _artiste = artisteList[index];
            return Card(
              child :ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person)),
              title: Text(_artiste["fields"]["artistes"], style: Theme.of(context).textTheme.bodyText1,),
              subtitle:_artiste["fields"]["edition"] != null? Text(_artiste["fields"]["edition"]):const Text("inconnu"),
              onTap:() => Navigator.pushNamed(context, ArtistesDetails.routeName , arguments: _artiste),
            ),
            );
          }
      ),
    );
  }
}
