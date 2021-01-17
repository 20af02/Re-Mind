import 'dart:io';

import 'package:app/models/remind_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app/pages/popup_items.dart';
import 'package:meta/meta.dart';

class ItemWidget extends StatelessWidget {
  final String message;

  ItemWidget({this.message});

  Widget GetExampleItem(context) {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => PopupItem(),
        //   ),
        // );
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
    );
  }


  Widget GetItem(context, Item item) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PopupItem(item),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.only(top: 2.0),
        child: Stack(
          children: <Widget>[
            // Image.network(
            //     item.lastLocationUrl,
            //     height: 800,
            //     width: 400,
            //     fit: BoxFit.cover,
            // ),
            item.lastLocationUrl != null ? 
            Image.network(
                item.lastLocationUrl,
                height: 800,
                width: 400,
                fit: BoxFit.cover,
            ) :
            
            item.path != null ?
            Image.file(
                File(item.path),
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
                  child: Text(item.name, style: TextStyle()),
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
    List<Widget> widgets = items.map<Widget>((Item item) {
      return GetItem(context, item);
    }).toList() ?? [];

    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(0),
      crossAxisCount: 2,
      crossAxisSpacing: 0,
      mainAxisSpacing: 0,
      children: widgets,
      // children: <Widget>[
      //   InkWell(
      //     onTap: () {
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => PopupItems(),
      //         ),
      //       );
      //     },
      //     child: Container(
      //       padding: const EdgeInsets.only(top: 2.0),
      //       child: Stack(
      //         children: <Widget>[
      //           Image.network(
      //               'https://images.pexels.com/photos/545042/pexels-photo-545042.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
      //               height: 800,
      //               width: 400),
      //           Container(
      //             width: 250, height: 250,
      //             decoration: BoxDecoration(
      //               // color: Colors.black45,
      //               border: Border.all(color: Colors.brown[200], width: 8),
      //             ),
      //             child: Align(
      //               alignment: FractionalOffset.topCenter,
      //               child: Padding(
      //                 padding: EdgeInsets.only(bottom: 10),
      //                 child: Text('someText', style: TextStyle()),
      //               ),
      //             ),
      //             //),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      //   InkWell(
      //     onTap: () {
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => PopupItems(),
      //         ),
      //       );
      //     },
      //     child: Container(
      //       padding: const EdgeInsets.only(top: 2.0),
      //       child: Stack(
      //         children: <Widget>[
      //           Image.network(
      //               'https://images.pexels.com/photos/545042/pexels-photo-545042.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
      //               height: 800,
      //               width: 400),
      //           Container(
      //             width: 250, height: 250,
      //             decoration: BoxDecoration(
      //               // color: Colors.black45,
      //               border: Border.all(color: Colors.brown[200], width: 8),
      //             ),
      //             child: Align(
      //               alignment: FractionalOffset.topCenter,
      //               child: Padding(
      //                 padding: EdgeInsets.only(bottom: 10),
      //                 child: Text('someText', style: TextStyle()),
      //               ),
      //             ),
      //             //),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      //   InkWell(
      //     onTap: () {
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => PopupItems(),
      //         ),
      //       );
      //     },
      //     child: Container(
      //       padding: const EdgeInsets.only(top: 2.0),
      //       child: Stack(
      //         children: <Widget>[
      //           Image.network(
      //               'https://images.pexels.com/photos/545042/pexels-photo-545042.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
      //               height: 800,
      //               width: 400),
      //           Container(
      //             width: 250, height: 250,
      //             decoration: BoxDecoration(
      //               // color: Colors.black45,
      //               border: Border.all(color: Colors.brown[200], width: 8),
      //             ),
      //             child: Align(
      //               alignment: FractionalOffset.topCenter,
      //               child: Padding(
      //                 padding: EdgeInsets.only(bottom: 10),
      //                 child: Text('someText', style: TextStyle()),
      //               ),
      //             ),
      //             //),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ],
    );
  }
}
