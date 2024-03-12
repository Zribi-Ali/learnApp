import 'api_links.dart';
import 'package:http/http.dart' as http;

class ApiDiscussionService {
  final url = Uri.parse(ApiLinks.discussionUrl);

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
      print("Discussion Api,Get The following error occurred" + e.toString());
      return null;
    }
  }

  Future<String?> getById(int id) async {
    String newUrl = ApiLinks.discussionUrl + "/$id";
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
      print("Discussion Api,Get by id The following error occurred" +
          e.toString());
      return null;
    }
  }

  Future<String?> getByIdUser(int idUser) async {
    String newUrl = ApiLinks.discussionUrl + "/GetByUser/$idUser";
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
      print("Discussion Api get by id User, The following error occurred" +
          e.toString());
      return null;
    }
  }
}
