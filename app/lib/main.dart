import 'package:app/pages/tabs/tabs.dart';
import 'package:app/services/facenet.service.dart';
import 'package:app/services/ml_vision_service.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:app/pages/login_page.dart';

// Services injection
FaceNetService _faceNetService = FaceNetService();
MLVisionService _mlVisionService = MLVisionService();

Future<void> main() async {
  // initialize the cameras when the app starts
  WidgetsFlutterBinding.ensureInitialized();

  await _startUp();
  // running the app
  runApp(MyApp());
}

_startUp() async {
  // start the services
  await _faceNetService.loadModel();
  _mlVisionService.initialize();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Re-Mind',
      home: LoginPage(),
      // home: Tabs(),
      // home: Tabs(),
    );
  }
}
