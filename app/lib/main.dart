import 'package:app/pages/landing_page.dart';
import 'package:flutter/material.dart';
Future<void> main() async {  
  // running the app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
      home: LandingPage(),
    );
  }
}
