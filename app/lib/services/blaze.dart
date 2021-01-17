import 'dart:math';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:image/image.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class OptionsFace {
  final int numClasses;
  final int numBoxes;
  final int numCoords;
  final int keypointCoordOffset;
  final List<int> ignoreClasses;
  final double scoreClippingThresh;
  final double minScoreThresh;
  final int numKeypoints;
  final int numValuesPerKeypoint;
  final int boxCoordOffset;
  final double xScale;
  final double yScale;
  final double wScale;
  final double hScale;
  final bool applyExponentialOnBoxSize;
  final bool reverseOutputOrder;
  final bool sigmoidScore;
  final bool flipVertically;

  OptionsFace(
      {this.numClasses,
      this.numBoxes,
      this.numCoords,
      this.keypointCoordOffset,
      this.ignoreClasses,
      this.scoreClippingThresh,
      this.minScoreThresh,
      this.numKeypoints = 0,
      this.numValuesPerKeypoint = 2,
      this.boxCoordOffset = 0,
      this.xScale = 0.0,
      this.yScale = 0.0,
      this.wScale = 0.0,
      this.hScale = 0.0,
      this.applyExponentialOnBoxSize = false,
      this.reverseOutputOrder = true,
      this.sigmoidScore = true,
      this.flipVertically = false});
}

class AnchorOption {
  final int inputSizeWidth;
  final int inputSizeHeight;
  final double minScale;
  final double maxScale;
  final double anchorOffsetX;
  final double anchorOffsetY;
  final int numLayers;
  final List<int> featureMapWidth;
  final List<int> featureMapHeight;
  final List<int> strides;
  final List<double> aspectRatios;
  final bool reduceBoxesInLowestLayer;
  final double interpolatedScaleAspectRatio;
  final bool fixedAnchorSize;

  AnchorOption({
    this.inputSizeWidth,
    this.inputSizeHeight,
    this.minScale,
    this.maxScale,
    this.anchorOffsetX,
    this.anchorOffsetY,
    this.numLayers,
    this.featureMapWidth,
    this.featureMapHeight,
    this.strides,
    this.aspectRatios,
    this.reduceBoxesInLowestLayer,
    this.interpolatedScaleAspectRatio,
    this.fixedAnchorSize,
  });

  int get stridesSize {
    return strides.length;
  }

  int get featureMapHeightSize {
    return featureMapHeight.length;
  }

  int get featureMapWidthSize {
    return featureMapWidth.length;
  }
}

class Anchor {
  final double xCenter;
  final double yCenter;
  final double h;
  final double w;
  Anchor(this.xCenter, this.yCenter, this.h, this.w);
}

class Detection {
  final double score;
  final int classID;
  final double xMin;
  final double yMin;
  final double width;
  final double height;
  Detection(
      this.score, this.classID, this.xMin, this.yMin, this.width, this.height);
}

OptionsFace options = OptionsFace(
    numClasses: 1,
    numBoxes: 896,
    numCoords: 16,
    keypointCoordOffset: 4,
    ignoreClasses: [],
    scoreClippingThresh: 100.0,
    minScoreThresh: 0.75,
    numKeypoints: 6,
    numValuesPerKeypoint: 2,
    reverseOutputOrder: false,
    boxCoordOffset: 0,
    xScale: 128,
    yScale: 128,
    hScale: 128,
    wScale: 128);

AnchorOption anchors = AnchorOption(
    inputSizeHeight: 128,
    inputSizeWidth: 128,
    minScale: 0.1484375,
    maxScale: 0.75,
    anchorOffsetX: 0.5,
    anchorOffsetY: 0.5,
    numLayers: 4,
    featureMapHeight: [],
    featureMapWidth: [],
    strides: [8, 16, 16, 16],
    aspectRatios: [1.0],
    reduceBoxesInLowestLayer: false,
    interpolatedScaleAspectRatio: 1.0,
    fixedAnchorSize: true);

class Blaze {
  NormalizeOp _normalizeInput = NormalizeOp(127.5, 127.5);

  List<Anchor> _anchors = new List();
  ImageProcessor _imageProcessor;
  Interpreter _interpreter;
  List<int> _inputShape;

