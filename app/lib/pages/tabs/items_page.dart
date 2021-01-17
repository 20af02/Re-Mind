import 'package:app/pages/tabs/cam/RemindCam.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets/item_widget.dart';

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
      floatingActionButton: FloatingActionButton(onPressed: onRememberItem, child: Icon(Icons.add)),
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.brown,
      ),
      body: ItemWidget(),
    );
  }

  void onRememberItem() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RemindCam(RemindType.thing, "Remember Something")
      ),
    );
  }
}
