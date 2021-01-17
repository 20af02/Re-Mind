import 'dart:html';

import 'package:flutter/material.dart';

class PeopleWidget extends StatelessWidget {
  final String message;

  PeopleWidget({this.message});

  @override
  Widget build(BuildContext context) {
    //implementing gridview directly through build function to make it easier.

    return GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            child: Image.network(
              'https://www.facebook.com/photo?fbid=3716388795049198&set=a.149988678355912',
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Image.network(
              'https://www.linkedin.com/in/isaiah-ballah/detail/photo/',
              height: 400,
              width: 400,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Image.network(
              'https://www.linkedin.com/in/muntasersyed/detail/photo/',
              height: 400,
              width: 400,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Image.network(
              'https://www.linkedin.com/in/ammaar-firozi-8202b81ab/',
              height: 400,
              width: 400,
            ),
          )
        ]);
  }
}
