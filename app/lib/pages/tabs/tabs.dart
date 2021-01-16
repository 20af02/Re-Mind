import 'package:app/pages/tabs/people_page.dart';
import 'package:flutter/material.dart';

import 'cam_page.dart';
import 'financials_page.dart';
import 'items_page.dart';
import './cam/camera.dart';

import 'package:camera/camera.dart';

class Tabs extends StatefulWidget {
  final String title = "Re-Mind";
  Tabs();
  // Tabs({Key key}) : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  // Widget cameraScreen = CameraScreen();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown[200],
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.camera_alt), text: "Cam"),
              Tab(icon: Icon(Icons.face), text: "People"),
              Tab(icon: Icon(Icons.favorite), text: "Items"),
              Tab(icon: Icon(Icons.attach_money), text: "financials"),
            ],
          ),
          title:
              /*Text(
            this.widget.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              fontFamily:
            ),
          ),
        ),*/
              Image(
            image: AssetImage('images/remind.png'),
          ),
        ),
        body: TabBarView(
          children: [CamPage(), PeoplePage(), ItemPage(), FinancialsPage()],
        ),
      ),
    );
  }
}
