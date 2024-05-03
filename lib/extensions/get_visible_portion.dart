import 'dart:io';
import 'dart:isolate';
import 'dart:ui' as ui;
import 'dart:typed_data';

import 'package:image/image.dart';
import 'package:mask_for_camera_view/extensions/flutter_to_image_size.dart';

Future<Image?> getVisiblePortion(
    {File? imageFile,
    Uint8List? imageBytes,
    required ui.Size flutterScreenSize}) async {
  if (imageBytes == null && imageFile == null) {
    throw Exception("One of imageBytes or imageFile should be available");
  }

  Uint8List imgBytes = imageBytes ?? await imageFile!.readAsBytes();

  Image? image = await Isolate.run<Image?>(() => decodeImage(imgBytes));

  if (image == null) {
    return null;
  }

  ui.Size screenRectInimageSize = flutterToImageSize(flutterScreenSize, image);

  int y = (image.height ~/ 2) - (screenRectInimageSize.height ~/ 2);
  int x = (image.width ~/ 2) - (screenRectInimageSize.width ~/ 2);
  Image croppedImage = await Isolate.run<Image>(
    () => copyCrop(
      image,
      x: x > 0 ? x : 0,
      y: y > 0 ? y : 0,
      width: screenRectInimageSize.width.toInt(),
      height: screenRectInimageSize.height.toInt(),
    ),
  );

  return croppedImage;
}
