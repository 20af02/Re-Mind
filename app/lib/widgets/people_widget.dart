import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app/pages/popup_people.dart';

class PeopleWidget extends StatelessWidget {
  final String message;

  PeopleWidget({this.message});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(0),
      crossAxisCount: 2,
      crossAxisSpacing: 0,
      mainAxisSpacing: 0,
      children: <Widget>[
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PopupPeople(),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.only(top: 2.0),
            child: Stack(
              children: <Widget>[
                Image.network(
                    'https://images.pexels.com/photos/545042/pexels-photo-545042.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
                    height: 800,
                    width: 400),
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
                      child: Text('someText', style: TextStyle()),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PopupPeople(),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.only(top: 2.0),
            child: Stack(
              children: <Widget>[
                Image.network(
                    'https://images.pexels.com/photos/545042/pexels-photo-545042.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
                    height: 800,
                    width: 400),
                Container(
                  width: 250, height: 250,
                  decoration: BoxDecoration(
                    // color: Colors.black45,
                    border: Border.all(color: Colors.brown[200], width: 8),
                  ),
                  child: Align(
                    alignment: FractionalOffset.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text('someText', style: TextStyle()),
                    ),
                  ),
                  //),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PopupPeople(),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.only(top: 2.0),
            child: Stack(
              children: <Widget>[
                Image.network(
                    'https://images.pexels.com/photos/545042/pexels-photo-545042.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
                    height: 800,
                    width: 400),
                Container(
                  width: 250, height: 250,
                  decoration: BoxDecoration(
                    // color: Colors.black45,
                    border: Border.all(color: Colors.brown[200], width: 8),
                  ),
                  child: Align(
                    alignment: FractionalOffset.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text('someText', style: TextStyle()),
                    ),
                  ),
                  //),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PopupPeople(),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.only(top: 2.0),
            child: Stack(
              children: <Widget>[
                Image.network(
                    'https://images.pexels.com/photos/545042/pexels-photo-545042.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
                    height: 800,
                    width: 400),
                Container(
                  width: 250, height: 250,
                  decoration: BoxDecoration(
                    // color: Colors.black45,
                    border: Border.all(color: Colors.brown[200], width: 8),
                  ),
                  child: Align(
                    alignment: FractionalOffset.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text('someText', style: TextStyle()),
                    ),
                  ),
                  //),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
