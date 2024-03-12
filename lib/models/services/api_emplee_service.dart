import 'package:http/http.dart' as http;

import 'api_links.dart';

class ApiEmpleeService {
  final url = Uri.parse(ApiLinks.employeeUrl);

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
      print("Employee Api,The following error occurred " + e.toString());
      return null;
    }
  }

  Future<String?> getById(int id) async {
    final newUrl = ApiLinks.employeeUrl + "/$id";
    try {
      http.Response response = await http.get(Uri.parse(newUrl),
          headers: {
            'Authorization': ApiLinks.token
          }
      );
      if (response.statusCode == 200) {
        return response.body;
      }
      print("Emplyee Get By id failed");
      return null;
    } catch (e) {
      print("Employee Api Get by id, The following error occurred " +
          e.toString());
      return null;
    }
  }
}
