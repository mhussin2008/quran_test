import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../Data/DegreeData.dart';

class QaryExam extends StatefulWidget {


  const QaryExam({Key? key, required this.qaryName, required this.degree,required this.testName}) : super(key: key);
  final String qaryName;
  final int degree;
  final String testName;

  @override
  State<QaryExam> createState() => _QaryExamState();
}

class _QaryExamState extends State<QaryExam> {
  int mark=0 ;
  TextEditingController markController=TextEditingController();
  List<int> faultValue=DegreeData.degreeTable??[2,2,2,2,2];

  var theSelected=[true,false,false,false];

  @override
  void initState()  {
    // TODO: implement initState
    mark=widget.degree;

    // CheckDbase().then((value) =>
    // {
    //   if (value=='Ok'){
    //     GetDegree().then((retVal) => {
    //       mark=retVal,
    //       print('here $retVal')
    //
    //     })
    //   }
    // }
    // );
    super.initState();




  }

  @override
  Widget build(BuildContext context) {



    markController.text=mark.toString();
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('إختبار')),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(

            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/jpg/back.jpg' ),fit: BoxFit.cover
                )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: 10,),
                ToggleButtons(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    selectedBorderColor: Colors.red[700],
                    selectedColor: Colors.white,
                    fillColor: Colors.red[200],
                    color: Colors.pink[900],
                    constraints: const BoxConstraints(
                      minHeight: 40.0,
                      minWidth: 80.0,
                    ),


                    isSelected: theSelected,

                    onPressed: (int toggleIndex) {
                      print(toggleIndex);
                      //theSelected=<bool>[false,true];
                      setState(() {
                        switch (toggleIndex){
                        case 0:
                          theSelected=<bool>[true,false,false,false];
                          break;
                          case 1:
                            theSelected=<bool>[false,true,false,false];
                            break;
                          case 2:
                            theSelected=<bool>[false,false,true,false];
                            break;
                          case 3:
                            theSelected=<bool>[false,false,false,true];
                            break;
                        }


                        print(theSelected);
                        // The button that is tapped is set to true, and the others to false.

                      });
                    },
                    //color: Colors.white,
                    //fillColor: Colors.white,
                    children: [
                      Text('السؤال الأول',textDirection: TextDirection.rtl,),
                      Text('السؤال الثانى',textDirection: TextDirection.rtl),
                      Text('السؤال الثالث',textDirection: TextDirection.rtl),
                     Text('السؤال الرابع',textDirection: TextDirection.rtl)].reversed.toList()
                                       ),

                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 100,
                        child: TextField(
                          keyboardType: TextInputType.number,
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
                        child: Text('${DegreeData.faultList[0]}\n${faultValue[0]}',
                        textAlign: TextAlign.center
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
                        child: Text('${DegreeData.faultList[1]}\n${faultValue[1]}',
                          textAlign: TextAlign.center
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
                        child:  Text('${DegreeData.faultList[2]}\n${faultValue[2]}',
                          textAlign: TextAlign.center
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
                        child: Text('${DegreeData.faultList[3]}\n${faultValue[3]}',
                          textAlign: TextAlign.center
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
                    child: Text('${DegreeData.faultList[4]}\n${faultValue[4]}',
                      textAlign: TextAlign.center
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
        testname TEXT NOT NULL UNIQUE,
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
    WHERE qaryname = ? AND testname = ?
    ''',
        [newdegree,widget.qaryName,widget.testName]);

    print(updateCount.toString());
  }

  Future<int> GetDegree() async {
    var deg;
    var db = await openDatabase('qary_dbase.db');
    deg = await db.rawQuery('''
    SELECT degree FROM datatable 
    WHERE qaryname = '${widget.qaryName}'
    '''
        );
    print(deg[0]);
    print(deg[0]['degree'].runtimeType);

    return deg[0]['degree'];
  }


}
