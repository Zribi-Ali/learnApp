import 'package:http/http.dart' as http;

import 'api_links.dart';

class ApiNotificationService {
  final url = Uri.parse(ApiLinks.notificationUrl);

  //get
  Future<String?> get() async {
    try {
      http.Response response =
          await http.get(url, headers: {'Authorization': ApiLinks.token});
      // a successful request
      if (response.statusCode == 200) {
        return response.body;
      }
      return null;
    } catch (e) {
      print("Notification Api, get method The following error occurred " +
          e.toString());
      return null;
    }
  }
  //get By ID
  // Does not work => "Courses Empty"
}
