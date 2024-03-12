import 'package:flutter/cupertino.dart';

import '../models/app_utilities.dart';
import '../models/core/course_for_show_more.dart';
import '../models/core/courses.dart';
import '../models/helper/courses_helper.dart';

class CoursesProvider extends ChangeNotifier {
  // the app navigation ensures that id language is always filled

  int? idLanguage;
  int? idClass;

  Course? _currentCourse;

  bool loading = false;

  List<Course> courses = [];

  List<Course> myNCourse = [];

  List<CourseForShowMore> coursesForShowMore = [];

  final _helper = CoursesHelper();

  int _numberPages = 0;

  int get numberPages => _numberPages;

  void setNumberPages() async {
    loading = true;
    int coursesCount = await _helper.countCourses(idLanguage!);

    _numberPages = (coursesCount / AppUtilities.maximumPageNumber).ceil();

    print("maximum number of pages changed to $_numberPages");
    loading = false;
    notifyListeners();
  }

  // Future<void> get() async {
  //   loading = true;
  //   courses = (await _helper.get())!;
  //
  //   courses = courses.where((element) => element.idLang == idLanguage).toList();
  //
  //   _filterByIdClass();
  //
  //   loading = false;
  //
  //   notifyListeners();
  // }

  // No id Language and no id class and no id unit
  // even if count courses filters with id language show more does not
  // no description for the course

  Future<void> getCoursesWithShowMore(int pageNumber) async {
    loading = true;
    coursesForShowMore = (await _helper.showMore(pageNumber, idLanguage!));
    if (idClass != null) {
      coursesForShowMore =
          _filterByIdClass(coursesForShowMore) as List<CourseForShowMore>;
    }
    loading = false;
    notifyListeners();
  }

  List _filterByIdClass(List list) =>
      list.where((element) => element.idClass == idClass).toList();

  int? get currentIdLanguage {
    return idLanguage;
  }

  void setIdLanguage(int id) {
    idLanguage = id;
    setNumberPages();
    notifyListeners();
  }

  int? get currentIdClass {
    return idClass;
  }

  Course get course {
    return _currentCourse!;
  }

  setCourse(Course course) {
    _currentCourse = course;
    print("course changed : $course");
    notifyListeners();
  }

  void setIdClass(int? id) {
    idClass = id;
    print("current id class $id");
    notifyListeners();
  }

  Future<Course> getById(int id) async {
    return (await _helper.getById(id))!;
  }
}
