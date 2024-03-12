import 'package:http/http.dart' as http;

import 'api_links.dart';

class ApiStudentCourseService {
  final url = Uri.parse(ApiLinks.studentCourseUrl);

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
      print(
          "Student Course Api,Get The following error occurred" + e.toString());
      return null;
    }
  }

  Future<String?> getById(int id) async {
    String newUrl = ApiLinks.studentCourseUrl + "/$id";
    try {
      http.Response response = await http.get(Uri.parse(newUrl),
          headers: {
            'Authorization': ApiLinks.token
          }
      );
      return response.body;
    } catch (e) {
      print("Student course Api,Get by id The following error occurred" +
          e.toString());
      return null;
    }
  }

   Future<bool> post(String body) async {
    try {
      http.Response response = await http.post(
          url,
          body: body,
          headers: <String, String>{
            "Accept": "application/json",
            "content-type": "application/json",
            'Authorization': ApiLinks.token
          });
      if (response.statusCode == 200) {
        print("Post Student course success");
        return true;
      }
      print("Post failure " + response.body);
      return false;
    } catch (e) {
      print("Student course Api Post, The following error occurred" + e.toString());
      return false;
    }
  }
}
