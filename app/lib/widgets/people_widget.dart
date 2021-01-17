import 'dart:io';

import 'package:app/models/remind_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app/pages/popup_people.dart';

class PeopleWidget extends StatelessWidget {
  final String message;

  PeopleWidget({this.message});


  Widget GetPerson(context, Person person) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PopupPeople(person),),
        );
      },

      child: Container(
        padding: const EdgeInsets.only(top: 2.0),
        child: Stack(
          children: <Widget>[
            person.url != null ? 
            Image.network(
                person.url,
                height: 800,
                width: 400,
                fit: BoxFit.cover,
            ) :
            
            person.path != null ?
            Image.file(
                File(person.path),
                height: 800,
                width: 400,
                fit: BoxFit.cover,
            ):
            Container(          
                height: 800,
                width: 400,
            ),

            Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                // color: Colors.black45,
                border: Border.all(color: Colors.brown[200], width: 8),
              ),
              child: Align(
                alignment: FractionalOffset.topCenter,
                
                child: Padding(
                  
                  padding: EdgeInsets.only(bottom: 10),
                  child: Container(width: 100, height: 25, color: Colors.black87, child: Center(child: Text(person.name, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)))),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = people.map<Widget>((Person person) {
      return GetPerson(context, person);
    }).toList() ?? [];

    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(0),
      crossAxisCount: 2,
      crossAxisSpacing: 0,
      mainAxisSpacing: 0,
      children: widgets
    );
  }
}
