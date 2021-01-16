import 'package:flutter/material.dart';

class ExampleWidget extends StatelessWidget {
  final String message;
  
  ExampleWidget({this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      width: 100,
      height: 100,
      child: Text(message)
    );
  }
}