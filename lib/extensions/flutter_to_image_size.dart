import 'dart:ui' as ui;

import 'package:image/image.dart';

ui.Size flutterToImageSize(ui.Size flutterRect, Image image) {
  double imagePixelRatio = image.width / ui.window.physicalSize.width;

  double imageWidth =
      flutterRect.width * ui.window.devicePixelRatio * imagePixelRatio;
  double imageHeight =
      flutterRect.height * ui.window.devicePixelRatio * imagePixelRatio;

  return ui.Size(imageWidth, imageHeight);
}
