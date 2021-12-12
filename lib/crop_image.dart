import 'dart:io';
import 'dart:typed_data';

import 'package:image/image.dart';

Future<Uint8List?> cropImage(
  String imagePath,
  int cropHeight,
  int cropWeight,
  double screenHeight,
  double screenWidth,
) async {
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
  List<int> croppedList = encodeJpg(croppedImage);
  Uint8List croppedBytes = Uint8List.fromList(croppedList);
  return croppedBytes;
}
