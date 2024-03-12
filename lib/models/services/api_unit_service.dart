import 'api_links.dart';
import 'package:http/http.dart' as http;

class ApiUnitService{
  final url = Uri.parse(ApiLinks.unitUrl);

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
      print("Unit Api Get, The following error occurred " + e.toString());
      return null;
    }
  }
  Future<String?> getById(int id) async {
    final newUrl = ApiLinks.unitUrl+ "/$id";
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
      print("Unit Api Get by id, The following error occurred " +
          e.toString());
      return null;
    }
  }

  // get unite by course
}