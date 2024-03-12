import 'api_links.dart';
import 'package:http/http.dart' as http;

class ApiLessonService {
  final url = Uri.parse(ApiLinks.lessonUrl);

  Future<String?> get() async {
    try {
      http.Response response = await http.get(url,
          headers: {
            'Authorization': ApiLinks.token
          }
      );
      print(response.body);

      if (response.statusCode == 200) {
        return response.body;
      }
      return null ;
    } catch (e) {
      print("Lesson Api Get, The following error occurred " + e.toString());
      return null;
    }
  }
  // Lesson by id is weird => the information are incompatible with the needed model
  // Future<String?> getById(int id) async {
  //   final newUrl = ApiLinks.lessonUrl+ "/$id";
  //   try {
  //     http.Response response = await http.get(Uri.parse(newUrl));
  //     if (response.statusCode == 200) {
  //       return response.body;
  //     }
  //     return null;
  //   } catch (e) {
  //     print("Lesson Api Get by id, The following error occurred " +
  //         e.toString());
  //     return null;
  //   }
  // }
}
