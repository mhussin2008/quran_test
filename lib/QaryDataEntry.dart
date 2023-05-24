import 'package:flutter/material.dart';
import 'package:quran_test/qaryData.dart';
import 'package:fluttertoast/fluttertoast.dart';

class qaryDataEntry extends StatelessWidget {
  const qaryDataEntry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController=TextEditingController();
    TextEditingController ageController=TextEditingController();
    return  Scaffold(
        body: Center(child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('اسم الطالب'),
              SizedBox(height: 20,),
              TextFormField(
                keyboardType: TextInputType.text,
                textDirection: TextDirection.rtl,
                controller: nameController,
              ),
              SizedBox(height: 40,),
              Text('عمر الطالب'),
              SizedBox(height: 20,),
              TextFormField(
                keyboardType: TextInputType.number,
                textDirection: TextDirection.rtl,
                controller: ageController,
              ),
              SizedBox(height: 20,),
              OutlinedButton(
                  onPressed: (){
                    if(nameController.text.isNotEmpty && ageController.text.isNotEmpty){
                    QaryList.add(QaryData.fromFields(nameController.text, int.parse(ageController.text)));
                    Fluttertoast.showToast(
                        msg: "تم إضافة بيانات الطالب بنجاح ",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.cyanAccent,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                    nameController.text='';
                    ageController.text='';
                    print(QaryList.toString());
                    // Navigator.pop(context);
                  }else{
                      Fluttertoast.showToast(
                          msg: "بيانات الطالب غير مكتملة",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );

                    }
                    },
                  child: Text('حفظ البيانات')),
              SizedBox(height: 20,),
              OutlinedButton(onPressed: (){

                Navigator.pop(context);

              },
                  child: Text('عودة الى الشاشة الرئيسية'

              ))
            ],
          ),
        ),));
  }
}
