import 'package:flutter/material.dart';

// codes and languages name must be synchronized. 
class Languages{
  static final codes = [
    const Locale('ar',''),
    const Locale('en',''),
    //const Locale('fr',''),
    
  ];

  static final names = [
    "العربية",
    "English",
    //"français",
    
  ];
}

// a changeNotifier is an example of a state source that behaves as a model
class LocaleProvider extends ChangeNotifier{
  Locale? _locale ;

  void testingprovider(String text){
    print("to set language: " +text);
  }
  Locale get locale {
    if(_locale == null) return Languages.codes[0];
    return _locale!;
  } 

  void setLocale(Locale locale){
    if(!Languages.codes.contains(locale)){
      print("locale not found");
      return;
    }
    _locale = locale ;
    print("local changed");
    notifyListeners();
  }

 
}