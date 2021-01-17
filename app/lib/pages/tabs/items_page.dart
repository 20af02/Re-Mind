import 'package:flutter/material.dart';
import 'package:app/widgets/item_widget.dart';

class ItemPage extends StatefulWidget {
  ItemPage({Key key}) : super(key: key);

  final String title = "Peoples Page";

  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          ItemWidget(),
    );
  }
}
