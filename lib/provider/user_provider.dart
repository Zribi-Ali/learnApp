import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/core/user.dart';
import '../models/helper/user_helper.dart';
import '../models/services/api_links.dart';
import 'city_provider.dart';

class UserProvider extends ChangeNotifier {
  final _helper = UserHelper();
  bool loading = false;
  User? _currentUser;

  String accessToken = "";

  List<User> _users = [];

  List<User> get users => _users;

  initializeUsers() async {
    loading = true;
    _users = (await _helper.get())!;
    loading = false;
    notifyListeners();
  }

  Future<bool> initializeUserData(
      String pass, String email, BuildContext context) async {
    var result = await _helper.logIn(pass, email);
    if (result == null) {
      print("-------------------user not found--------------------------");
      return false;
    } else {
      print(
          "----------------------------user found reading data -----------------------");
      accessToken = result.keys.first;
      _currentUser = result[accessToken];

      ApiLinks.token = "Bearer " + accessToken;

      Provider.of<CityProvider>(context, listen: false)
          .setCity(_currentUser!.idCity);
      notifyListeners();
      return true;
    }
  }

  Future<User> getById(int id) async {
    return (await _helper.getById(id))!;
  }

// all information of current user
  User get user {
    return _currentUser!;
  }

  setUser(User user) {
    _currentUser = user;
    print("user changed : $user");
    notifyListeners();
  }

  update(User newUser, BuildContext context) async {
    bool updateResult = await _helper.put(newUser);
    print("------------------------------------------------------------");
    print("inside update method user provider : result is $updateResult");
    if (updateResult == true) {
      setUser(newUser);
      await Provider.of<CityProvider>(context, listen: false)
          .setCity(newUser.idCity);
    }
    return updateResult;
  }

  Future<bool> signUpNewUser(User user) async {
    print("inside provider");
    return await _helper.post(user);
  }

  Future<bool> deleteUser() async {
    print("inside provider");
    return _helper.delete(_currentUser!.id);
  }
}
