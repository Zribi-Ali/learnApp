import 'dart:async';

import 'package:flutter/material.dart';

import '../models/core/city.dart';
import '../models/helper/city_helper.dart';
import '../translation_utilities/languages_manager.dart';

class CityProvider extends ChangeNotifier {
  final _helper = CityHelper();
  int? cityId;

  City? currentCity;

  List<City> cities = [];

  bool loading = false;

  //used to eliminate unneccessary calls to the api IF the city list (initializeCities)
  // is already available for use inside the current widget
  // int? _localCityId;

  // int get localCityId {
  //   if (_localCityId == null) {
  //     return city.idCity;
  //   } else {
  //     return _localCityId!;
  //   }
  // }
  //
  // setLocalCityId(int id) {
  //
  // }

  Future<void> initializeCities() async {
    loading = true;
    cities = (await _helper.get())!;
    loading = false;
    notifyListeners();
  }

  List<String> getNames(Locale locale) {
    if (locale != Languages.codes[0]) {
      return List.from(cities.map((e) => e.cityNameEn));
    }
    return List.from(cities.map((e) => e.cityNameAr));
  }

  String getcityName(Locale locale) {
    if (locale == Languages.codes[0]) {
      return city.cityNameAr;
    }
    return city.cityNameEn;
  }

  Future<void> setCity(int id) async {
    print("id is $id");
    currentCity = (await _helper.getById(id));

    notifyListeners();
  }

  City get city {
    return currentCity!;
  }
}
