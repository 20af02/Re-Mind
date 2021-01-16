
import 'package:flutter/material.dart';

class ItemPage extends StatefulWidget {
  ItemPage({Key key}) : super(key: key);

  final String title = "Items Page";

  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {


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
