import 'package:flutter/material.dart';
import 'package:app/widgets/people_widget.dart';

import 'cam/RemindCam.dart';

class PeoplePage extends StatefulWidget {
  PeoplePage({Key key}) : super(key: key);

  final String title = "People Page";

  @override
  _PeoplePageState createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: onRememberPerson, child: Icon(Icons.add)),
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.brown,
      ),
      body:
          /*Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Text(widget.title),
            PeopleWidget(),
          ],
        ),
      ),*/
          PeopleWidget(),
    );
  }

  void onRememberPerson() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RemindCam(RemindType.person, "Remember Someone")
      ),
    );

    
  }
}
