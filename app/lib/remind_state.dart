import 'dart:io';
import 'dart:typed_data';

import 'package:azblob/azblob.dart';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

class Remind {
  static var _singleton;
  // static String ngrok = "http://c924e91ed0cf.ngrok.io";
  static String ngrok = "http://45.79.199.42:8003";
  
  Remind._internal();

  factory Remind() {
    if (_singleton == null) {
      _singleton = Remind._internal();
    }
    return _singleton;
  }

  Future<String> uploadFile2(path) async {
    var request = http.MultipartRequest('POST', Uri.parse('${ngrok}/file_upload'));
    request.files.add(await http.MultipartFile.fromPath('file', path));
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String url = await response.stream.bytesToString();
      print("print: response: ${url}");
      return url;
    }
    else {
      print(response.reasonPhrase);
      throw Exception("Failed to upload image and get url ${response.reasonPhrase}");
    }
  }

  Future<String> detect(path) async {
    var request = http.MultipartRequest('POST', Uri.parse('${ngrok}/file_upload'));
    request.files.add(await http.MultipartFile.fromPath('file', path));
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String url = await response.stream.bytesToString();
      print("print: response: ${url}");
      return url;
    }
    else {
      print(response.reasonPhrase);
      throw Exception("Failed to upload image and get url ${response.reasonPhrase}");
    }
  }

}
