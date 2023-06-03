import 'package:flutter/material.dart';
import 'package:quran_test/Screens/QaryDataEntry.dart';

class startUpScreen extends StatelessWidget {
  const startUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('Start Up Screen'),

            SizedBox(height: 10),
            OutlinedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => qaryDataEntry()));
                },
                child: Text('بيانات الطلاب'))
          ],
        ),
      ),
    );
  }
}
