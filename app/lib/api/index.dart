import 'package:http/http.dart' as http;

import 'auth_api.dart';

const String LOCAL_URL = "http://localhost:9080";
const String REMOTE_URL = "https://litmaps.herokuapp.com";
const bool TESTING = false;
const bool DEBUG = true;

Map<String, String> _cookies = {};
// String _cookies = "";

AuthApi auth = new AuthApi();
// UserApi user = new UserApi();

String get url => TESTING ? LOCAL_URL : REMOTE_URL;
String get cookies => _generateCookieHeader();
Map<String, String> get headers => {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    "cookie": cookies
};
// void updateCookie(http.Response response) {
//   String rawCookie = response.headers['set-cookie'];
//   if (rawCookie != null) {
//     int index = rawCookie.indexOf(';');
//     _cookies = (index == -1) ? rawCookie : rawCookie.substring(0, index);
//   }
//   print(rawCookie);
// }

String _generateCookieHeader() {
  String cookie = "";

  for (var key in _cookies.keys) {
    if (cookie.length > 0) cookie += ";";
    cookie += key + "=" + _cookies[key];
  }

  return cookie;
}

void _setCookie(String rawCookie) {
  if (rawCookie.length > 0) {
    var keyValue = rawCookie.split('=');
    if (keyValue.length == 2) {
      var key = keyValue[0].trim();
      var value = keyValue[1];

      // ignore keys that aren't cookies
      if (key == 'path' || key == 'expires') return;

      _cookies[key] = value;
    }
  }
}

void updateCookie(http.Response response) {
  String allSetCookie = response.headers['set-cookie'];

  if (allSetCookie != null) {
    var setCookies = allSetCookie.split(',');

    for (var setCookie in setCookies) {
      var cookies = setCookie.split(';');

      for (var cookie in cookies) {
        _setCookie(cookie);
      }
    }
  }
}

void setCookies(String cookiesToSet) {
  _cookies = {};

  if (cookiesToSet != null) {
    var setCookies = cookiesToSet.split(',');

    for (var setCookie in setCookies) {
      var cookies = setCookie.split(';');

      for (var cookie in cookies) {
        _setCookie(cookie);
      }
    }
  }
}