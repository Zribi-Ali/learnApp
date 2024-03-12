import 'api_links.dart';
import 'package:http/http.dart' as http;

class ApiStreamService {
  final url = Uri.parse(ApiLinks.streamsUrl);

  Future<String?> get() async {
    try {
      http.Response response =
          await http.get(url, headers: {'Authorization': ApiLinks.token});
      if (response.statusCode == 200) {
        return response.body;
      }
      return null;
    } catch (e) {
      print("Stream Api Get, The following error occurred " + e.toString());
      return null;
    }
  }

  Future<String?> UserHaveStream(int iduser, int idStream) async {
    try {
      http.Response response = await http.get(
          Uri.parse(
              ApiLinks.userHaveStream + "?idUser=$iduser&idStream=$idStream"),
          headers: {'Authorization': ApiLinks.token});
      if (response.statusCode == 200) {
        return response.body;
      }
      return null;
    } catch (e) {
      print("Stream Api Get, The following error occurred " + e.toString());
      return null;
    }
  }

  Future<String?> getStreamsForUserToday(int idUser) async {
    print("inside get streams for user today API");
    final newUrl =
        Uri.parse(ApiLinks.streamsUrl + "/streambyUserToday?idUser=$idUser");
    print(ApiLinks.streamsUrl + "/streambyUserToday?idUser=$idUser");
    try {
      http.Response response =
          await http.get(newUrl, headers: {'Authorization': ApiLinks.token});
      //print(response);
      if (response.statusCode == 200) {
        print(
            "get streams for user today ------------- response body is ${response.body} -------------------");
        return response.body;
      }
      print(
          "get streams for user today -------------------- Failure response body is ${response.statusCode} --------------------");

      return null;
    } catch (e) {
      print(
          "Stream Api Get streams for user today , The following error occurred " +
              e.toString());
      return null;
    }
  }

  Future<String?> getById(int id) async {
    final newUrl = ApiLinks.streamsUrl + "/$id";
    try {
      http.Response response = await http
          .get(Uri.parse(newUrl), headers: {'Authorization': ApiLinks.token});
      if (response.statusCode == 200) {
        return response.body;
      }
      return null;
    } catch (e) {
      print(
          "Stream Api Get by id, The following error occurred " + e.toString());
      return null;
    }
  }
}
