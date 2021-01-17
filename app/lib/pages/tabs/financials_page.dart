import 'package:flutter/material.dart';

class FinancialsPage extends StatefulWidget {
  FinancialsPage({Key key}) : super(key: key);

  final String title = "Financial Page";

  @override
  _FinancialsPageState createState() => _FinancialsPageState();
}

class _FinancialsPageState extends State<FinancialsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.brown,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Divider(color: Colors.brown),
            ListTile(
                title:
                    Text('TD', style: TextStyle(fontWeight: FontWeight.w500)),
                subtitle: Text('Chequing Balance: \$0.02'),
                leading: Image(image: AssetImage('images/TD.png'))),
            const Divider(color: Colors.brown),
            ListTile(
                title:
                    Text('CIBC', style: TextStyle(fontWeight: FontWeight.w500)),
                subtitle: Text('Savings Balance: \$15,323.23'),
                leading: Image(image: AssetImage('images/CIBC.png'))),
            const Divider(color: Colors.brown),
            ListTile(
                title: Text('Bank of America',
                    style: TextStyle(fontWeight: FontWeight.w500)),
                subtitle: Text('International (USD) balance: \$1,324.25'),
                leading: Image(image: AssetImage('images/BAC.png'))),
            const Divider(
              color: Colors.brown,
            ),
          ],
        ),
      ),
    );
  }
}
