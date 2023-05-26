import 'package:flutter/material.dart';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:quran_test/qaryData.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'QaryDataSource.dart';
import 'DialogScreen.dart';

class qaryDataEntry extends StatefulWidget {
  qaryDataEntry({Key? key}) : super(key: key);

  @override
  State<qaryDataEntry> createState() => _qaryDataEntryState();
}

class _qaryDataEntryState extends State<qaryDataEntry> {
  //QaryDataSource dataSource=QaryDataSource(qaryList: QaryList);
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_){
    //   CheckDbase();
    // });


    CheckDbase().then((value) =>
    {
      if (value=='Ok'){
      GetFromDb().then((value) => {
        print('Loaded all data')

      })
    }
    }
    );
  }

  @override
  Widget build(BuildContext context) {

    DataGridController dataGridController=DataGridController();
    QaryDataSource dataSource = QaryDataSource(qaryList: QaryList);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text('اسم الطالب'),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                    style: const TextStyle(height: 0.5),
                    keyboardType: TextInputType.text,
                    textDirection: TextDirection.rtl,
                    controller: nameController,
                    decoration:
                        const InputDecoration(border: OutlineInputBorder())),
                SizedBox(
                  height: 40,
                ),
                Text('عمر الطالب'),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                    style: const TextStyle(height: 0.5),
                    keyboardType: TextInputType.number,
                    textDirection: TextDirection.rtl,
                    controller: ageController,
                    decoration:
                        const InputDecoration(border: OutlineInputBorder())),
                SizedBox(
                  height: 20,
                ),
                OutlinedButton(
                    onPressed: () async {
                      if (nameController.text.isNotEmpty &&
                          ageController.text.isNotEmpty) {
                        setState(()  {
                          QaryList.add(QaryData.fromFields(nameController.text,
                              int.parse(ageController.text)));
                            });
                        String retVal=await  CheckDbase();
                        if (retVal=='Ok'){
                          print('ok');
                          await AddtoDb();
                        }
                        Fluttertoast.showToast(
                            msg: "تم إضافة بيانات الطالب بنجاح ",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.blueAccent,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        nameController.text = '';
                        ageController.text = '';
                        FocusManager.instance.primaryFocus?.unfocus();
                        print(QaryList.toString());
                          print(QaryList.length.toDouble());
                          dataGridController.refreshRow(QaryList.length);
                         //dataGridController.scrollToRow(QaryList.length.toDouble());



                        // Navigator.pop(context);
                      } else {
                        Fluttertoast.showToast(
                            msg: "بيانات الطالب غير مكتملة",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    },
                    child: Text('حفظ البيانات')),
                SfDataGrid(
                columnWidthMode: ColumnWidthMode.fill,
                isScrollbarAlwaysShown: true,
                gridLinesVisibility: GridLinesVisibility.both,
                headerGridLinesVisibility: GridLinesVisibility.both,
                controller: dataGridController,
                source: dataSource,
                columns: <GridColumn>[
                  GridColumn(

                      columnName: 'name',
                      label: Container(

                          padding: EdgeInsets.all(16.0),
                          alignment: Alignment.centerRight,
                          child: Text(
                           'اسم الطالب',

                          ))),
                  GridColumn(
                      columnName: 'age',
                      label: Container(
                          padding: EdgeInsets.all(16.0),
                          alignment: Alignment.centerRight,
                          child: Text('عمر الطالب  ')))
                ].reversed.toList(),
                  ),
                Container(width: 20,color: Colors.green,),
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly ,children: [
                  OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('عودة الى الشاشة الرئيسية')),

                  OutlinedButton(
                      onPressed: () async {
                        String result= await showDialog(
                            context: context,
                            builder: (BuildContext context) => const DialogScreen());

                        print(result);
                        if(result=='OK'){
                          print('deleting');
                          setState(() {
                            QaryList.clear();
                          });
                          CheckDbase().then(
                                  (value) async {
                                    if(value=='Ok'){
                                      await ClearDb();
                                    };
                                  });
                        }

                      },
                      child: Text('مسح الجدول بالكامل')),


                ],

                ),

              ],
            ),
          ),
        ));
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
        .rawQuery('SELECT * FROM sqlite_master WHERE name="datatable";');

    if (tables.isEmpty) {
      // Create the table
      print('no such table');
      try {
        await db.execute('''
        create table datatable (
        qaryname TEXT NOT NULL UNIQUE ,
        qaryage INTEGER DEFAULT 0
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

  Future<void> AddtoDb() async {

    var databasesPath = await getDatabasesPath();
    var dbFilePath = '$databasesPath/qary_dbase.db';
    late Database db;
    db = await openDatabase(dbFilePath);
    int age=int.parse(ageController.text);
    String line=''' '${nameController.text}', $age ''';
    String insertString =
    '''INSERT INTO datatable ( qaryname, qaryage) VALUES ( ${line} )''';
    print(insertString);
    await db.execute(insertString);

  }


  Future<void> GetFromDb() async{
    var databasesPath = await getDatabasesPath();
    var dbFilePath = '$databasesPath/qary_dbase.db';
    late Database db;
    db = await openDatabase(dbFilePath);
    List<Map<String,dynamic>>? gotlist =
    await db.database.rawQuery('SELECT * FROM datatable');
    print(gotlist);
    if(gotlist.isNotEmpty){
    QaryList.clear();
    setState(() {
      gotlist.forEach((e) {
        {
          //QaryList.add(QaryData.fromJson(e));
         QaryList.add(QaryData.fromFields(e['qaryname'],e['qaryage']));
      };
    });
    print(QaryList);
  });}
}

  ClearDb() async {
    var databasesPath = await getDatabasesPath();
    var dbFilePath = '$databasesPath/qary_dbase.db';
    late Database db;
    db = await openDatabase(dbFilePath);
    await db.database.rawQuery('SELECT * FROM datatable');

  }

}
