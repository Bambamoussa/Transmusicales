import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';

class Artiste {
  String datasetid;
  String recordid;
  Map<String,dynamic> fields;
  Map <String,dynamic>? geometry;
  DateTime record_timestamp;
  Artiste({required this.datasetid, required this.recordid, required this.fields, this.geometry , required this.record_timestamp});

  Artiste.fromJson(Map<String,dynamic> json):
        datasetid = json['datasetid'] as String,
        recordid = json['recordid'] as String,
        fields = json['fields'] as Map<String,dynamic>,
        geometry = json['geometry'] as Map<String,dynamic>,
        record_timestamp =json['record_timestamp'] as DateTime;


}