import 'package:flutter/material.dart';

class QaryExam extends StatelessWidget {
  const QaryExam({Key? key, required this.qaryName}) : super(key: key);
  final String qaryName;

  @override
  Widget build(BuildContext context) {

    int mark = 100;
    TextEditingController markController=TextEditingController();
    markController.text=mark.toString();
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('إختبار')),
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
                    Container(
                      width: 100,
                      child: TextField(
                        controller: markController,
                        style: TextStyle(
                          fontSize: 40
                        ),

                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Text(qaryName,
                      style: TextStyle(
                          fontSize: 40
                      ),)
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OutlinedButton(
                      onPressed: () {},
                      child: Text('صحح له المعلم'
                      ,style: TextStyle(fontSize: 20),),
                      style: ElevatedButton.styleFrom(

                        padding: EdgeInsets.all(20),
                        backgroundColor: Colors.blue, // <-- Button color
                        foregroundColor: Colors.black, // <-- Splash color
                      )),
                  SizedBox(width: 10,),
                  OutlinedButton(
                      onPressed: () {},
                      child: Text('صحح بنفسه'
                        ,style: TextStyle(fontSize: 20),),
                      style: ElevatedButton.styleFrom(

                        padding: EdgeInsets.all(20),
                        backgroundColor: Colors.blue, // <-- Button color
                        foregroundColor: Colors.black, // <-- Splash color
                      )),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OutlinedButton(
                      onPressed: () {},
                      child: Text('التردد'
                        ,style: TextStyle(fontSize: 20),),
                      style: ElevatedButton.styleFrom(

                        padding: EdgeInsets.all(20),
                        backgroundColor: Colors.blue, // <-- Button color
                        foregroundColor: Colors.black, // <-- Splash color
                      )),
                  SizedBox(width: 10,),
                  OutlinedButton(
                      onPressed: () {},
                      child: Text('خطأ التجويد'
                        ,style: TextStyle(fontSize: 20),),
                      style: ElevatedButton.styleFrom(

                        padding: EdgeInsets.all(20),
                        backgroundColor: Colors.blue, // <-- Button color
                        foregroundColor: Colors.black, // <-- Splash color
                      )),
                ],
              ),
              SizedBox(height: 10,),
              OutlinedButton(
                  onPressed: () {},
                  child: Text('خطأ الوقف والإبتداء'
                    ,style: TextStyle(fontSize: 20),),
                  style: ElevatedButton.styleFrom(

                    padding: EdgeInsets.all(20),
                    backgroundColor: Colors.blue, // <-- Button color
                    foregroundColor: Colors.black, // <-- Splash color
                  )),
            SizedBox(height: 20,)

            ,Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [ OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('حفظ الدرجة والعودة'
                      ,style: TextStyle(fontSize: 20),),
                    style: ElevatedButton.styleFrom(
                       padding: EdgeInsets.all(20),
                      backgroundColor: Colors.limeAccent, // <-- Button color
                      foregroundColor: Colors.black, // <-- Splash color
                    )),],),
            )
            ],
          ),
        ),
      ),
    );
  }
}
