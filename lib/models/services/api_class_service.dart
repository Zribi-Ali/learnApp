

import 'package:http/http.dart' as http;

import 'api_links.dart';

class ApiClassService{
  final  url = Uri.parse(ApiLinks.classUrl);

  Future<String?> get() async{
    try {
      http.Response response = await http.get(url,
          headers: {
            'Authorization': ApiLinks.token
          });
      // a successful request
      if(response.statusCode == 200){
        return response.body;
      }
      return null ;

    } catch (e) {
      print("Class Api, get method The following error occurred " +e.toString());
      return null ;
    }
  }

  Future<String?> getById(int id) async {
    String newUrl = ApiLinks.classUrl + "/$id";
    try {
      http.Response response = await http.get(Uri.parse(newUrl),
          headers: {
            'Authorization': ApiLinks.token
          });
      if (response.statusCode == 200) {
        print("Get by id class success " + response.body);
      }
      return response.body;
    } catch (e) {
      print("class Api,Get by id The following error occurred" + e.toString());
      return null;
    }
  }

}