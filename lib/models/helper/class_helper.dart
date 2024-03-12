import 'dart:convert';

import '../core/class.dart';
import '../services/api_class_service.dart';

class ClassHelper {
  final _api = ApiClassService();

  Future<List<Class>?> get() async {
    var result = await _api.get();
    if (result != null) {
      return List<Class>.from(
          json.decode(result).map((e) => Class.fromJson(e)));
    } else {
      print("class helper, get error occured");
      return null;
    }
  }

  Future<String> getClassTitle(int id) async {
    print("inside get class title helper");
    var result = await _api.getById(id);
    if (result != null) {
      return json.decode(result)["title_class"];
    } else {
      print("class helper, get by id error occured");
      return "";
    }
  }
}
