import 'package:flutter/cupertino.dart';

import '../models/core/language.dart';
import '../models/helper/language_helper.dart';

class LanguageProvider extends ChangeNotifier {
  final _helper = LanguageHelper();

  bool loading = false;
  List<Language> _languages = [];

  Future<void> initializeLanguages() async {
    loading = true;
    _languages = (await _helper.get())!;
    loading = false;
    notifyListeners();
  }

  List<Language> get languages => _languages;

  Future<Language?> getById() async {
    int id = 2;
    return _helper.getById(id);
  }
}
