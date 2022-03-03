import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tp3/home/home_screen.dart';
import 'package:tp3/player/player_page.dart';


class ArtistesDetails extends StatelessWidget {
  static const String routeName = '/artiste';
    ArtistesDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _artisteDetail = ModalRoute.of(context)!.settings.arguments as DocumentSnapshot;
    final  String _artiste =_artisteDetail['fields']['artistes'];
    final  String _salle =_artisteDetail['fields']['1ere_salle'];
    final  String _origine =_artisteDetail['fields']['origine_pays1'];
    final  String _date =_artisteDetail['fields']['1ere_date'];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: const Text("TRANSMUSICAL"),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onPressed: null,
          ),
        ],
      ),
      body:   SingleChildScrollView(
         child: Column(
           children: [
             HeaderSection(artiste:_artiste),
             PlayListSection(date: _date, origine: _origine,salle: _salle),

           ],
         ),
      )
    );
  }
}
class HeaderSection extends StatelessWidget {
  final String  artiste;

   HeaderSection({required this.artiste  }) ;

  @override
  Widget build(BuildContext context) {
    return Container(
           height: 500,
           decoration: BoxDecoration(
             color: Colors.red,
             image: DecorationImage(image: AssetImage('assets/fally.jpeg'),
             fit: BoxFit.cover
             ),
             borderRadius: BorderRadius.only(
               bottomLeft: Radius.circular(50)
             ),
           ),
            child: Stack(
              children: [
                Positioned(
                  left: 20,
                  bottom: 30,
                    child: Text(artiste,
                      style: GoogleFonts.arizonia(
                        color: Colors.white,
                        fontSize: 43,
                        fontWeight: FontWeight.w800
                      ),
                    ),
                ),
                Positioned(
                  right: 0,
                    bottom: 20,
                    child: MaterialButton(
                  onPressed: ( ){
                    Navigator.pushNamed(context,  Player.routeName);
                  },
                  color: Colors.blue,
                   shape: CircleBorder(),
                  child: Padding(
                    padding: EdgeInsets.all(17.0),
                    child: Icon(Icons.play_arrow_rounded,
                    color: Colors.white,
                      size: 30,
                    ),
                  ),
                      ),
                  )
              ],
            ),
    );
  }
}
class PlayListSection extends StatelessWidget {
  final String salle;
  final String date;
  final String origine;
  const PlayListSection({Key? key, required this.salle, required this.date, required this.origine}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
       padding: EdgeInsets.fromLTRB(30, 40, 20, 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Bibliographie',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.w500
              ),
              ),
              Container(
                child: ElevatedButton(
                   onPressed:  (){},
                    style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(color :Colors.blue, fontSize: 20)),
                    child: const Text("Ajouter favoris"),
                  ),
              )

            ],
          ),
          SizedBox(height: 20,),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text("origine",style: TextStyle(
                    color: Colors.blue,
                    fontSize: 15,
                    fontWeight: FontWeight.w500
                ),),
                  Text(origine),
              ],),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text("salle",style: TextStyle(
                    color: Colors.blue,
                    fontSize: 15,
                    fontWeight: FontWeight.w500
                ),
                ),
                  Text(salle)
              ],),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text("date", style: TextStyle(
                    color: Colors.blue,
                    fontSize: 15,
                    fontWeight: FontWeight.w500
                )),
                  Text((date))
              ],)
            ],
          )
        ],
      ),

    );
  }
}


