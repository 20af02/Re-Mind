import 'package:app/pages/tabs/tabs.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:app/pages/login_page.dart';

List<CameraDescription> cameras;
Future<void> main() async {
  // initialize the cameras when the app starts
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();

  // running the app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Re-Mind',
      home: LoginPage(),
    );
  }
}
