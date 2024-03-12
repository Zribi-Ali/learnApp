import 'dart:convert';

import '../core/user.dart';
import '../services/api_emplee_service.dart';

class EmployeeHelper {
  final _api = ApiEmpleeService();

  Future<List<User>?> get() async {
    var result = await _api.get();
    if (result != null) {
      return List<User>.from(json.decode(result).map((e) => User.fromJson(e)));
    }
    print("User Helper, get failed");
    return null;
  }

  Future<User?> getById(int id) async {
    var result = await _api.getById(id);
    if (result != null) {
      return User.fromJson(json.decode(result)[0]);
    }
    print("User Helper, get by id failed");
    return null;
  }
}
