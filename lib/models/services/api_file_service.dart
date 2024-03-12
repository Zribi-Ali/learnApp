import 'package:http/http.dart' as http;

import 'api_links.dart';

class ApiFileService {
  Future<String?> getByIdStream(int id) async {
    final newUrl = ApiLinks.fileForStreamUrl + "?id=$id";
    try {
      http.Response response = await http
          .get(Uri.parse(newUrl), headers: {'Authorization': ApiLinks.token});
      if (response.statusCode == 200) {
        return response.body;
      }
      return null;
    } catch (e) {
      print("File Api Get by id stream, The following error occurred " +
          e.toString());
      return null;
    }
  }

  Future<String?> getByIdLesson(int id) async {
    print("*************************** $id");
    final newUrl = ApiLinks.fileForLessonUrl + "/$id";
    try {
      http.Response response = await http
          .get(Uri.parse(newUrl), headers: {'Authorization': ApiLinks.token});
      if (response.statusCode == 200) {
        return response.body;
      }
      return null;
    } catch (e) {
      print("File Api Get by id lesson, The following error occurred " +
          e.toString());
      return null;
    }
  }
}
