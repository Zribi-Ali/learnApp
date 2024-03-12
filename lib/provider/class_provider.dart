import 'package:flutter/cupertino.dart';

import '../models/core/class.dart';
import '../models/helper/class_helper.dart';

class ClassProvider extends ChangeNotifier {
  final _helper = ClassHelper();
  bool loading = false;
  List<Class> classes = [];

  Future<void> get() async {
    loading = true;
    classes = (await _helper.get())!;
    loading = false;
    notifyListeners();
  }

  Future<String> getClassTitle(int id) {
    print("inside class provider");
    return _helper.getClassTitle(id);
  }
}
