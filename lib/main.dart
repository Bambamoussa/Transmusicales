import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp3/aristes/artiste_details.dart';
import 'package:tp3/form/inscription.dart';
import 'package:tp3/model/Artiste.dart';
import 'package:tp3/player/player_page.dart';
import 'package:tp3/provider/artiste_provider.dart';
import 'package:tp3/provider/user_provider.dart';

import 'form/connexion.dart';
import 'home/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Twistic());
}

class Twistic extends StatefulWidget {
  const Twistic({Key? key}) : super(key: key);

  @override
  _TwisticState createState() => _TwisticState();
}
  class _TwisticState extends State<Twistic> {
  final UserProvider userProvider = UserProvider();
  final ArtisteProvider artisteProvider = ArtisteProvider();

  @override
  void initState() {
  super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
        providers:  [
        ChangeNotifierProvider.value(value: userProvider),
          ChangeNotifierProvider.value(value: artisteProvider),
      ],
      child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/':(_)=>  Connexion(),
          HomeScreen.routeName: (_) => HomeScreen(),
          //Connexion.routeName:(_)=>  Connexion(),
          Inscription.routeName :(_)=> Inscription(),
          ArtistesDetails.routeName:(_)=>  ArtistesDetails(),
          Player.routeName:(_)=> Player()
        },

      ),
    );
  }
}


