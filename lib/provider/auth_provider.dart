import 'package:flutter/cupertino.dart';

import '../models/helper/auth_helper.dart';

class AuthProvider extends ChangeNotifier {
  final _helper = AuthHelper();

  // post
  Future<bool?> resendConfirmation(String email) async {
    print("inside resend confirmation");
    return await _helper.resendConfirmation(email);
  }

  //get
  Future<bool?> verifConfirmation(String email, String code) async {
    print("inside verif confirmation");
    return await _helper.verifConfirmation(email, code);
  }

  Future<bool?> changePass(String pass, String email, String code) async {
    print("inside change pass");
    return await _helper.changePass(pass, email, code);
  }
}
