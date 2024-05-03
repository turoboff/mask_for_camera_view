import 'package:flutter/material.dart';

class MaskForCameraViewStyle {
  MaskForCameraViewStyle({
    this.appBarColor = Colors.black,
    this.titleStyle = const TextStyle(
      color: Colors.white,
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
    ),
    this.boxBorderColor = Colors.white,
    this.bottomBarColor = Colors.black,
    this.takeButtonColor = Colors.white,
    this.takeButtonActionColor = Colors.black,
    this.iconsColor = Colors.white,
  });
  final Color appBarColor;
  final TextStyle titleStyle;
  final Color boxBorderColor;
  final Color bottomBarColor;
  final Color takeButtonColor;
  final Color takeButtonActionColor;
  final Color iconsColor;
}
