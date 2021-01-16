
import 'package:flutter/material.dart';

class PeoplePage extends StatefulWidget {
  PeoplePage({Key key}) : super(key: key);

  final String title = "Peoples Page";

  @override
  _PeoplePageState createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(widget.title),
          ],
        ),
      ),
    );
  }
}
