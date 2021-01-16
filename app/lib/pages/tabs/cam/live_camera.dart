import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import './bounding_box.dart';
import './camera_feed.dart';
import './camera.dart';
import 'dart:math' as math;
import 'package:tflite/tflite.dart';

class LiveFeed extends StatefulWidget {
  // final List<CameraDescription> cameras;
  // final int cameraIndex;
  // LiveFeed({Key key}) : super(key: key);
  @override
  _LiveFeedState createState() => _LiveFeedState();
}

class _LiveFeedState extends State<LiveFeed> {
  List<dynamic> _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  initCameras() async {}
  loadTfModel() async {
    await Tflite.loadModel(
      model: "assets/models/ssd_mobilenet.tflite",
      labels: "assets/models/labels.txt",
    );
  }

  /* 
  The set recognitions function assigns the values of recognitions, imageHeight and width to the variables defined here as callback
  */
  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  @override
  void initState() {
    super.initState();
    loadTfModel();
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        // CameraFeed(widget.cameras, setRecognitions, widget.cameraIndex),
        CameraScreen(setRecognitions: setRecognitions),
        
        BoundingBox(
          _recognitions == null ? [] : _recognitions,
          math.max(_imageHeight, _imageWidth),
          math.min(_imageHeight, _imageWidth),
          screen.height,
          screen.width,
        ),
      ],
    );
  }
}
