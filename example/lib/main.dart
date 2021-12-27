import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mask_for_camera_view/mask_for_camera_view.dart';

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
      onTake: (Uint8List imageBytes) => showModalBottomSheet(
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
          child: Column(
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
                child: Image.memory(imageBytes),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
