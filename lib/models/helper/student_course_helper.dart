import 'dart:convert';

import '../core/student_course.dart';
import '../services/api_student_course_service.dart';

class StudentCourseHelper {
  final _api = ApiStudentCourseService();

  Future<List<StudentCourse>?> get() async {
    var result = await _api.get();
    if (result != null) {
      return List<StudentCourse>.from(
          json.decode(result).map((e) => StudentCourse.fromJson(e)));
    } else {
      print("Student course helper, get error occured");
      return null;
    }
  }

  Future<StudentCourse?> getById(int id) async {
    var result = await _api.getById(id);
    if (result != null) {
      return StudentCourse.fromJson(json.decode(result)[0]);
    } else {
      print("Student course helper, get by id error occured");
      return null;
    }
  }

  Future<bool> post(StudentCourse studentCourse) async =>
      await _api.post(json.encode(studentCourse.toJson()));
}
