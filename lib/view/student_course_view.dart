import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing/provider/student_course_provider.dart';
import 'package:testing/provider/user_provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../provider/review_provider.dart';
import 'custom_used_widgets/bottom_navigation_bar.dart.dart';
import 'custom_used_widgets/student_course_item.dart';

class StudentCourseView extends StatefulWidget {
  const StudentCourseView({Key? key}) : super(key: key);

  @override
  State<StudentCourseView> createState() => StudentCourseViewState();
}

class StudentCourseViewState extends State<StudentCourseView> {
  int myLessonsIndex = 0;

  @override
  void initState() {
    Provider.of<StudentCourseProvider>(context, listen: false)
        .initializeStudentCourses(
            Provider.of<UserProvider>(context, listen: false).user.id);

    Provider.of<ReviewProvider>(context, listen: false).initializeReviews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          centerTitle: true,
          title: Text(
            // AppLocalizations.of(context)!.myLessons,
            AppLocalizations.of(context)!.courses,
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
        body: Provider.of<StudentCourseProvider>(context).loading &&
                Provider.of<ReviewProvider>(context).loading
            ? Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                ),
              )
            : Provider.of<StudentCourseProvider>(context).studentCourses.isEmpty
                ? Center(child: Text(AppLocalizations.of(context)!.noCourses))
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25.0),
                    child: ListView.separated(
                      separatorBuilder: ((context, index) => SizedBox(
                            height: 25,
                          )),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: StudentCourseItem(
                              videoState: ""
                              //AppLocalizations.of(context)!.minute + " 22 "
                              ,
                              studentCourse:
                                  Provider.of<StudentCourseProvider>(context)
                                      .studentCourses[index],
                            ));
                      },
                      itemCount: Provider.of<StudentCourseProvider>(context)
                          .studentCourses
                          .length,
                    ),
                  ),
        bottomNavigationBar: BottomNavigationBarApp(
          currentIndex: myLessonsIndex,
        ));
  }
}
