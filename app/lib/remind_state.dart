import 'dart:io';
import 'dart:typed_data';

import 'package:azblob/azblob.dart';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';

class Remind {
  static var _singleton;
  Remind._internal();

  factory Remind() {
    if (_singleton == null) {
      _singleton = Remind._internal();
    }
    return _singleton;
  }


  Future<String> uploadFile(File _imageFile) async {
    var storage = AzureStorage.parse('your connection string');
    try {
      String fileName = basename(_imageFile.path);
      // read file as Uint8List
      Uint8List content = await _imageFile.readAsBytes();
      var storage = AzureStorage.parse('<storage account connection string>');
      
      String container = "image";

      // get the mine type of the file
      String contentType = lookupMimeType(fileName);

      await storage.putBlob('/$container/$fileName',
          bodyBytes: content,
          contentType: contentType,
          type: BlobType.BlockBlob);
      print("done");
    } on AzureStorageException catch (ex) {
      print(ex.message);
    } catch (err) {
      print(err);
    }
  }


  
}
