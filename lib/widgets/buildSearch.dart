import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tp3/aristes/search_artiste.dart';
import 'package:tp3/provider/artiste_provider.dart';

 class SearchPage extends StatefulWidget {
   const SearchPage({Key? key}) : super(key: key);
 
   @override
   _SearchPageState createState() => _SearchPageState();
 }
 
 class _SearchPageState extends State<SearchPage> {

   List artiste = [];
   String query = '';
   Timer? debouncer;

   @override
   void initState() {
     super.initState();
   }

   @override
   void dispose() {
     debouncer?.cancel();
     super.dispose();
   }

   void debounce(VoidCallback callback, {
     Duration duration = const Duration(milliseconds: 1000),
   }) {
     if (debouncer != null) {
       debouncer!.cancel();
     }

     debouncer = Timer(duration, callback);
   }

   @override
   Widget build(BuildContext context) {
     ArtisteProvider artisteProvider =
     Provider.of<ArtisteProvider>(context, listen: false);
     Future searchBook(String query) async =>
         debounce(() async {
           final artistes = await artisteProvider.searchArtiste (query);

           if (!mounted) return;

           setState(() {
             this.query = query;
             this.artiste = artistes;
           });
         });
     Widget buildSearch() =>
         SearchWidget(
           text: query,
           hintText: 'chercher un artiste',
           onChanged: searchBook,
         );
   return buildSearch();
   }

   }
 


