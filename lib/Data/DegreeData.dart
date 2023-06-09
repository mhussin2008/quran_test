import 'package:shared_preferences/shared_preferences.dart';
class DegreeData{
  static List<int> degreeTable=[2,2,2,2,2];
  static List<String> faultList=['صحح له المعلم','صحح بنفسه','التردد','خطأ التجويد','خطأ الوقف والإبتداء'];

  static getDegreeData() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var degreeTableS=await prefs.getStringList('degrees');

    degreeTable.clear();
    if(degreeTableS!.isNotEmpty){
    degreeTableS.forEach((element) {
      degreeTable.add(int.parse(element));

    });
    }
  }

  static setDegreeData() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> degreeTableS=[];
    if(degreeTable.isNotEmpty){

       degreeTable.forEach((element) {
          degreeTableS.add(element.toString());

        });
      }
    await prefs.setStringList('degrees',degreeTableS);

    }

  }


