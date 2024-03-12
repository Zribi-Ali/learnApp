import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:testing/view/all_lessons.dart';
import 'package:testing/view/chat.dart';
import 'package:testing/view/student_course_view.dart';
import 'package:testing/view/notification_view.dart';
import 'package:testing/view/profile.dart';

// ignore: must_be_immutable
class BottomNavigationBarApp extends StatefulWidget {
  int currentIndex ;
  BottomNavigationBarApp({ Key? key , required this.currentIndex}) : super(key: key);

  @override
  State<BottomNavigationBarApp> createState() => _BottomNavigationBarAppState();
}

class _BottomNavigationBarAppState extends State<BottomNavigationBarApp> {
  
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      // backgroundColor: Colors.white,
        currentIndex: widget.currentIndex,
        onTap: (index) => setState(() => widget.currentIndex = index),
        unselectedItemColor: Colors.black45,
        showUnselectedLabels: true,
        unselectedIconTheme: IconThemeData(color: Colors.black45),
        selectedIconTheme: IconThemeData(color: Colors.amber),
        items: [
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.play_circle_filled),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => StudentCourseView()));
                ;
              },
            ),
            // label: AppLocalizations.of(context)!.myLessons,
            label: AppLocalizations.of(context)!.courses,
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => notification()));
              },
            ),
            label: AppLocalizations.of(context)!.notification,
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.supervised_user_circle),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Profile()));
              },
            ),
            label: AppLocalizations.of(context)!.myPage,
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AllLessons()));
              },
            ),
            label: AppLocalizations.of(context)!.mainPage,
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.chat),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Chat()));
              },
            ),
            label: AppLocalizations.of(context)!.chat,
          ),
        ],
        selectedItemColor: Colors.amber[800],
      );
  }
}