import 'package:http/http.dart' as http;

import 'api_links.dart';

class ApiCityService {
  final  url = Uri.parse(ApiLinks.cityUrl);


  Future<String?> get() async {
    try {
      
      http.Response response = await http.get(url,
          headers: {
            'Authorization': ApiLinks.token
          });
      
      if (response.statusCode == 200) {
        return response.body;
      }
      return null ;
    } catch (e) {
      print("City Api,Get The following error occurred" + e.toString());
      return null;
    }
  }

  Future<String?> getById(int id)async {
    String newUrl = ApiLinks.cityUrl+"/$id" ;
    try {
      http.Response response = await http.get(Uri.parse(newUrl),
          headers: {
        'Authorization': ApiLinks.token
      });
      return response.body;
    } catch (e) {
      print("City Api,Get by id The following error occurred" + e.toString());
      return null;
    }
  }


  
}
