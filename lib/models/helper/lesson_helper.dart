import 'dart:convert';

import '../core/lesson.dart';
import '../services/api_lesson_service.dart';

class LessonHelper {
  final _api = ApiLessonService();

  Future<List<Lesson>?> get() async {
    var result = await _api.get();
    if (result != null) {
      return List<Lesson>.from(
          json.decode(result).map((e) => Lesson.fromJson(e)));
    } else {
      print("Lesson helper, get error occured");
      return [];
    }
  }
}
