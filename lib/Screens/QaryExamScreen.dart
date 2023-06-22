import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../Data/DegreeData.dart';

class QaryExam extends StatefulWidget {


  const QaryExam({Key? key, required this.qaryName, required this.degree,required this.testName, required this.questions}) : super(key: key);
  final String qaryName;
  final double degree;
  final String testName;
  final int questions;

  @override
  State<QaryExam> createState() => _QaryExamState();
}

class _QaryExamState extends State<QaryExam> {



  double mark=0 ;
  List<TextEditingController> markController=[];
  List<double> faultValue=DegreeData.degreeTable??[2.0,2.0,2.0,2.0,2.0];
  List<String> qNamesAll=['الأول',
  'الثانى','الثالث','الرابع','الخامس'];

  var theSelectedAll=[false,false,false,false,false];
  List<bool> theSelected=[];
  List<double> questionList=[];
  List<Text> txtList=[];

  @override
  void initState()  {
    // TODO: implement initState

    mark=100.0/widget.questions;
    questionList=List.generate(widget.questions, (index) => mark);
    markController=List.generate(widget.questions, (index) => TextEditingController());
    markController.forEach((element) {element.text=mark.toString(); });
    print(widget.questions);
    updateSelected();

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

  void updateSelected() {
    theSelected.clear();
    txtList.clear();
    for(int i=0;i<widget.questions;i++){
      theSelected.add(theSelectedAll[i]);

      txtList.add(Text(qNamesAll[i],textDirection: TextDirection.rtl));

    }
    theSelected[widget.questions-1]=true;
  }

  @override
  Widget build(BuildContext context) {
      for( int i=0;i<markController.length;i++){
    markController[i].text=questionList[i].toString() ;}
      //updateSelected();


   // markController.text=mark.toString();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title:  Center(child: Text('${widget.qaryName} إختبار '))),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/jpg/back.jpg' ),fit: BoxFit.cover
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 10,),
            ToggleButtons(


                borderRadius: const BorderRadius.all(Radius.circular(8)),
                selectedBorderColor: Colors.red[700],
                selectedColor: Colors.white,
                fillColor: Colors.red[200],
                color: Colors.pink[900],
                constraints: const BoxConstraints(
                  minHeight: 40.0,
                  minWidth: 60.0,
                ),


                isSelected: theSelected,//.reversed.toList(),

                onPressed: (int toggleIndex) {
                  print(toggleIndex);
                  //theSelected=<bool>[false,true];
                  theSelected.clear();
                  theSelected=theSelectedAll.sublist(0,widget.questions);
                  theSelected[0]=false;
                  setState(() {

                    theSelected[toggleIndex]=true;



                    print(theSelected);
                    // The button that is tapped is set to true, and the others to false.

                  });
                },
                //color: Colors.white,
                //fillColor: Colors.white,
                children: txtList.reversed.toList()
                                   ),

            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                markController.asMap().entries.map((e) =>
                    SizedBox(
                      width: 60,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: markController[e.key],
                        style: const TextStyle(
                            fontSize: 20
                        ),

                      ),
                    )
                ).toList()



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

                      padding: const EdgeInsets.all(8),
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

                      padding: const EdgeInsets.all(8),
                      backgroundColor: Colors.blue, // <-- Button color
                      foregroundColor: Colors.black, // <-- Splash color
                    ),
                    child: Text('${DegreeData.faultList[1]}\n${faultValue[1]}',
                      textAlign: TextAlign.center
                      ,style: const TextStyle(fontSize: 20),)),
                SizedBox(width: 10,),

                OutlinedButton(
                    onPressed: () {
                      decreaseMark(faultValue[2]);
                    },
                    style: ElevatedButton.styleFrom(

                      padding: const EdgeInsets.all(8),
                      backgroundColor: Colors.blue, // <-- Button color
                      foregroundColor: Colors.black, // <-- Splash color
                    ),
                    child:  Text('${DegreeData.faultList[2]}\n${faultValue[2]}',
                      textAlign: TextAlign.center
                      ,style: TextStyle(fontSize: 20),)),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [

                const SizedBox(width: 10,),
                OutlinedButton(
                    onPressed: () {
                      decreaseMark(faultValue[3]);
                    },
                    style: ElevatedButton.styleFrom(

                      padding: const EdgeInsets.all(8),
                      backgroundColor: Colors.blue, // <-- Button color
                      foregroundColor: Colors.black, // <-- Splash color
                    ),
                    child: Text('${DegreeData.faultList[3]}\n${faultValue[3]}',
                      textAlign: TextAlign.center
                      ,style: TextStyle(fontSize: 20),)),
                const SizedBox(width: 10,),
                OutlinedButton(
                    onPressed: () {
                      decreaseMark(faultValue[4]);
                    },
                    style: ElevatedButton.styleFrom(

                      padding: const EdgeInsets.all(8),
                      backgroundColor: Colors.blue, // <-- Button color
                      foregroundColor: Colors.black, // <-- Splash color
                    ),
                    child: Text('${DegreeData.faultList[4]}\n${faultValue[4]}',
                      textAlign: TextAlign.center
                      ,style: const TextStyle(fontSize: 20),)),
                const SizedBox(width: 10,),
              ],
            ),

          const SizedBox(height: 20,)

          ,Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [ OutlinedButton(
                  onPressed: () async {
                    if(await CheckDbase()=='Ok'){
                      double total=0;
                      for(int i=0;i<markController.length;i++){
                      total+=double.parse(markController[i].text);}

                      await updateDb(total);
                    }

                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                     padding: const EdgeInsets.all(8),
                    backgroundColor: Colors.limeAccent, // <-- Button color
                    foregroundColor: Colors.black, // <-- Splash color
                  ),
                  child: const Text('حفظ الدرجة والعودة'
                    ,style: TextStyle(fontSize: 20),)),],),
          )
          ],
        ),
      ),
    );
  }

  void decreaseMark(double fValue) {
    int sel=theSelected.indexWhere((element) => element==true);
    print(sel);
    if( questionList[sel]-fValue<=0){

      questionList[sel]=0; }else{
      questionList[sel]-=fValue;}

    setState(() {


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

  Future<void> updateDb(double newdegree)  async {
    var db = await openDatabase('qary_dbase.db');


    int updateCount = await db.rawUpdate('''
    UPDATE datatable 
    SET  degree = ? 
    WHERE qaryname = ? AND testname = ?
    ''',
        [newdegree,widget.qaryName,widget.testName]);

    print(updateCount.toString());
  }

  Future<double> GetDegree() async {
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
