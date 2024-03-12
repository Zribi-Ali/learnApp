import 'dart:convert';

import '../core/user.dart';
import '../services/api_user_service.dart';

class UserHelper {
  final _api = ApiUserService();

  Future<Map<String, User>?> logIn(String pass, String email) async {
    String body = json.encode({"email": email, "pass": pass});
    var result = await _api.logIn(body);
    if (result != null) {
      return createUserData(result);
    } else {
      print("User helper, log in null value returned");
      return null;
    }
  }
/*
  Future<Map<String, User>?> logIn(String pass, String id) async {
    String body = json.encode({"Id": id, "pass": pass});
    var result = await _api.logIn(body);
    if (result != null) {
      return createUserData(result);
    } else {
      print("User helper, log in null value returned");
      return null;
    }
  }

 */

  Map<String, User> createUserData(String result) {
    var jsonResult = json.decode(result);

    Map<String, User> userData = Map<String, User>();
    userData[jsonResult["accessToken"]] = User.fromJson(jsonResult["user"][0]);
    return userData;
  }

  Future<List<User>?> get() async {
    var result = await _api.get();
    if (result != null) {
      return List<User>.from(json.decode(result).map((e) => User.fromJson(e)));
    } else {
      print("User helper, get error occured");
      return null;
    }
  }

  Future<User?> getById(int id) async {
    var result = await _api.getById(id);
    if (result != null) {
      return User.fromJson(json.decode(result)[0]);
    } else {
      print("User helper, get by id error occured");
      return null;
    }
  }

  Future<bool> post(User user) async {
    print("inside helper");
    return _api.post(json.encode(user.toJson()));
  }

  Future<bool> put(User newUser) async {
    print("inside helper");
    return _api.put(json.encode(newUser.toJson()));
  }

  Future<bool> delete(int id) async {
    print("inside helper");
    return _api.delete(id);
  }
}
