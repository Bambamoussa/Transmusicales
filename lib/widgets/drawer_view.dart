import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp3/aristes/listeFavoris.dart';
import 'package:tp3/form/connexion.dart';
import 'package:tp3/provider/user_provider.dart';

class DrawerView extends StatelessWidget {
  final String username;
  const DrawerView({Key? key,  required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context,listen: false);
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: const Text(
              'Transmusical',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColor.withOpacity(0.5),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          ListTile(
            leading: const CircleAvatar(
              child:  Icon(Icons.person),
            ),
            title: Text(username, style: const TextStyle(color: Colors.blue, fontSize: 20)),
          ),
          ListTile(
            leading: Icon(Icons.person_add_disabled),
            title: const Text('deconnecter',style: TextStyle(fontSize: 20)),
            onTap: () {
              userProvider.signOut();
              Navigator.pushNamed(context, Connexion.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.person_add_disabled),
            title: const Text('favoris',style: TextStyle(fontSize: 20)),
            onTap: () {
              Navigator.pushNamed(context, ListeFavoris.routeName);
            },
          ),
        ],
      ),
    );
  }
}
