import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mask_for_camera_view/mask_for_camera_view.dart';
import 'package:mask_for_camera_view/mask_for_camera_view_inside_line.dart';
import 'package:mask_for_camera_view/mask_for_camera_view_inside_line_direction.dart';
import 'package:mask_for_camera_view/mask_for_camera_view_inside_line_position.dart';
import 'package:mask_for_camera_view/mask_for_camera_view_result.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MaskForCameraView.initialize();
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
        position: MaskForCameraViewInsideLinePosition.centerEnd,
        direction: MaskForCameraViewInsideLineDirection.horizontal,
      ),
      onTake: (MaskForCameraViewResult res) => showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 14.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14.0),
              topRight: Radius.circular(14.0),
            ),
          ),
          child: ListView(
            children: [
              const Text(
                "Cropped Image",
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4.0),
              SizedBox(
                width: double.infinity,
                child:
                    res.image != null ? Image.memory(res.image!) : Container(),
              ),
              const SizedBox(height: 6.0),
              SizedBox(
                width: double.infinity,
                child: res.firstHalfImage != null
                    ? Image.memory(res.firstHalfImage!)
                    : Container(),
              ),
              const SizedBox(height: 6.0),
              SizedBox(
                width: double.infinity,
                child: res.secondHalfImage != null
                    ? Image.memory(res.secondHalfImage!)
                    : Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
