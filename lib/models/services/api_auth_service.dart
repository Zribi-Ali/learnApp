import 'package:http/http.dart' as http;

import 'api_links.dart';

class ApiAuthService {
  Future<String?> resendConfirmation(String email) async {
    Uri url = Uri.parse(ApiLinks.authResendConfirmationUrl + "?email=$email");
    try {
      http.Response response =
          await http.post(url, headers: {'Authorization': ApiLinks.token});

      if (response.statusCode == 200) {
        return response.body;
      }
      return null;
    } catch (e) {
      print("Auth Api, resend confirmation The following error occurred" +
          e.toString());
      return null;
    }
  }

  Future<String?> verifConfirmation(String email, String code) async {
    Uri url = Uri.parse(
        ApiLinks.authVerifConfirmationUrl + "?email=$email&code=2225");
    try {
      http.Response response = await http.get(url, headers: {});

      if (response.statusCode == 200) {
        return response.body;
      }
      print("verify confirmation error inside Api + ${response.body}");
    } catch (e) {
      print("Api auth,verify confirmation The following error occurred" +
          e.toString());
      return null;
    }
  }

  Future<String?> changePass(String body) async {
    Uri url = Uri.parse(ApiLinks.authChangePassUrl);
    try {
      http.Response response =
          await http.put(url, body: body, headers: <String, String>{
        "Accept": "application/json",
        "content-type": "application/json",
        'Authorization': ApiLinks.token
      });

      if (response.statusCode == 200) {
        return response.body;
      }
      return null;
    } catch (e) {
      print("change pass Api The following error occurred" + e.toString());
      return null;
    }
  }
}
