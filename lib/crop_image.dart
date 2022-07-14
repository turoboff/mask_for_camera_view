import 'dart:io';
import 'dart:typed_data';

import 'package:image/image.dart';
import 'package:mask_for_camera_view/mask_for_camera_view_inside_line.dart';
import 'package:mask_for_camera_view/mask_for_camera_view_inside_line_direction.dart';
import 'package:mask_for_camera_view/mask_for_camera_view_inside_line_position.dart';

import 'mask_for_camera_view_result.dart';

Future<MaskForCameraViewResult?> cropImage(
    String imagePath,
    int cropHeight,
    int cropWeight,
    double screenHeight,
    double screenWidth,
    MaskForCameraViewInsideLine? insideLine) async {
  Uint8List imageBytes = await File(imagePath).readAsBytes();

  Image? image = decodeImage(imageBytes);

  double? increasedTimesW;
  double? increasedTimesH;
  if (image!.width > screenWidth) {
    increasedTimesW = image.width / screenWidth;
    increasedTimesH = image.height / screenHeight;
  } else {
    return null;
  }

  double sX = (screenWidth - cropWeight) / 2;
  double sY = (screenHeight - cropHeight) / 2;

  double x = sX * increasedTimesW;
  double y = sY * increasedTimesH;

  double w = cropWeight * increasedTimesW;
  double h = cropHeight * increasedTimesH;

  Image croppedImage =
      copyCrop(image, x.toInt(), y.toInt(), w.toInt(), h.toInt());
  MaskForCameraViewResult res = MaskForCameraViewResult();
  if (insideLine != null) {
    MaskForCameraViewResult halfRes =
        await _cropHalfImage(croppedImage, insideLine);
    res = halfRes;
  }
  List<int> croppedList = encodeJpg(croppedImage);
  Uint8List croppedBytes = Uint8List.fromList(croppedList);
  res.image = croppedBytes;
  return res;
}

Future<MaskForCameraViewResult> _cropHalfImage(
    Image image, MaskForCameraViewInsideLine insideLine) async {
  double x;
  double y;
  double w;
  double h;

  if (insideLine.direction == null ||
      insideLine.direction == MaskForCameraViewInsideLineDirection.horizontal) {
    y = 0;
    x = 0;
    w = image.width.toDouble();
    h = (image.height / 10) * _position(insideLine.position);
  } else {
    y = 0;
    x = 0;
    w = (image.width / 10) * _position(insideLine.position);
    h = image.height.toDouble();
  }
  Image firstCroppedImage =
      copyCrop(image, x.toInt(), y.toInt(), w.toInt(), h.toInt());

  List<int> firstCroppedList = encodeJpg(firstCroppedImage);
  Uint8List firstCroppedBytes = Uint8List.fromList(firstCroppedList);

  if (insideLine.direction == null ||
      insideLine.direction == MaskForCameraViewInsideLineDirection.horizontal) {
    y = (image.height / 10) * _position(insideLine.position);
    x = 0;
    w = image.width.toDouble();
    h = image.height - y;
  } else {
    y = 0;
    x = (image.width / 10) * _position(insideLine.position);
    w = image.width - x;
    h = image.height.toDouble();
  }

  Image secondCroppedImage =
      copyCrop(image, x.toInt(), y.toInt(), w.toInt(), h.toInt());

  List<int> secondCroppedList = encodeJpg(secondCroppedImage);
  Uint8List secondCroppedBytes = Uint8List.fromList(secondCroppedList);
  MaskForCameraViewResult res = MaskForCameraViewResult(
      firstHalfImage: firstCroppedBytes, secondHalfImage: secondCroppedBytes);

  return res;
}

int _position(MaskForCameraViewInsideLinePosition? position) {
  int p = 5;
  if (position != null) {
    p = position.index + 1;
  }
  return p;
}
