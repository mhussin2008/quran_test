import 'package:flutter/material.dart';
import '';
import '../Data/DegreeData.dart';

class DegreeTable extends StatefulWidget {
   DegreeTable({Key? key}) : super(key: key);

  @override
  State<DegreeTable> createState() => _DegreeTableState();
}

class _DegreeTableState extends State<DegreeTable> {
  List<TextEditingController> tEditContoller=
                List.generate(DegreeData.faultList.length, (index) => TextEditingController(text: DegreeData.degreeTable[index].toString() ));
  @override
  void initState() {
    // TODO: implement initState
    DegreeData.getDegreeData();
    
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('جدول درجات الخصم'),
      ),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                 DegreeData.degreeTable.asMap().entries.map  (
                        (entry) =>  Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextField(
                                    controller: tEditContoller[entry.key]  ,
                                     ),
                              )
                              ,SizedBox(width: 20,)
                              ,
                              Expanded(child: Text(DegreeData.faultList[entry.key]))
                            ],
                          ),
                        )).toList()
            ),
            SizedBox(height: 40,),
            OutlinedButton(onPressed: () async {
              // DegreeData.degreeTable=DegreeData.degreeTable.asMap().entries.map((entry) {
              //   return int.parse(tEditContoller[entry.key].text);
              // }).toList();
              DegreeData.degreeTable.clear();
              tEditContoller.forEach((element) {
                DegreeData.degreeTable.add(int.parse(element.text));
              });
              print(DegreeData.degreeTable);
              await DegreeData.setDegreeData();

              
            }, child: Text('حفظ ورجوع للشاشة الرئيسية'))
          ],
        ),
      ) ,
    );
  }
}
