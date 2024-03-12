import 'dart:convert';

import '../core/language.dart';
import '../services/api_language_service.dart';

class LanguageHelper {
  final _api = ApiLanguageService();

  Future<List<Language>?> get() async {
    var result = await _api.get();
    if (result != null) {
      return List<Language>.from(
          json.decode(result).map((e) => Language.fromJson(e)));
    } else {
      print("language helper, get error occured");
      return null;
    }
  }

  Future<Language?> getById(int id) async {
    var result = await _api.getById(id);
    if (result != null) {
      return Language.fromJson(json.decode(result)[0]);
    }
    print("language helper, get by id error occured");
    return null;
  }
}
