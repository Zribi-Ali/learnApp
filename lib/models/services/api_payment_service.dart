import 'package:http/http.dart' as http;

import 'api_links.dart';

class ApiPaymentService {
  final url = Uri.parse(ApiLinks.paymentUrl);

  Future<bool> put(String body) async {
    try {
      http.Response response = await http.put(url,
          body: body,
          headers: <String, String>{
            "Accept": "application/json",
            "content-type": "application/json",
            'Authorization': ApiLinks.token
          });

      if (response.statusCode == 200) {
        print("Put payment success");
        return true;
      }
      print("put failure " + response.body);
      return false;
    } catch (e) {
      print("payment Api Put, The following error occurred" + e.toString());
      return false;
    }
  }

  Future<bool> addCard(String cardInfoCrepted, int userId) async {
    Uri url = Uri.parse(
        ApiLinks.paymentUrl + "/addCard?user=$userId&card=4$cardInfoCrepted");

    try {
      http.Response response = await http.put(url, headers: <String, String>{
        "Accept": "application/json",
        "content-type": "application/json",
        'Authorization': ApiLinks.token

      });

      if (response.statusCode == 200) {
        print("add card success");
        return true;
      }
      print("add card failure " + response.body);
      return false;
    } catch (e) {
      print(
          "payment Api add card, The following error occurred" + e.toString());
      return false;
    }
  }

  Future<String?> getCard(Map<String, dynamic> params) async {
    Uri url = Uri.parse(ApiLinks.paymentUrl + "/getCard");

    url.replace(queryParameters: params);
    try {
      http.Response response = await http.get(url,
          headers: {
            'Authorization': ApiLinks.token
          }
      );

      if (response.statusCode == 200) {
        return response.body;
      }
      print("get card failed with response : " + response.body);
      return null;
    } catch (e) {
      print("payment Api,Get card The following error occurred" + e.toString());
      return null;
    }
  }

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
      print("get payment failed with response : " + response.body);
      return null;
    } catch (e) {
      print("payment Api,Get The following error occurred" + e.toString());
      return null;
    }
  }

  Future<String?> getById(int id) async {
    String newUrl = ApiLinks.paymentUrl + "/$id";
    try {
      http.Response response = await http.get(Uri.parse(newUrl),
          headers: {
            'Authorization': ApiLinks.token
          }
      );
      if (response.statusCode == 200) {
        print("Get by id payment success " + response.body);
      }
      print("get by id payment failed with response : " + response.body);

      return null;
    } catch (e) {
      print(
          "payment Api,Get by id The following error occurred" + e.toString());
      return null;
    }
  }

  Future<bool> post(String body) async {
    try {
      http.Response response = await http.post(url,
          body: body,
          headers: <String, String>{
            "Accept": "application/json",
            "content-type": "application/json",
            'Authorization': ApiLinks.token
          });
      if (response.statusCode == 200) {
        print("Post payment success");
        return true;
      }
      print("post failure " + response.body);
      return false;
    } catch (e) {
      print("payment Api,Post The following error occurred " + e.toString());
      return false;
    }
  }

  Future<bool> delete(int id) async {
    String newUrl = ApiLinks.paymentUrl + "/$id";
    try {
      http.Response response = await http.delete(Uri.parse(newUrl),
          headers: <String, String>{
            "Accept": "application/json",
            "content-type": "application/json",
            'Authorization': ApiLinks.token
          });
      if (response.statusCode == 200) {
        print("Delete payment success");
        return true;
      }
      print("delete failure " + response.body);
      return false;
    } catch (e) {
      print("payment Api delete, The following error occurred " + e.toString());
      return false;
    }
  }
}
