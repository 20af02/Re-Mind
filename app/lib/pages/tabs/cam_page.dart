import 'package:app/pages/tabs/cam/live_camera.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import './cam/camera.dart';

typedef void Callback(List<dynamic> list, int h, int w);

class CamPage extends StatefulWidget {
  final String title = "Camera Page";
  // final Widget widget;
  // CamPage();

  @override
  _CamPageState createState() => _CamPageState();
}

class _CamPageState extends State<CamPage> {
  int cameraIndex = 1;
  
  @override
  Widget build(BuildContext context) {
    print("print: building");
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: LiveFeed(),
      // body: CameraScreen(),
      // body: widget.widget,
    );
  }
}
