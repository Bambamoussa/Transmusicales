import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';

class Artiste {
  String datasetid;
  String recordid;
  Map<String,dynamic> fields;
  Map <String,dynamic>? geometry;
  DateTime record_timestamp;
  Artiste({required this.datasetid, required this.recordid, required this.fields, this.geometry , required this.record_timestamp});

  /*Artiste.fromJson(QueryDocumentSnapshot  <Map<String,dynamic>> json):
        datasetid = json.data()!['datasetid'] as String,
        recordid = json.data()!['recordid'] as String,
        fields = json.data()!['fields'] as Map<String,dynamic>,
        geometry = json.data()!['geometry'] as Map<String,dynamic>,
        record_timestamp =json.data()!['record_timestamp'] as DateTime;
*/

}