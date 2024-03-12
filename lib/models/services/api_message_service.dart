import 'package:http/http.dart' as http;

import 'api_links.dart';

class ApiMessageService {
  final url = Uri.parse(ApiLinks.messageUrl);

  Future<String?> get() async {
    try {
      http.Response response = await http.get(url,
          headers: {
            'Authorization': ApiLinks.token
          }
      );

      if (response.statusCode == 200) {
        return response.body;
      }
      return null;
    } catch (e) {
      print("Message Api Get, The following error occurred" + e.toString());
      return null;
    }
  }

  Future<String?> getById(int id) async {
    String newUrl = ApiLinks.messageUrl + "/$id";
    try {
      http.Response response = await http.get(Uri.parse(newUrl),
          headers: {
            'Authorization': ApiLinks.token
          }
      );
      if (response.statusCode == 200){
        return response.body;
      }
      return null;
    } catch (e) {
      print(
          "Message Api Get by id, The following error occurred" + e.toString());
      return null;
    }
  }

  Future<String?> getByDiscussionId(int id) async {
    String newUrl = ApiLinks.messageUrl + "/messagesByDiscussion/$id";
    try {
      http.Response response = await http.get(Uri.parse(newUrl),
          headers: {
            'Authorization': ApiLinks.token
          }
      );
      if (response.statusCode == 200) {
        return response.body;
      }
      return null;
    } catch (e) {
      print(
          "Message Api Get by id Discussion , The following error occurred" + e.toString());
      return null;
    }
  }

  Future<bool> post(String body) async {
    try {
      http.Response response = await http.post(url,
          body: body,
          headers: <String, String>{
            "Accept": "application/json",
            "content-type": "application/json",
            'Authorization': ApiLinks.token

          });
      if (response.statusCode == 200) {
        print("Post Message success "+response.body);
        return true;
      }
      print("Post Message failure " + response.body);
      return false;
    } catch (e) {
      print("Message Api Post, The following error occurred" + e.toString());
      return false;
    }
  }
}
