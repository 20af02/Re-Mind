import 'package:flutter/material.dart';
import 'package:app/pages/tabs/people_page.dart';
import 'package:app/pages/signup_page.dart';
import 'package:app/widgets/item_widget.dart';
import 'package:app/pages/tabs/tabs.dart';

class PopupItems extends StatefulWidget {
  PopupItems({Key key}) : super(key: key);

  final String title = "Landing Page";

  @override
  _PopupItemsState createState() => _PopupItemsState();
}

class _PopupItemsState extends State<PopupItems> {
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
                  'New Item',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown[200]),
                )),
            const Divider(
              color: Colors.brown,
              height: 20,
              thickness: 1,
              indent: 20,
              endIndent: 0,
            ),
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
                        builder: (context) => (Tabs()),
                      ),
                    );
                    print(nameController.text);
                    print(passwordController.text);
                    print(descriptionController);
                  },
                )),
            const Divider(
              color: Colors.brown,
              height: 20,
              thickness: 1,
              indent: 20,
              endIndent: 0,
            ),
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
                    const Divider(
                      color: Colors.black,
                      height: 20,
                      thickness: 1,
                      indent: 20,
                      endIndent: 0,
                    ),
                    Container(
                      padding: const EdgeInsets.all(32),
                      child: Text('Jan 17 1:09AM',
                          softWrap: true, textAlign: TextAlign.center),
                      //there should automatically be interactions and dates that popup here
                    ),
                    const Divider(
                      color: Colors.black,
                      height: 20,
                      thickness: 5,
                      indent: 20,
                      endIndent: 0,
                    ),
                  ]),
                ])),
          ])),
    );
  }
}
