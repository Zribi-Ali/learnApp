import 'package:flutter/cupertino.dart';

import '../models/core/unit.dart';
import '../models/helper/unit_helper.dart';

class UnitProvider extends ChangeNotifier {
  final _helper = UnitHelper();
  int? idCourse;
  bool emptyUnits = false;
  bool loading = false;

  List<Unit> units = [];

  Future<void> get() async {
    emptyUnits = false;
    loading = true;
    units = (await _helper.get())!;
    loading = false;
    units = units.where((element) => element.idCourse == idCourse).toList();
    //print(units[0].idCourse);
    if (units.isEmpty) {
      emptyUnits = true;
    }
    notifyListeners();
  }

  int? get currentIdCourse {
    return idCourse;
  }

  void setIdCourse(int id) {
    idCourse = id;
    print("current id course : $idCourse");
    notifyListeners();
  }
}
