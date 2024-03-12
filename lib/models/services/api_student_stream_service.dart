import 'package:http/http.dart' as http;
import 'api_links.dart';

class ApiStudentStreamService {
  final url = Uri.parse(ApiLinks.studentStreamUrl);

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
          "Student Stream Api,Get The following error occurred" + e.toString());
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
        print("Post Student Stream success " + response.body);
        return true;
      }
      print("Post Student Stream failure " + response.body);
      return false;
    } catch (e) {
      print("Student Stream Api Post, The following error occurred" +
          e.toString());
      return false;
    }
  }
}
