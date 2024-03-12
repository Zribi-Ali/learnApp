import 'dart:convert';

import '../core/unit.dart';
import '../services/api_unit_service.dart';

class UnitHelper {
  final _api = ApiUnitService();

  Future<List<Unit>?> get() async {
    var result = await _api.get();
    //print(result); // ok
    if (result != null) {
      return List<Unit>.from(json.decode(result).map((e) => Unit.fromJson(e)));
    } else {
      print("unit helper, get error occured");
      return [];
    }
  }
}
