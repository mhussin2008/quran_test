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
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('جدول درجات الخصم'),
      ),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
            DegreeData.degreeTable.asMap().entries.map  (
                    (entry) => Padding(
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
      ) ,
    );
  }
}
