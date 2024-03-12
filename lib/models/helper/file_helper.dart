import 'dart:convert';

import '../core/file.dart';
import '../services/api_file_service.dart';

class Filehelper {
  final _api = ApiFileService();

  Future<List<File>?> getByIdStream(int id) async {
    var result = await _api.getByIdStream(id);
    if (result != null) {
      return List<File>.from(json.decode(result).map((e) => File.fromJson(e)));
    } else {
      print("file helper, get error occurred");
      return null;
    }
  }

  Future<List<File>?> getByIdLesson(int id) async {
    var result = await _api.getByIdLesson(id);
    if (result != null) {
      return List<File>.from(json.decode(result).map((e) => File.fromJson(e)));
    } else {
      print("file helper, get error occurred");
      return [];
    }
  }
}
