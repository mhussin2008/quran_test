import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController ageController = TextEditingController();
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
                    onPressed: () {
                      if (nameController.text.isNotEmpty &&
                          ageController.text.isNotEmpty) {
                        setState(() {
                          QaryList.add(QaryData.fromFields(nameController.text,
                              int.parse(ageController.text)));
                        });
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
}