  TensorBuffer output0;
  TensorBuffer output1;
  Map<int, ByteBuffer> outputs;

  void init() async {
    _interpreter =
        await Interpreter.fromAsset("models/face_detection_front.tflite");
    _inputShape = _interpreter.getInputTensor(0).shape;
    _imageProcessor = ImageProcessorBuilder()
        .add(ResizeOp(
            _inputShape[1], _inputShape[2], ResizeMethod.NEAREST_NEIGHBOUR))
        .add(_normalizeInput)
        .build();

    output0 = TensorBuffer.createFixedSize(
        _interpreter.getOutputTensor(0).shape,
        _interpreter.getOutputTensor(0).type);

    output1 = TensorBuffer.createFixedSize(
        _interpreter.getOutputTensor(1).shape,
        _interpreter.getOutputTensor(1).type);

    outputs = {0: output0.buffer, 1: output1.buffer};
  }

  Future<Image> convertYUV420toImageColor(CameraImage image) async {
    final int width = image.planes[0].bytesPerRow;
    final int height = image.height;
    final int uvRowStride = image.planes[1].bytesPerRow;
    final int uvPixelStride = image.planes[1].bytesPerPixel;
    var buffer = Image(width, height);
    for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
        final int uvIndex =
            uvPixelStride * (x / 2).floor() + uvRowStride * (y / 2).floor();
        final int index = y * width + x;
        if (uvIndex > image.planes[1].bytes.length) {
          continue;
        }
        final yp = image.planes[0].bytes[index];
        final up = image.planes[1].bytes[uvIndex];
        final vp = image.planes[2].bytes[uvIndex];
        int r = (yp + vp * 1436 / 1024 - 179).round().clamp(0, 255);
        int g = (yp - up * 46549 / 131072 + 44 - vp * 93604 / 131072 + 91)
            .round()
            .clamp(0, 255);
        int b = (yp + up * 1814 / 1024 - 227).round().clamp(0, 255);
        buffer.data[index] = (0xFF << 24) | (b << 16) | (g << 8) | r;
      }
    }
    return copyRotate(copyCrop(buffer, 0, 0, image.width, image.height), 90);
  }

  TensorImage getTensorImage(Image _img){ 
    TensorImage tensorImage = TensorImage.fromImage(_img);
    tensorImage = _imageProcessor.process(tensorImage);
  }

  Future<Inferance> getInferance(CameraImage image) async {
    TensorImage tensorImage = getTensorImage(await convertYUV420toImageColor(image));
    _interpreter.runForMultipleInputs([tensorImage.buffer], outputs);

    List<double> regression = output0.getDoubleList();
    List<double> classificators = output1.getDoubleList();

    List<Detection> detections = process(
      options: options,
      rawScores: classificators,
      rawBoxes: regression,
      anchors: _anchors
    );

    return Inferance(regression, classificators, detections);
  } 

}

  class Inferance {
    List<double> regression;
    List<double> classificators;
    List<Detection> detections;

    Inferance(this.regression, this.classificators, this.detections);
  }

  List<Anchor> getAnchors(AnchorOption options) {
    List<Anchor> _anchors = new List();
    if (options.stridesSize != options.numLayers) {
      print('strides_size and num_layers must be equal.');
      return [];
    }
    int layerID = 0;
    while (layerID < options.stridesSize) {
      List<double> anchorHeight = new List();
      List<double> anchorWidth = new List();
      List<double> aspectRatios = new List();
      List<double> scales = new List();

      int lastSameStrideLayer = layerID;
      while (lastSameStrideLayer < options.stridesSize &&
          options.strides[lastSameStrideLayer] == options.strides[layerID]) {
        double scale = options.minScale +
            (options.maxScale - options.minScale) *
                1.0 *
                lastSameStrideLayer /
                (options.stridesSize - 1.0);
        if (lastSameStrideLayer == 0 && options.reduceBoxesInLowestLayer) {
          aspectRatios.add(1.0);
          aspectRatios.add(2.0);
          aspectRatios.add(0.5);
          scales.add(0.1);
          scales.add(scale);
          scales.add(scale);
        } else {
          for (int i = 0; i < options.aspectRatios.length; i++) {
            aspectRatios.add(options.aspectRatios[i]);
            scales.add(scale);
          }

          if (options.interpolatedScaleAspectRatio > 0.0) {
            double scaleNext = 0.0;
            if (lastSameStrideLayer == options.stridesSize - 1) {
              scaleNext = 1.0;
            } else {
              scaleNext = options.minScale +
                  (options.maxScale - options.minScale) *
                      1.0 *
                      (lastSameStrideLayer + 1) /
                      (options.stridesSize - 1.0);
            }
            scales.add(sqrt(scale * scaleNext));
            aspectRatios.add(options.interpolatedScaleAspectRatio);
          }
        }
        lastSameStrideLayer++;
      }
      for (int i = 0; i < aspectRatios.length; i++) {
        double ratioSQRT = sqrt(aspectRatios[i]);
        anchorHeight.add(scales[i] / ratioSQRT);
        anchorWidth.add(scales[i] * ratioSQRT);
      }
      int featureMapHeight = 0;
      int featureMapWidth = 0;
      if (options.featureMapHeightSize > 0) {
        featureMapHeight = options.featureMapHeight[layerID];
        featureMapWidth = options.featureMapWidth[layerID];
      } else {
        int stride = options.strides[layerID];
        featureMapHeight = (1.0 * options.inputSizeHeight / stride).ceil();
        featureMapWidth = (1.0 * options.inputSizeWidth / stride).ceil();
      }

      for (int y = 0; y < featureMapHeight; y++) {
        for (int x = 0; x < featureMapWidth; x++) {
          for (int anchorID = 0; anchorID < anchorHeight.length; anchorID++) {
            double xCenter =
                (x + options.anchorOffsetX) * 1.0 / featureMapWidth;
            double yCenter =
                (y + options.anchorOffsetY) * 1.0 / featureMapHeight;
            double w = 0;
            double h = 0;
            if (options.fixedAnchorSize) {
              w = 1.0;
              h = 1.0;
            } else {
              w = anchorWidth[anchorID];
              h = anchorHeight[anchorID];
            }
            _anchors.add(Anchor(xCenter, yCenter, h, w));
          }
        }
      }
      layerID = lastSameStrideLayer;
    }
    return _anchors;
  }

  List<Detection> process(
    {OptionsFace options,
    List<double> rawScores,
    List<double> rawBoxes,
    List<Anchor> anchors}) {
  List<double> detectionScores = new List();
  List<int> detectionClasses = new List();

  int boxes = options.numBoxes;
  for (int i = 0; i < boxes; i++) {
    int classId = -1;
    double maxScore = double.minPositive;
    for (int scoreIdx = 0; scoreIdx < options.numClasses; scoreIdx++) {
      double score = rawScores[i * options.numClasses + scoreIdx];
      if (options.sigmoidScore) {
        if (options.scoreClippingThresh > 0) {
          if (score < -options.scoreClippingThresh)
            score = -options.scoreClippingThresh;
          if (score > options.scoreClippingThresh)
            score = options.scoreClippingThresh;
          score = 1.0 / (1.0 + exp(-score));
          if (maxScore < score) {
            maxScore = score;
            classId = scoreIdx;
          }
        }
      }
    }
    detectionClasses.add(classId);
    detectionScores.add(maxScore);
  }
  List<Detection> detections = convertToDetections(
      rawBoxes, anchors, detectionScores, detectionClasses, options);
  return detections;
}

