import 'package:flutter/material.dart';
import 'package:app/pages/tabs/people_page.dart';
import 'package:app/pages/signup_page.dart';

class PopupPeople extends StatefulWidget {
  PopupPeople({Key key}) : super(key: key);

  final String title = "Landing Page";

  @override
  _PopupPeopleState createState() => _PopupPeopleState();
}

class _PopupPeopleState extends State<PopupPeople> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(children: <Widget>[
            Container(
              alignment: Alignment.center,
              //insert logging info here do later
            ),
            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(0),
                child: Text(
                  'New Face',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown[200]),
                )),
            Container(
              padding: EdgeInsets.all(0),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Edit Name',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(0),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Edit Last Name',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(0),
              child: TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                ),
              ),
            ),
            Container(
                height: 50,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: RaisedButton(
                  textColor: Colors.white,
                  color: Colors.brown[200],
                  child: Text('Save'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => (PeoplePage()),
                      ),
                    );
                    print(nameController.text);
                    print(passwordController.text);
                    print(descriptionController);
                  },
                )),
            Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                  Column(children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        'Interaction Log',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown[200]),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(32),
                      child: Text('Jan 17 1:09AM',
                          softWrap: true, textAlign: TextAlign.center),
                    )
                  ]),
                ])),
          ])),
    );
  }
}
