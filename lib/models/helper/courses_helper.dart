import 'dart:convert';

import '../core/course_for_show_more.dart';
import '../core/courses.dart';
import '../services/api_courses_service.dart';

class CoursesHelper {
  final _api = ApiCoursesService();

  Future<List<Course>?> get() async {
    var result = await _api.get();
    if (result != null) {
      return List<Course>.from(
          json.decode(result).map((e) => Course.fromJson(e)));
    } else {
      print("Courses helper, get error occurred");
      return null;
    }
  }

  Future<int> countCourses(int idLang) async {
    var result = await _api.countCourses(idLang);
    if (result != null) {
      return json.decode(result)[0]["nbrPages"];
    } else {
      print("Courses helper, count courses error occurred");
      return 0;
    }
  }

  Future<List<CourseForShowMore>> showMore(int pageNumber, int idLang) async {
    var result = await _api.showMore(pageNumber, idLang);
    if (result != null) {
      if (json.decode(result) == "Empty") {
        print("no more pages");
        return [];
      }
      var test = List<CourseForShowMore>.from(
          json.decode(result).map((e) => CourseForShowMore.fromJson(e)));
      return test.where((element) => element.typeCourse == 2).toList();
    } else {
      print("Courses helper, show more courses error occurred");
      return [];
    }
  }

  Future<Course?> getById(int id) async {
    var result = await _api.getById(id);
    if (result != null) {
      return Course.fromJson(json.decode(result)[0]);
    }
    print("Course helper, get by id error occurred");
    return null;
  }
}
