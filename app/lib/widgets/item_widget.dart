import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  final String message;

  ItemWidget({this.message});

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
              '',
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Image.network(
              '',
              height: 400,
              width: 400,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Image.network(
              '',
              height: 400,
              width: 400,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Image.network(
              '',
              height: 400,
              width: 400,
            ),
          )
        ]);
  }
}
