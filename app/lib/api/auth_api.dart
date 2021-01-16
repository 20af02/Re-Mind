import 'dart:convert';
import 'package:http/http.dart' as http;
import "index.dart" as Api;

class AuthApi {
  static var _singleton;
  String get url => Api.url;
  AuthApi._internal();

  factory AuthApi() {
    if (_singleton == null) {
      _singleton = AuthApi._internal();
    }
    return _singleton;
  }

  //Endpoints
  Future<String> signup(String phoneNumber, String password) async {
    final Map<String, String> map = {
      "phoneNumber": phoneNumber,
      "password": password
    };

    final String body = jsonEncode(map);
    final response = await http.post(url + "/api/auth/signup", body: body, headers: Api.headers);

    if (response.statusCode == 200) {
      Api.updateCookie(response);
      return response.body;
    } else {
      throw (response.body);
    }
  }

  Future<String> login_with_password(String username, String password) async {
    final Map<String, String> map = {
      "username": username,
      "password": password
    };

    final String body = jsonEncode(map);
    final response = await http.post(url + "/api/auth/login", body: body, headers: Api.headers);

    if (response.statusCode == 200) {
      Api.updateCookie(response);
      return (json.decode(response.body));
    } else {
      throw (response.body);
    }
  }

    Future<String> login_with_face(String base64, String fileName) async {
    final Map<String, String> map = {
      "base64": base64,
      "fileName": fileName
    };

    final String body = jsonEncode(map);
    final response = await http.post(url + "/api/auth/login_face", body: body, headers: Api.headers);

    if (response.statusCode == 200) {
      // Api.updateCookie(response);
      return (json.decode(response.body));
    } else {
      throw (response.body);
    }
  }


  Future<String> sign_up(String username, String password, String firstName, {String base64, String fileName}) async {
    final Map<String, String> map = {
      "base64": base64,
      "fileName": fileName,
      "username": username,
      "password": password,
      "firstName": firstName
    };

    final String body = jsonEncode(map);
    final response = await http.post(url + "/api/auth/signup", body: body, headers: Api.headers);

    if (response.statusCode == 200) {
      // Api.updateCookie(response);
      return (json.decode(response.body));
    } else {
      throw (response.body);
    }
  }
}
