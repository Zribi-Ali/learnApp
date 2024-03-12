import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/core/courses.dart';
import '../../models/core/student_course.dart';
import '../../provider/courses_provider.dart';
import '../../provider/review_provider.dart';
import '../../provider/stream_provider.dart';
import '../../provider/unit_provider.dart';
import '../student_course_choice.dart';

class StudentCourseItem extends StatefulWidget {
  final StudentCourse studentCourse;
  final String videoState;

  StudentCourseItem(
      {required this.studentCourse, required this.videoState, Key? key})
      : super(key: key);

  @override
  State<StudentCourseItem> createState() => _StudentCourseItemState();
}

class _StudentCourseItemState extends State<StudentCourseItem> {
  Course? myCourse;

  Future<void> setVariables() async {
    var result = await Provider.of<CoursesProvider>(context, listen: false)
        .getById(widget.studentCourse.idCourse);
    if (mounted) {
      setState(() {
        myCourse = result;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setVariables();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(width: 1.0, color: Colors.black12),
      )),
      child: ListTile(
        onTap: () {
          Provider.of<UnitProvider>(context, listen: false)
              .setIdCourse(widget.studentCourse.idCourse);
          Provider.of<AppStreamProvider>(context, listen: false)
              .setIdCourse(widget.studentCourse.idCourse);

          if (myCourse != null) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Choice(currentIndex: 0)));
          }
        },
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              getStatusType(context),
              style: TextStyle(
                  color: getStatusColor(),
                  fontSize: 17,
                  fontWeight: FontWeight.w300),
            ),
            Text(
              widget.videoState,
              style: TextStyle(color: Colors.black54, fontSize: 14),
            ),
          ],
        ),
        title: Text(
          myCourse == null
              ? AppLocalizations.of(context)!.loading
              : myCourse!.titleCourse,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.normal, fontSize: 17),
        ),
        subtitle: Row(
          children: [
            if (Provider.of<ReviewProvider>(context)
                    .getReviewByIdCourse(widget.studentCourse.idCourse) !=
                null)
              for (var i = 0;
                  i <
                      Provider.of<ReviewProvider>(context)
                          .getReviewByIdCourse(widget.studentCourse.idCourse)!
                          .valueReview;
                  i++)
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 22,
                ),
          ],
        ),
      ),
    );
  }

// status == 3 : course done
// status == 2 : in progress
// status 1 == not started yet

  getStatusColor() {
    switch (widget.studentCourse.status) {
      case 1:
        return Colors.red;

      case 2:
        return Colors.amber;
      case 3:
        return Colors.green;

      default:
        return Colors.black;
    }
  }

  String getStatusType(BuildContext context) {
    switch (widget.studentCourse.status) {
      case 1:
        return AppLocalizations.of(context)!.newId;

      case 2:
        return AppLocalizations.of(context)!.progress;
      case 3:
        return AppLocalizations.of(context)!.done;

      default:
        return "Not found";
    }
  }
}
