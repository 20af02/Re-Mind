
import 'package:flutter/material.dart';
import '../widgets/example_widget.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("testing"),
      ),

      body: Center(
        child: ExampleWidget(message:"work in progress"),
      ),
    );
  }
}
