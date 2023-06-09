import 'dart:io';

import 'package:flutter/material.dart';
import 'package:quran_test/Screens/ChallengeEntryScreen.dart';
import 'package:quran_test/Screens/QaryDataEntry.dart';
import 'package:sqflite/sqflite.dart';

import 'DegreeTable.dart';

class startUpScreen extends StatelessWidget {
  const startUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('Start Up Screen'),

            //SizedBox(height: 10),
            OutlinedButton(
                onPressed: () async {
                await deleteDB();
                },
                child: Text('مسح قاعدة البيانات')),
           // SizedBox(height: 10),
            OutlinedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => challengeEntryScreen()));
                },
                child: Text('جدول المسابقات'))
            ,
            //SizedBox(height: 10),
            OutlinedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => DegreeTable()));
                },
                child: Text('تعديل جدول خصم الدرجات'))
            // OutlinedButton(
            //     onPressed: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (BuildContext context) => qaryDataEntry()));
            //     },
            //     child: Text('بيانات الطلاب'))
          ],
        ),
      ),
    );
  }

  Future<void> deleteDB() async {
    var databasesPath = await getDatabasesPath();
    var dbFilePath = '$databasesPath/qary_dbase.db';
    var dbExists = File(dbFilePath).existsSync();
    if (dbExists == true) {
      print('found and deleted database');
        await deleteDatabase(dbFilePath);
    }
}}
