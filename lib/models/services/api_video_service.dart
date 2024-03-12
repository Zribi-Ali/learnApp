import 'package:http/http.dart' as http;

import 'api_links.dart';

class ApiVideoService {
  Future<String?> getIdLesson(int id) async {
    try {
      http.Response response = await http.get(
          Uri.parse(ApiLinks.videoUrl + "/$id"),
          headers: {'Authorization': ApiLinks.token});
      print(response.body);
      if (response.statusCode == 200) {
        return response.body;
      }
      return null;
    } catch (e) {
      print("Video Api, get by lesson id method The following error occurred " +
          e.toString());
      return null;
    }
  }
}
