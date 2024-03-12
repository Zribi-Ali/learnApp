import 'dart:convert';

import '../core/student_stream.dart';
import '../services/api_student_stream_service.dart';

class StudentStreamHelper {
  final _api = ApiStudentStreamService();

  Future<List<StudentStream>?> get() async {
    var result = await _api.get();
    if (result != null) {
      return List<StudentStream>.from(
          json.decode(result).map((e) => StudentStream.fromJson(e)));
    } else {
      print("Student Stream helper, get error occured");
      return null;
    }
  }

  Future<bool> post(StudentStream StudentStream) async {
    print("inside helper");
    return _api.post(json.encode(StudentStream.toJson()));
  }
}
