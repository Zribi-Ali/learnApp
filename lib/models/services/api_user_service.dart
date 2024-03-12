import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_links.dart';

class ApiUserService {
  final url = Uri.parse(ApiLinks.userUrl);

  Future<String?> logIn(String body) async {
    //Uri url = Uri.parse(ApiLinks.authMobileLogInUrl);
    Uri url = Uri.parse(ApiLinks.loginUrl);
    try {
      http.Response response =
          await http.post(url, body: body, headers: <String, String>{
        "Accept": "application/json",
        "content-type": "application/json",
        'Authorization': ApiLinks.token
      });
      if (response.statusCode == 200) {
        print("Log in success");
        return response.body;
      }

      print("Log in Failure with response : ${response.body}");
      return null;
    } catch (e) {
      print("User Api log in, The following error occurred" + e.toString());
      return null;
    }
  }

  Future<bool> put(String body) async {
    try {
      http.Response response =
          await http.put(url, body: body, headers: <String, String>{
        "Accept": "application/json",
        "content-type": "application/json",
        'Authorization': ApiLinks.token
      });

      if (response.statusCode == 200) {
        print("-------------------------------------------------------");
        print("Put User success");
        return true;
      }
      print("put failure " + response.body);
      return false;
    } catch (e) {
      print("User Api Put, The following error occurred" + e.toString());
      return false;
    }
  }

  Future<String?> get() async {
    try {
      http.Response response =
          await http.get(url, headers: {'Authorization': ApiLinks.token});

      if (response.statusCode == 200) {
        return response.body;
      }
      return null;
    } catch (e) {
      print("User Api,Get The following error occurred" + e.toString());
      return null;
    }
  }

  Future<String?> getById(int id) async {
    String newUrl = ApiLinks.userUrl + "/$id";
    try {
      http.Response response = await http
          .get(Uri.parse(newUrl), headers: {'Authorization': ApiLinks.token});
      if (response.statusCode == 200) {
        print("Get by id User success " + response.body);
      }
      return response.body;
    } catch (e) {
      print("User Api,Get by id The following error occurred" + e.toString());
      return null;
    }
  }

  Future<bool> post(String body) async {
    try {
      http.Response response = await http.post(
          Uri.parse(ApiLinks.authAppSignUpUrl),
          body: body,
          headers: <String, String>{
            "Accept": "application/json",
            "content-type": "application/json",
          });
      if (response.statusCode == 200) {
        if (jsonDecode(response.body) == 202) {
          print("Post User success");
          return true;
        }
      }
      print("post failure " + response.body);
      return false;
    } catch (e) {
      print("User Api,Post The following error occurred " + e.toString());
      return false;
    }
  }

  Future<bool> delete(int id) async {
    String newUrl = ApiLinks.userUrl + "/$id";
    try {
      http.Response response =
          await http.delete(Uri.parse(newUrl), headers: <String, String>{
        "Accept": "application/json",
        "content-type": "application/json",
        'Authorization': ApiLinks.token
      });
      if (response.statusCode == 200) {
        print("Delete user success");
        return true;
      }
      print("delete failure " + response.body);
      return false;
    } catch (e) {
      print("User Api delete, The following error occurred " + e.toString());
      return false;
    }
  }
}
