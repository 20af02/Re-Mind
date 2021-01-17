import 'dart:typed_data';
import 'dart:math';
import 'package:app/pages/tabs/cam/camera.dart';
import 'package:camera/camera.dart';
import 'package:flutter/widgets.dart';
import 'package:tflite/tflite.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
/*
class CVS {
  static double ratio;
  static Size screenSize;
  static Size inputImageSize;

  static Size get actualPreviewSize =>
      Size(screenSize.width, screenSize.width * ratio);
}

class Recognition implements Comparable<Recognition> {
  int _id;
  String _label;

  /// Confidence 0->1
  double _score;
  Rect _location;
  Recognition(this._id, this._label, this._score, [this._location]);

  int get id => _id;
  String get label => _label;
  double get score => _score;
  Rect get location => _location;

  Rect get renderLocation {
    // ratioX = screenWidth / imageInputWidth
    // ratioY = ratioX if image fits screenWidth with aspectRatio = constant

    double ratioX = CVS.ratio;
    double ratioY = ratioX;

    double transLeft = max(0.1, location.left * ratioX);
    double transTop = max(0.1, location.top * ratioY);
    double transWidth =
        min(location.width * ratioX, CVS.actualPreviewSize.width);
    double transHeight =
        min(location.height * ratioY, CVS.actualPreviewSize.height);

    Rect transformedRect =
        Rect.fromLTWH(transLeft, transTop, transWidth, transHeight);
    return transformedRect;
  }

  @override
  String toString() {
    return 'Recognition(id: $id, label: $label, score: ${(score * 100).toStringAsPrecision(3)}, location: $location)';
  }

  @override
  int compareTo(Recognition other) {
    if (this.score == other.score) {
      return 0;
    } else if (this.score > other.score) {
      return -1;
    } else {
      return 1;
    }
  }
}

class Stats {
  int totalPredictTime;
  int totalElapsedTime;
  int inferenceTime;
  int preProcessingTime;

  Stats(
      {this.totalPredictTime,
      this.totalElapsedTime,
      this.inferenceTime,
      this.preProcessingTime});

  @override
  String toString() {
    return 'Stats{totalPredictTime: $totalPredictTime, totalElapsedTime: $totalElapsedTime, inferenceTime: $inferenceTime, preProcessingTime: $preProcessingTime}';
  }
}

class FaceNet {
  Interpreter _interpreter;

  List<String> _labels;

  static const String MODEL_NAME = "assets\models\mobilefacenet.tflite";
  static const String LABEL_NAME = "assets\models\labelmap.txt";

  static const int INPUT_SIZE = 112;
  static const double THREASHOLD = 0.5;

  List<List<int>> _outputTensors;
  List<TfLiteType> _outputTypes;

  int pSize;

  ImageProcessor imageProcessor;

  static const int N_RESULTS = 5;

  FaceNet({Interpreter interpreter}) {
    loadModel(interpreter: interpreter);
  }

  void loadModel({Interpreter interpreter}) async {
    try {
      _interpreter = interpreter ??
          await Interpreter.fromAsset(
            MODEL_NAME,
            options: InterpreterOptions()..threads = 4,
          );

      var outputTensors = _interpreter.getOutputTensors();
      print("lengths: ${outputTensors.length}");

      _outputTensors = [];
      _outputTypes = [];
      outputTensors.forEach((tensor) {
        print(tensor.toString());
        _outputTensors.add(tensor.shape);
        _outputTypes.add(tensor.type);
      });
    } catch (e) {
      print(e);
    }
  }

  TensorImage getProcessedImage(TensorImage input) {
    pSize = max(input.height, input.width);
    if (imageProcessor == null) {
      imageProcessor = ImageProcessorBuilder()
          .add(ResizeWithCropOrPadOp(pSize, pSize))
          .add(ResizeOp(INPUT_SIZE, INPUT_SIZE, ResizeMethod.BILINEAR))
          .build();
    }
    input = imageProcessor.process(input);
    return input;
  }

  prediction(CameraImage cameraImage) async {
    //Preprocess

    //crop faces
    //img.Image cropped =
    //img.Image conv =
    int w = cameraImage.width;
    int h = cameraImage.height;
    var imgTmp = img.Image(w, h);
    final int uvyBstr = cameraImage.planes[1].bytesPerRow;
    final int uvPPstr = cameraImage.planes[1].bytesPerPixel;
    const int hex = 0xFF000000;

    for (int i = 0; i < w; i++) {
      for (int j = 0; j < h; j++) {
        final int uvIndex =
            uvPPstr * (i / 2).floor() + uvyBstr * (j / 2).floor();
        final int index = (j * w + i);
        final int x = cameraImage.planes[0].bytes[index];
        final int y = cameraImage.planes[1].bytes[uvIndex];
        final int z = cameraImage.planes[2].bytes[uvIndex];

        int a = (x + z * 1436 / 1024 - 179).round().clamp(0, 255);
        int b = (x - y * 46549 / 131072 + 44 - z * 93604 / 131072 + 91)
            .round()
            .clamp(0, 255);
        int c = ((x + y * 1814 / 1024 - 227).round().clamp(0, 255));

        imgTmp.data[index] = hex | (c << 16) | (b << 8) | a;
      }
    }

    //resize
    img.Image squared = img.copyResizeCropSquare(imgTmp, 112);

    //to float32

    var convBytes = Float32List(37632);
    var buffer = Float32List.view(convBytes.buffer);

    int pIndex = 0;

    for (int i = 0; i < 112; i++) {
      for (int j = 0; j < 112; j++) {
        var pixel = squared.getPixel(j, i);

        //adjused based on distribution
        buffer[pIndex++] = (img.getRed(pixel) - 128) / 128;
        buffer[pIndex++] = (img.getGreen(pixel) - 128) / 128;
        buffer[pIndex++] = (img.getBlue(pixel) - 128) / 128;
      }
    }
    Float32List frameList = convBytes.buffer.asFloat32List();

    //reshape data to proper format
    List input = frameList.reshape([1, 112, 112, 3]);
    List output = List(192).reshape([1, 192]);

    //Predict (WOOH this took way to long)
    this._interpreter.run(input, output);
    output = output.reshape([192]);

    _predicted = List.from(output);

    print(_predicted);
  }

  Map<String, dynamic> prediction(img.Image image) {
    var predictStartTime = DateTime.now().millisecondsSinceEpoch;

    if (_interpreter == null) {
      print("Interpreter not initialized");
      return null;
    }

    var preProcessStart = DateTime.now().millisecondsSinceEpoch;

    // Create TensorImage from image
    TensorImage inputImage = TensorImage.fromImage(image);

    print("inputImage = ${inputImage.getDataType()}");
    print("getProcessedImage");

    // Pre-process TensorImage
    inputImage = getProcessedImage(inputImage);

    print("inputImage.dataType = ${inputImage.getDataType()}");
    print("inputImage = ${inputImage.getBuffer()}");

    var preProcessElapsedTime =
        DateTime.now().millisecondsSinceEpoch - preProcessStart;

    // TensorBuffers for output tensors
    TensorBuffer outputLocations = TensorBufferFloat(_outputTensors[0]);
    TensorBuffer outputClasses = TensorBufferFloat(_outputTensors[1]);
    TensorBuffer outputScores = TensorBufferFloat(_outputTensors[2]);
    TensorBuffer numLocations = TensorBufferFloat(_outputTensors[3]);

    // Inputs object for runForMultipleInputs
    // Use [TensorImage.buffer] or [TensorBuffer.buffer] to pass by reference
    List<Object> inputs = [inputImage.buffer];

    print("inputs = $inputs");
    print("inputs[0] = ${inputs[0]}");

    // Outputs map
    Map<int, Object> outputs = {
      0: outputLocations.buffer,
      1: outputClasses.buffer,
      2: outputScores.buffer,
      3: numLocations.buffer,
    };

    var inferenceTimeStart = DateTime.now().millisecondsSinceEpoch;

    // run inference
    _interpreter.runForMultipleInputs(inputs, outputs);

    var inferenceTimeElapsed =
        DateTime.now().millisecondsSinceEpoch - inferenceTimeStart;

    // Maximum number of results to show
    int resultsCount = min(N_RESULTS, numLocations.getIntValue(0));

    // Using labelOffset = 1 as ??? at index 0
    int labelOffset = 1;

    // Using bounding box utils for easy conversion of tensorbuffer to List<Rect>
    List<Rect> locations = BoundingBoxUtils.convert(
      tensor: outputLocations,
      valueIndex: [1, 0, 3, 2],
      boundingBoxAxis: 2,
      boundingBoxType: BoundingBoxType.BOUNDARIES,
      coordinateType: CoordinateType.RATIO,
      height: INPUT_SIZE,
      width: INPUT_SIZE,
    );

    List<Recognition> recognitions = [];

    for (int i = 0; i < resultsCount; i++) {
      // Prediction score
      var score = outputScores.getDoubleValue(i);
      print(score);

      // Label string
      var labelIndex = outputClasses.getIntValue(i) + labelOffset;
      var label = _labels.elementAt(labelIndex);
      print(label);

      if (score > THREASHOLD) {
        // inverse of rect
        // [locations] corresponds to the image size 300 X 300
        // inverseTransformRect transforms it our [inputImage]
        Rect transformedRect = imageProcessor.inverseTransformRect(
            locations[i], image.height, image.width);

        recognitions.add(
          Recognition(i, label, score, transformedRect),
        );
      }
    }
    var predictElapsedTime =
        DateTime.now().millisecondsSinceEpoch - predictStartTime;

    return {
      "image": inputImage.image,
      "recognitions": recognitions,
      "stats": Stats(
          totalPredictTime: predictElapsedTime,
          inferenceTime: inferenceTimeElapsed,
          preProcessingTime: preProcessElapsedTime)
    };
  }

  Interpreter get interpreter => _interpreter;
}
/*
class FaceNet {
  static final FaceNet _faceNet = FaceNet._internal();

  factory FaceNet() {
    if (!_faceNet.initialized) {
      _faceNet.loadModel();
      _faceNet.initialized = true;
    }

    return _faceNet;
  }
  bool initialized = false;
  Interpreter _interpreter;
  FaceNet._internal();

  double threashold = 1.0;

  List _predicted;
  List get predicted => this._predicted;

  dynamic data = {};

  //Load facenet tflite model
  void loadModel() {
    try {
      _interpreter = interpreter ?? await Interpreter.fromAsset('mobilefacenet.tflite', options: InterpreterOptions()..threads = 4)
      final gpuDelegateV2 = GpuDelegateV2(
          options: GpuDelegateOptionsV2(
              false,
              TfLiteGpuInferenceUsage.fastSingleAnswer,
              TfLiteGpuInferencePriority.minLatency,
              TfLiteGpuInferencePriority.auto,
              TfLiteGpuInferencePriority.auto));

      var interpretOptions = InterpreterOptions()..addDelegate(gpuDelegateV2);
      this._interpreter = await Interpreter.fromAsset('mobilefacenet.tflite',
          options: interpretOptions);
    } catch (e) {
      print('model load failed');
      print(e);
    }
  }

  //Predict
  prediction(CameraImage cameraImage) async {
    //Preprocess

    //crop faces
    //img.Image cropped =
    //img.Image conv =
    int w = cameraImage.width;
    int h = cameraImage.height;
    var imgTmp = img.Image(w, h);
    final int uvyBstr = cameraImage.planes[1].bytesPerRow;
    final int uvPPstr = cameraImage.planes[1].bytesPerPixel;
    const int hex = 0xFF000000;

    for (int i = 0; i < w; i++) {
      for (int j = 0; j < h; j++) {
        final int uvIndex =
            uvPPstr * (i / 2).floor() + uvyBstr * (j / 2).floor();
        final int index = (j * w + i);
        final int x = cameraImage.planes[0].bytes[index];
        final int y = cameraImage.planes[1].bytes[uvIndex];
        final int z = cameraImage.planes[2].bytes[uvIndex];

        int a = (x + z * 1436 / 1024 - 179).round().clamp(0, 255);
        int b = (x - y * 46549 / 131072 + 44 - z * 93604 / 131072 + 91)
            .round()
            .clamp(0, 255);
        int c = ((x + y * 1814 / 1024 - 227).round().clamp(0, 255));

        imgTmp.data[index] = hex | (c << 16) | (b << 8) | a;
      }
    }

    //resize
    img.Image squared = img.copyResizeCropSquare(imgTmp, 112);

    //to float32

    var convBytes = Float32List(37632);
    var buffer = Float32List.view(convBytes.buffer);

    int pIndex = 0;

    for (int i = 0; i < 112; i++) {
      for (int j = 0; j < 112; j++) {
        var pixel = squared.getPixel(j, i);

        //adjused based on distribution
        buffer[pIndex++] = (img.getRed(pixel) - 128) / 128;
        buffer[pIndex++] = (img.getGreen(pixel) - 128) / 128;
        buffer[pIndex++] = (img.getBlue(pixel) - 128) / 128;
      }
    }
    Float32List frameList = convBytes.buffer.asFloat32List();

    //reshape data to proper format
    List input = frameList.reshape([1, 112, 112, 3]);
    List output = List(192).reshape([1, 192]);

    //Predict (WOOH this took way to long)
    this._interpreter.run(input, output);
    output = output.reshape([192]);

    _predicted = List.from(output);

    print(_predicted);
  }
}
*/
