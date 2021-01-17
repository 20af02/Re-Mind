import 'dart:io';
import 'dart:typed_data';
import 'package:app/pages/tabs/tabs.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PreviewLoginPage extends StatefulWidget {
  final String imgPath;
  final String fileName;
  PreviewLoginPage({this.imgPath, this.fileName});

  @override
  _PreviewLoginPageState createState() => _PreviewLoginPageState();
}

class _PreviewLoginPageState extends State<PreviewLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text("Unlock with FaceId"),
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Image.file(
                  File(widget.imgPath),
                  fit: BoxFit.cover,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlatButton(
                      minWidth: 200,
                      height: 50,
                      color: Colors.blue,
                      child: Text("Login"),
                      onPressed: onLogin,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  void onLogin() {
    getBytes().then((bytes) {
      //Todo send to api to see if account exists
      print('here now');
      print(widget.imgPath);
      print(bytes.buffer.asUint8List());
      // Share.file('Share via', widget.fileName,
      //     bytes.buffer.asUint8List(), 'image/path');

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Tabs(),
        ),
      );
    });
  }

  Future getBytes() async {
    Uint8List bytes = File(widget.imgPath).readAsBytesSync() as Uint8List;
//    print(ByteData.view(buffer))
    return ByteData.view(bytes.buffer);
  }
}
