import 'dart:convert';

import '../services/api_auth_service.dart';

class AuthHelper {
  final _api = ApiAuthService();

  Future<bool?> resendConfirmation(String email) async {
    var result = await _api.resendConfirmation(email);
    if (result != null) {
      var jsonResult = json.decode(result);
      if (jsonResult) {
        return true;
      } else {
        return false;
      }
    } else {
      print("inside auth helper resend confirmation error occurred");
      return null;
    }
  }

  verifConfirmation(String email, String code) async {
    print("verif confirmation inside helper");
    String? result = await _api.verifConfirmation(email, code);
    if (result != null) {
      var jsonResult = json.decode(result);
      if (jsonResult) {
        return true;
      } else {
        return false;
      }
    } else {
      print("inside auth helper verify confirmation error occurred");
      return null;
    }
  }

  changePass(String pass, String email, String code) async {
    Map<String, dynamic> body = {"email": email, "pass": pass, "code": code};

    var result = await _api.changePass(json.encode(body));
    if (result != null) {
      var jsonResult = json.decode(result);
      if (jsonResult) {
        return true;
      } else {
        return false;
      }
    } else {
      print("inside auth helper change pass error occurred");
      return null;
    }
  }
}
