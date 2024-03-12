import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../all_lessons.dart';
import '../student_course_view.dart';
import '../notification_view.dart';
import '../profile.dart';
import 'live_done.dart';
import 'live_now.dart';
import 'live_upcoming.dart';

class Live extends StatefulWidget {
  const Live({Key? key}) : super(key: key);

  @override
  _LiveState createState() => _LiveState();
}

class _LiveState extends State<Live> {
  String? selectedValue;
  List<String> items = [
    'البث الحالي',
    'البث القادم',
    'البث القديم',
  ];

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Center(
          child: Text(
            'البث المباشر',
            style: TextStyle(
                color: Colors.white,
                fontSize: 24

            ),),
        ),
      ),


      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          shrinkWrap: true,

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                DropdownButtonHideUnderline(
                  child: DropdownButton2(

                    items: items.map((item) =>
                        DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                        .toList(),
                    value: selectedValue,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value as String;
                      });
                      switch (value) {
                        case 'البث الحالي':
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => LiveNow()));
                          break;
                        case 'البث القادم':
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => LiveUpcoming()));
                          break;
                        case 'البث القديم':
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => LiveDone()));
                          break;

                      }
                    },
                    buttonHeight: 40,
                    buttonWidth: 100,
                    itemHeight: 40,
                  ),
                ),
              ],
            )
          ],
        ),
      ),










      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,

        onTap: (index) => setState( () => currentIndex=index),


        unselectedItemColor: Colors.black45,

        showUnselectedLabels: true,
        unselectedIconTheme: IconThemeData(
            color: Colors.black45),

        selectedIconTheme: IconThemeData(
            color: Colors.amber
        ),


        items: [

          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.play_circle_filled),
              onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) => StudentCourseView()));
              ;},),
            label: 'دروسي',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => notification()));},),
            label: 'الإشعارات',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon:   Icon(Icons.supervised_user_circle),
              onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => Profile())) ;},
            ),
            label: 'صفحتي',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.home), onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllLessons())); },
            ),
            label: 'الرئيسية',

          )
        ],
        selectedItemColor: Colors.amber[800],
      ),


    );
  }
}
