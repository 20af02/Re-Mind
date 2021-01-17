import 'package:flutter/material.dart';
import 'package:app/widgets/photo_logo.dart';
import 'package:app/pages/signup_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tflite/tflite.dart';
import './preview_page.dart';

class FaceLoginPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<FaceLoginPage> {
  Duration get loginTime => Duration(milliseconds: 2250);

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: LoginCameraScreen());
  }
}

typedef void Callback(List<dynamic> list, int h, int w);
typedef void CameraFrameCallback(CameraImage image);

class LoginCameraScreen extends StatefulWidget {
  final Callback setRecognitions;
  final CameraFrameCallback cameraFrameCallback;

  LoginCameraScreen({this.setRecognitions, this.cameraFrameCallback});

  @override
  _LoginCameraScreenState createState() => _LoginCameraScreenState();
}

class _LoginCameraScreenState extends State<LoginCameraScreen>
    with WidgetsBindingObserver {
  CameraController cameraController;
  List cameras;
  int selectedCameraIndex;
  String imgPath;
  bool isDetecting = false;

  Future initCamera(CameraDescription cameraDescription) async {
    if (cameraController != null) {
      await cameraController.dispose();
    }

    cameraController =
        CameraController(cameraDescription, ResolutionPreset.high);

    cameraController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    if (cameraController.value.hasError) {
      print('Camera Error ${cameraController.value.errorDescription}');
    }

    try {
      await cameraController.initialize();

      // cameraController.startImageStream((CameraImage img) {
      //   try {
      //     if (!isDetecting) {
      //       isDetecting = true;

      //       Tflite.detectObjectOnFrame(
      //         bytesList: img.planes.map((plane) {
      //           return plane.bytes;
      //         }).toList(),
      //         model: "SSDMobileNet",
      //         imageHeight: img.height,
      //         imageWidth: img.width,
      //         imageMean: 127.5,
      //         imageStd: 127.5,
      //         numResultsPerClass: 1,
      //         threshold: 0.6,
      //         asynch: true,
      //       ).then((recognitions) {
      //         /*
      //           When setRecognitions is called here, the parameters are being passed on to the parent widget as callback. i.e. to the LiveFeed class
      //           */
      //         if (widget.setRecognitions != null)
      //           widget.setRecognitions(recognitions, img.height, img.width);
      //         isDetecting = false;
      //       });

      //     }
      //   } catch (e) {
      //     print("print: error: " + e.toString());
      //   }
      // });

    } catch (e) {
      showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  /// Display camera preview
  Widget cameraPreview() {
    if (cameraController == null || !cameraController.value.isInitialized) {
      return Text(
        'Loading',
        style: TextStyle(
            color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
      );
    }

    // return AspectRatio(
    //   aspectRatio: cameraController.value.aspectRatio,
    //   child: CameraPreview(cameraController),
    // );
    return CameraPreview(cameraController);
  }

  Widget cameraControl(context) {
    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            FloatingActionButton(
              child: Icon(
                Icons.camera,
                color: Colors.black,
              ),
              backgroundColor: Colors.white,
              onPressed: () {
                onCapture(context);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget cameraToggle() {
    if (cameras == null || cameras.isEmpty) {
      return Spacer();
    }

    CameraDescription selectedCamera = cameras[selectedCameraIndex];
    CameraLensDirection lensDirection = selectedCamera.lensDirection;

    return Expanded(
      child: Align(
        alignment: Alignment.centerLeft,
        child: FlatButton.icon(
            onPressed: () {
              onSwitchCamera();
            },
            icon: Icon(
              getCameraLensIcons(lensDirection),
              color: Colors.white,
              size: 24,
            ),
            label: Text(
              '${lensDirection.toString().substring(lensDirection.toString().indexOf('.') + 1).toUpperCase()}',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            )),
      ),
    );
  }

  onCapture(context) async {
    try {
      final p = await getTemporaryDirectory();
      final name = DateTime.now();
      final path = "${p.path}/$name.png";

      await cameraController.takePicture(path).then((value) {
        print('here');
        print(path);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PreviewLoginPage(
                      imgPath: path,
                      fileName: "$name.png",
                    )));
      });
    } catch (e) {
      showCameraException(e);
    }
  }

  @override
  void initState() {
    super.initState();
    availableCameras().then((value) {
      cameras = value;
      if (cameras.length > 1) {
        setState(() {
          selectedCameraIndex = 1;
        });
        initCamera(cameras[selectedCameraIndex]).then((value) {});
      } else if (cameras.length > 0) {
        setState(() {
          selectedCameraIndex = 0;
        });
        initCamera(cameras[selectedCameraIndex]).then((value) {});
      } else {
        print('No camera available');
      }
    }).catchError((e) {
      print('Error : ${e.code}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Stack(
          children: <Widget>[
            // Expanded(
            //   flex: 1,
            //   child: _cameraPreviewWidget(),
            // ),
            Align(
              alignment: Alignment.center,
              child: cameraPreview(),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 120,
                width: double.infinity,
                padding: EdgeInsets.all(15),
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    cameraToggle(),
                    cameraControl(context),
                    Spacer(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  getCameraLensIcons(lensDirection) {
    switch (lensDirection) {
      case CameraLensDirection.back:
        return CupertinoIcons.switch_camera;
      case CameraLensDirection.front:
        return CupertinoIcons.switch_camera_solid;
      case CameraLensDirection.external:
        return CupertinoIcons.photo_camera;
      default:
        return Icons.device_unknown;
    }
  }

  onSwitchCamera() {
    selectedCameraIndex =
        selectedCameraIndex < cameras.length - 1 ? selectedCameraIndex + 1 : 0;
    CameraDescription selectedCamera = cameras[selectedCameraIndex];
    initCamera(selectedCamera);
  }

  showCameraException(e) {
    String errorText = 'Error ${e.code} \nError message: ${e.description}';
  }

  // @override
  // void dispose() {
  //   cameraController.dispose();
  //   super.dispose();
  // }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      cameraController?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (cameraController != null) {
        onSwitchCamera();
      }
    }
  }
}
