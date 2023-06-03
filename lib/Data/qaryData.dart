// To parse this JSON data, do
//
//     final qaryData = qaryDataFromJson(jsonString);

import 'dart:convert';

List<QaryData> qaryDataFromJson(String str) => List<QaryData>.from(json.decode(str).map((x) => QaryData.fromJson(x)));

String qaryDataToJson(List<QaryData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QaryData {
  final String qaryName;
  final int qaryAge;
  QaryData(this.qaryName, this.qaryAge);

  factory QaryData.fromJson(Map<String, dynamic> json) => QaryData(json['qaryName'],json['qaryAge']);
  factory QaryData.fromFields(String name,int age)=>QaryData(name, age);

  Map<String, dynamic> toJson() => {
  };

  @override
  String toString(){return 'Qary Name is ${qaryName} and his age is ${qaryAge}';}



 }

List<QaryData> QaryList=[];