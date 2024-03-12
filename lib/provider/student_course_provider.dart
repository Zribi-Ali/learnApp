import 'package:flutter/cupertino.dart';

import '../models/core/student_course.dart';
import '../models/helper/student_course_helper.dart';

class StudentCourseProvider extends ChangeNotifier {
  final _helper = StudentCourseHelper();

  List<StudentCourse> _studentCourses = [];

  bool loading = false;

  initializeStudentCourses(int idUser) async {
    loading = true;
    _studentCourses = (await _helper.get())!;

    _filterByIdUser(idUser);
    loading = false;

    notifyListeners();
  }

  _filterByIdUser(int idUser) {
    _studentCourses = _studentCourses
        .where((element) => element.idStudent == idUser)
        .toList();
  }

  Future<bool> postStudentCourse(StudentCourse studentCourse) async =>
      await _helper.post(studentCourse);

  List<StudentCourse> get studentCourses => _studentCourses;
}
