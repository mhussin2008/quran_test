import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class QaryExam extends StatefulWidget {
  const QaryExam({Key? key, required this.qaryName}) : super(key: key);
  final String qaryName;

  @override
  State<QaryExam> createState() => _QaryExamState();
}

class _QaryExamState extends State<QaryExam> {
  int mark = 100;
  List<int> faultValue=[2, 2, 2, 2, 2];
  @override
  Widget build(BuildContext context) {


    TextEditingController markController=TextEditingController();
    markController.text=mark.toString();
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('إختبار')),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 100,
                      child: TextField(
                        controller: markController,
                        style: const TextStyle(
                          fontSize: 40
                        ),

                      ),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    Text(widget.qaryName,
                      style: const TextStyle(
                          fontSize: 40
                      ),)
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OutlinedButton(
                      onPressed: () {
                        decreaseMark(faultValue[0]);
                      },
                      style: ElevatedButton.styleFrom(

                        padding: const EdgeInsets.all(20),
                        backgroundColor: Colors.blue, // <-- Button color
                        foregroundColor: Colors.black, // <-- Splash color
                      ),
                      child: const Text('صحح له المعلم'
                      ,style: TextStyle(fontSize: 20),)),
                  const SizedBox(width: 10,),
                  OutlinedButton(
                      onPressed: () {
                        decreaseMark(faultValue[1]);
                      },
                      style: ElevatedButton.styleFrom(

                        padding: const EdgeInsets.all(20),
                        backgroundColor: Colors.blue, // <-- Button color
                        foregroundColor: Colors.black, // <-- Splash color
                      ),
                      child: const Text('صحح بنفسه'
                        ,style: TextStyle(fontSize: 20),)),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OutlinedButton(
                      onPressed: () {
                        decreaseMark(faultValue[2]);
                      },
                      style: ElevatedButton.styleFrom(

                        padding: const EdgeInsets.all(20),
                        backgroundColor: Colors.blue, // <-- Button color
                        foregroundColor: Colors.black, // <-- Splash color
                      ),
                      child: const Text('التردد'
                        ,style: TextStyle(fontSize: 20),)),
                  const SizedBox(width: 10,),
                  OutlinedButton(
                      onPressed: () {
                        decreaseMark(faultValue[3]);
                      },
                      style: ElevatedButton.styleFrom(

                        padding: const EdgeInsets.all(20),
                        backgroundColor: Colors.blue, // <-- Button color
                        foregroundColor: Colors.black, // <-- Splash color
                      ),
                      child: const Text('خطأ التجويد'
                        ,style: TextStyle(fontSize: 20),)),
                ],
              ),
              const SizedBox(height: 10,),
              OutlinedButton(
                  onPressed: () {
                    decreaseMark(faultValue[4]);
                  },
                  style: ElevatedButton.styleFrom(

                    padding: const EdgeInsets.all(20),
                    backgroundColor: Colors.blue, // <-- Button color
                    foregroundColor: Colors.black, // <-- Splash color
                  ),
                  child: const Text('خطأ الوقف والإبتداء'
                    ,style: TextStyle(fontSize: 20),)),
            const SizedBox(height: 20,)

            ,Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [ OutlinedButton(
                    onPressed: () async {
                      if(await CheckDbase()=='Ok'){
                        updateDb(int.parse(markController.text));
                      }

                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                       padding: const EdgeInsets.all(20),
                      backgroundColor: Colors.limeAccent, // <-- Button color
                      foregroundColor: Colors.black, // <-- Splash color
                    ),
                    child: const Text('حفظ الدرجة والعودة'
                      ,style: TextStyle(fontSize: 20),)),],),
            )
            ],
          ),
        ),
      ),
    );
  }

  void decreaseMark(int fValue) {
    setState(() {
      mark=mark-fValue;
    });
  }

  Future<String> CheckDbase() async {

    var databasesPath = await getDatabasesPath();
    var dbFilePath = '$databasesPath/qary_dbase.db';
    var dbExists = File(dbFilePath).existsSync();
    if (dbExists == false) {
      print('no such database');

    } else {

    }
    late Database db;
    db = await openDatabase('qary_dbase.db');
    if (db.isOpen == false) {
      print('cant open database');
      return 'No';
    }
    var tables = await db
        .rawQuery('SELECT * FROM sqlite_master WHERE name="testtable";');

    if (tables.isEmpty) {
      // Create the table
      print('no such table');
      try {
        await db.execute('''
        create table testtable (
        testname TEXT NOT NULL UNIQUE ,
        testdate TEXT 
       )''');
      } catch (err) {
        if (err.toString().contains('DatabaseException') == true) {
          print(err.toString());
          return 'No';
        }
        //print(err.toString().substring(0,30));
      }
    }
    return 'Ok';
  }

  Future<void> updateDb(int newdegree)
  async {
    var db = await openDatabase('qary_dbase.db');


    int updateCount = await db.rawUpdate('''
    UPDATE datatable 
    SET  degree = ? 
    WHERE qaryname = ?
    ''',
        [newdegree,widget.qaryName]);

    print(updateCount.toString());
  }



}
