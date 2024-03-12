import 'dart:convert';

import '../core/city.dart';
import '../services/api_city_service.dart';

class CityHelper {
  final _api = ApiCityService();

  Future<List<City>?> get() async {
    var result = await _api.get();
    if (result != null) {
      return List<City>.from(json.decode(result).map((e) => City.fromJson(e)));
    } else {
      print("city helper, get error occured");
      return [];
    }
  }

  Future<City?> getById(int id) async {
    var result = await _api.getById(id);
    if (result != null) {
      return City.fromJson(json.decode(result)[0]);
    } else {
      print("city helper, get by id error occured");
      return null;
    }
  }
}
