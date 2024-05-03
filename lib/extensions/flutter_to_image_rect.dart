import 'dart:ui' as ui;

import 'package:image/image.dart';

ui.Rect flutterToImageRect(ui.Rect flutterRect, Image image) {
  double imagePixelRatio = image.width / ui.window.physicalSize.width;

  double imageX =
      flutterRect.left * ui.window.devicePixelRatio * imagePixelRatio;
  double imageY =
      flutterRect.top * ui.window.devicePixelRatio * imagePixelRatio;

  double imageWidth =
      flutterRect.width * ui.window.devicePixelRatio * imagePixelRatio;
  double imageHeight =
      flutterRect.height * ui.window.devicePixelRatio * imagePixelRatio;

  return ui.Rect.fromLTWH(imageX, imageY, imageWidth, imageHeight);
}
