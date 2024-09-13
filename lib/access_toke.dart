import 'package:http/http.dart' as http;
import 'dart:convert';

class AccessToken {
  AccessToken() {
    response = apicall().then((value) {
      return (value["access_token"].toString());
    });
  }

  late Future<dynamic> response;


  Map<String, dynamic> body = {
    "grant_type": "client_credentials",
    "client_id":
        "",
    "client_secret":
        ""
  };

  Future<dynamic> apicall() async {
    String formData = Uri(queryParameters: body).query;
    http.Response data = await http.post(
      Uri.parse("https://outpost.mappls.com/api/security/oauth/token"),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      body: formData.toString(),
    );
    return jsonDecode(data.body);
  }
}
