import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tp3/commentaires/commentaire.dart';
import 'package:tp3/home/home_screen.dart';
import 'package:tp3/player/player_page.dart';
import 'package:tp3/provider/artiste_provider.dart';
import 'package:tp3/provider/user_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ArtistesDetails extends StatefulWidget {
  static const String routeName = '/artiste';

  ArtistesDetails({Key? key}) : super(key: key);

  @override
  _ArtistesDetailsState createState() => _ArtistesDetailsState();
}

class _ArtistesDetailsState extends State<ArtistesDetails> {
  @override
  Widget build(BuildContext context) {
    final _artisteDetail = ModalRoute.of(context)!.settings.arguments as DocumentSnapshot;
    final String _artiste = _artisteDetail['fields']['artistes'];
    final String _salle = _artisteDetail['fields']['1ere_salle'];
    final String _origine = _artisteDetail['fields']['origine_pays1'];
    final String _recordid = _artisteDetail['recordid'];
    final String _date = _artisteDetail['fields']['1ere_date'];
    final String _url =  _artisteDetail['fields']['spotify'] !=null ? _artisteDetail['fields']['spotify'] : "google.com";
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text("TRANSMUSICAL"),
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              HeaderSection(
                artiste: _artiste,
                url: _url ,
              ),
              PlayListSection(date: _date, origine: _origine, salle: _salle, artiste: _artiste),
              SizedBox(height: 20.0,),
              Commentaire(recordid: _recordid,),
            ],
          ),
        ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  final String artiste;
  final String? url;

  HeaderSection({
    required this.artiste,
      this.url,
  });

  @override
  Widget build(BuildContext context) {
    void _launchLink() async {
      final url = "https://" + this.url!;
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw "Impossible de lancer le lien.";
      }
    }

    return Container(
      height: 500,
      decoration: BoxDecoration(
        color: Colors.red,
        image: DecorationImage(image: AssetImage('assets/fally.jpeg'), fit: BoxFit.cover),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50)),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 20,
            bottom: 30,
            child: Text(
              artiste,
              style: GoogleFonts.arizonia(
                  color: Colors.white, fontSize: 43, fontWeight: FontWeight.w800),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 20,
            child: MaterialButton(
              onPressed: () {
                _launchLink();
              },
              color: Colors.blue,
              shape: CircleBorder(),
              child: Padding(
                padding: EdgeInsets.all(17.0),
                child: Icon(
                  Icons.play_arrow_rounded,
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

class PlayListSection extends StatefulWidget {
  final String salle;
  final String date;
  final String origine;
  final String artiste;
  const PlayListSection(
      {Key? key,
      required this.salle,
      required this.date,
      required this.origine,
      required this.artiste})
      : super(key: key);
  @override
  _PlayListSectionState createState() => _PlayListSectionState();
}

class _PlayListSectionState extends State<PlayListSection> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    ArtisteProvider artisteProvider = Provider.of<ArtisteProvider>(context, listen: false);

    void addFavoris() {
      final email = userProvider.fetchUserEmail();
      artisteProvider.artisteFavoris(widget.artiste, email);
    }

    return Container(
      padding: EdgeInsets.fromLTRB(30, 40, 20, 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Bibliographie',
                style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.w500),
              ),
              Container(
                child: ElevatedButton(
                  onPressed: () {
                    artisteProvider.fetchArtisteName(widget.artiste);

                    if (ArtisteProvider.ajouterName == false) {
                      addFavoris();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('artiste ajouté'),
                          backgroundColor: Colors.green,
                           ));
                      ArtisteProvider.ajouterName = true;
                      Navigator.pop(context);

                    } else if (ArtisteProvider.ajouterName == true) {

                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("l'artiste a déja été ajouté"),
                          backgroundColor: Colors.red,
                           ));
                      ArtisteProvider.ajouterName = false;

                    }
                  },
                  style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(color: Colors.blue, fontSize: 20)),
                  child: const Text("Ajouter favoris"),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "origine",
                    style: TextStyle(color: Colors.blue, fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  Text(widget.origine),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "salle",
                    style: TextStyle(color: Colors.blue, fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  Text(widget.salle)
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("date",
                      style:
                          TextStyle(color: Colors.blue, fontSize: 15, fontWeight: FontWeight.w500)),
                  Text((widget.date))
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
