import 'package:flutter/cupertino.dart';

import '../models/core/user.dart';
import '../models/helper/employee_helper.dart';

class EmployeeProvider extends ChangeNotifier {
  final _helper = EmployeeHelper();

  bool loading = false;

  List<User> employees = [];
  User? _employeeForCourse;

  Future<void> initializeEmployees() async {
    loading = true;
    employees = (await _helper.get())!;
    loading = false;
    notifyListeners();
  }

  Future<String> getEmployeeName(int id) async {
    var result = await _helper.getById(id);
    if (result != null) {
      return result.fullname;
    }
    return "";
  }

  Future<User?> getEmployee2(int id) async {
    var result = await _helper.getById(id);
    if (result != null) {
      return result;
    }
    return null;
  }

  setEmployeeForCourse(int id) async {
    _employeeForCourse = (await _helper.getById(id))!;
  }

  User get employeeForCourse => _employeeForCourse!;
}
