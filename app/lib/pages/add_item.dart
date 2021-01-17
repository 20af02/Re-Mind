import 'dart:io';

import 'package:app/models/remind_models.dart';
import 'package:app/pages/tabs/items_page.dart';
import 'package:app/pages/tabs/tabs.dart';
import 'package:app/remind_state.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets/photo_logo.dart';
import 'package:app/pages/tabs/cam_page.dart';
import 'package:app/pages/login_page.dart';

class AddItemPage extends StatefulWidget {
  final String path;
  AddItemPage(this.path) : super(key: Key(path));

  @override
  AddItemPageState createState() => AddItemPageState();
}

class AddItemPageState extends State<AddItemPage> {
  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController notesController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Remember Something"),
        backgroundColor: Colors.brown,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 100,),
            Image.file(File(this.widget.path), width: 200, height: 200, fit: BoxFit.cover,),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Item Name',
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: notesController,
                maxLines: 5,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Item Notes',
                ),
              ),
            ),

            Container(
              height: 50,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: RaisedButton(
                  textColor: Colors.white,
                  color: Colors.brown[200],
                  child: Text('Remember Item'),
                  onPressed: onAddPerson),
            ),
          ],
        ),
      ),
    );
  }

  void onAddPerson() async {
    String url = await Remind().uploadFile2(this.widget.path);
    Item item = Item(name: nameController.text, path: this.widget.path, notes: notesController.text);
    rememberItem(item);

    nameController.text = "";
    notesController.text = "";

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Tabs(initialIndex: 2),
      ),
    );
  }
}