List<Detection> convertToDetections(
    List<double> rawBoxes,
    List<Anchor> anchors,
    List<double> detectionScores,
    List<int> detectionClasses,
    OptionsFace options) {
  List<Detection> _outputDetections = new List();
  for (int i = 0; i < options.numBoxes; i++) {
    if (detectionScores[i] < options.minScoreThresh) continue;
    int boxOffset = 0;
    List boxData = decodeBox(rawBoxes, i, anchors, options);
    Detection detection = convertToDetection(
        boxData[boxOffset + 0],
        boxData[boxOffset + 1],
        boxData[boxOffset + 2],
        boxData[boxOffset + 3],
        detectionScores[i],
        detectionClasses[i],
        options.flipVertically);
    _outputDetections.add(detection);
  }
  return _outputDetections;
}

List decodeBox(
      List<double> rawBoxes, int i, List<Anchor> anchors, OptionsFace options) {
    List boxData = (List<double>.generate(options.numCoords, (i) => 0.0));
    int boxOffset = i * options.numCoords + options.boxCoordOffset;
    double yCenter = rawBoxes[boxOffset];
    double xCenter = rawBoxes[boxOffset + 1];
    double h = rawBoxes[boxOffset + 2];
    double w = rawBoxes[boxOffset + 3];
    if (options.reverseOutputOrder) {
      xCenter = rawBoxes[boxOffset];
      yCenter = rawBoxes[boxOffset + 1];
      w = rawBoxes[boxOffset + 2];
      h = rawBoxes[boxOffset + 3];
    }

    xCenter = xCenter / options.xScale * anchors[i].w + anchors[i].xCenter;
    yCenter = yCenter / options.yScale * anchors[i].h + anchors[i].yCenter;

    if (options.applyExponentialOnBoxSize) {
      h = exp(h / options.hScale) * anchors[i].h;
      w = exp(w / options.wScale) * anchors[i].w;
    } else {
      h = h / options.hScale * anchors[i].h;
      w = w / options.wScale * anchors[i].w;
    }

    double yMin = yCenter - h / 2.0;
    double xMin = xCenter - w / 2.0;
    double yMax = yCenter + h / 2.0;
    double xMax = xCenter + w / 2.0;

    boxData[0] = yMin;
    boxData[1] = xMin;
    boxData[2] = yMax;
    boxData[3] = xMax;

    if (options.numKeypoints > 0) {
      for (int k = 0; k < options.numKeypoints; k++) {
        int offset = i * options.numCoords +
            options.keypointCoordOffset +
            k * options.numValuesPerKeypoint;
        double keyPointY = rawBoxes[offset];
        double keyPointX = rawBoxes[offset + 1];

        if (options.reverseOutputOrder) {
          keyPointX = rawBoxes[offset];
          keyPointY = rawBoxes[offset + 1];
        }
        boxData[4 + k * options.numValuesPerKeypoint] =
            keyPointX / options.xScale * anchors[i].w + anchors[i].xCenter;

        boxData[4 + k * options.numValuesPerKeypoint + 1] =
            keyPointY / options.yScale * anchors[i].h + anchors[i].yCenter;
      }
    }
    return boxData;
  }

  Detection convertToDetection(double boxYMin, double boxXMin, double boxYMax,
      double boxXMax, double score, int classID, bool flipVertically) {
    double _yMin;
    if (flipVertically)
      _yMin = 1.0 - boxYMax;
    else
      _yMin = boxYMin;
    return new Detection(score, classID, boxXMin, _yMin, (boxXMax - boxXMin),
        (boxXMax - boxYMin));
  }

  List _sum(double a, List b) {
    List<double> _temp = new List();
    b.forEach((element) {
      _temp.add(a + element);
    });
    return _temp;
  }

  List _maximum(double value, List itemIndex) {
    List<double> _temp = new List();
    itemIndex.forEach((element) {
      if (value > element)
        _temp.add(value);
      else
        _temp.add(element);
    });
    return _temp;
  }

  List _itemIndex(List item, List<int> positions) {
    List<double> _temp = new List();
    positions.forEach((element) => _temp.add(item[element]));
    return _temp;
  }

  List<double> _quickSort(List<double> a) {
    if (a.length <= 1)
      return a;

    var pivot = a[0];
    var less = new List<double>();
    var more = new List<double>();
    var pivotList = new List<double>();

    a.forEach((var i) {
      if (i.compareTo(pivot) < 0) {
        less.add(i);
      } else if (i.compareTo(pivot) > 0) {
        more.add(i);
      } else {
        pivotList.add(i);
      }
    });

    less = _quickSort(less);
    more = _quickSort(more);

    less.addAll(pivotList);
    less.addAll(more);
    return less;
  }