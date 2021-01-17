import 'dart:io';

import 'package:app/models/remind_models.dart';
import 'package:app/pages/tabs/people_page.dart';
import 'package:app/pages/tabs/tabs.dart';
import 'package:app/remind_state.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets/photo_logo.dart';
import 'package:app/pages/tabs/cam_page.dart';
import 'package:app/pages/login_page.dart';

class AddPersonPage extends StatefulWidget {
  final String path;
  AddPersonPage(this.path) : super(key: Key(path));

  @override
  AddPersonPageState createState() => AddPersonPageState();
}

class AddPersonPageState extends State<AddPersonPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController relationController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Remember Someone"),
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
                  labelText: 'Person Name',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: relationController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Relation',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                maxLines: 5,
                controller: notesController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Notes',
                ),
              ),
            ),

            Container(
              height: 50,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: RaisedButton(
                  textColor: Colors.white,
                  color: Colors.brown[200],
                  child: Text('Remember Person'),
                  onPressed: onAddPerson),
            ),
          ],
        ),
      ),
    );
  }

  void onAddPerson() async {
    String url = await Remind().uploadFile2(this.widget.path);
    Person person = Person(name: nameController.text, path: this.widget.path );
    rememberPerson(person);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Tabs(initialIndex: 1),
      ),
    );
  }
}
