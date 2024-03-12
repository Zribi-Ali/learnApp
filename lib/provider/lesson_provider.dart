import 'package:flutter/cupertino.dart';

import '../models/core/lesson.dart';
import '../models/helper/lesson_helper.dart';

class LessonProvider extends ChangeNotifier {
  final _helper = LessonHelper();
  int? idUnit;
  bool loading = false;
  List<Lesson> _lessons = [];
  int? _currentIdLesson;

  Future<void> initializeLessons() async {
    loading = true;
    _lessons = (await _helper.get())!;
    loading = false;
    notifyListeners();
  }

  int? get currentIdUnit {
    return idUnit;
  }

  void setIdUnit(int id) {
    idUnit = id;
    print("current id unit : $idUnit");
    notifyListeners();
  }

  int? get currentIdLesson {
    return _currentIdLesson;
  }

  void setIdLesson(int id) {
    _currentIdLesson = id;
    print("current id lesson : $_currentIdLesson");
    notifyListeners();
  }

  List<Lesson> getLessonsByUnitId() {
    return _lessons.where((element) => element.idUnite == idUnit).toList();
  }

  List<Lesson> get notifications => _lessons;
}
