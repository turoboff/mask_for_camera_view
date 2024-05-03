import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mask_for_camera_view/inside_line/mask_for_camera_view_inside_line.dart';
import 'package:mask_for_camera_view/mask_for_camera_view.dart';
import 'package:mask_for_camera_view/mask_for_camera_view_result.dart';

import 'show_bottom_sheet.dart';

late List<CameraDescription> cameras;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await MaskForCameraView.initialize();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaskForCameraView(
      visiblePopButton: false,
      insideLine: MaskForCameraViewInsideLine(
        position: MaskForCameraViewInsideLinePosition.endPartThree,
        direction: MaskForCameraViewInsideLineDirection.horizontal,
      ),
      boxBorderWidth: 2.6,
      boxHeight: 1275,
      boxWidth: 993,
      // [cameras.first] is rear camera.
      cameraDescription: cameras.first,
      onTake: (MaskForCameraViewResult? res) {
        if (res != null) showOnTakeBottomSheet(context, res);
      },
    );
  }
}
