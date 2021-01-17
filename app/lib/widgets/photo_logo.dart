import 'package:flutter/material.dart';

class PhotoWidget extends StatelessWidget {
  final String message;

  PhotoWidget({this.message});

  @override
  Widget build(BuildContext context) {
    return Image(
        image: AssetImage('images/rememberbetter.png'),
        height: 350,
        width: 350);
  }
}
