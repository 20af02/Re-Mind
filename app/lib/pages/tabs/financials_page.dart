
import 'package:flutter/material.dart';

class FinancialsPage extends StatefulWidget {
  FinancialsPage({Key key}) : super(key: key);

  final String title = "Financial Page";

  @override
  _FinancialsPageState createState() => _FinancialsPageState();
}

class _FinancialsPageState extends State<FinancialsPage> {

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
