# box_in_camera

Plugin to cut a portion of a picture from the camera.

## Getting Started

This plugin works on Android & iOS.
Used to crop an image from the camera section. Without any hassle, just use the BoxInCamera class to get a picture from its onTake(Uint8List) function.

**Example App**
<img src="example.gif" height="380" alt="example app"/>

## Usege in **Android**

In the **android/app/build.gradle** file, change

```
minSdkVersion 16
```

to

```
minSdkVersion 21.
```

In the **android/app/src/main/AndroidManifest.xml** file, add this

```
<uses-permission android:name="android.permission.CAMERA" />
```

## Usage in **IOS**

In the **ios/Runner/Info.plist** file, add this

```
<key>NSCameraUsageDescription</key>
<string>Can I use the camera please?</string>
<key>NSMicrophoneUsageDescription</key>
<string>Can I use the mic please?</string>
```

## For information

**If you want to cut a picture yourself.**
This function cuts the image only from the center of the image

```
cropImage(
    File("...").path,
    cropHeight,
    cropWidth,
    screenHeight,
    screenWidth,
  );
```

## Usage

**Initialize camera**

```
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MaskForCameraView.initialize();
  runApp(MyApp());
}
```

**Get image Uint8List**

```
MaskForCameraView(
  visiblePopButton: false,
  onTake: (Uint8List imageBytes) {
    // imageBytes is croped image, you can use it.
});
```

**Acceptable parameters**

```
MaskForCameraView(
    title: "Crop image from camera",
    boxWidth: 300.0,
    boxHeight: 168.0,
    boxBorderWidth: 1.8,
    boxBorderRadius: 3.2,
    onTake: (Uint8List imageBytes) {},
    borderType: MaskForCameraViewBorderType.dotted,
    visiblePopButton: true,
    appBarColor: Colors.black,
    titleStyle: const TextStyle(
      color: Colors.white,
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
    ),
    boxBorderColor: Colors.white,
    bottomBarColor: Colors.black,
    takeButtonColor: Colors.white,
    takeButtonActionColor: Colors.black,
    iconsColor: Colors.white,
)
```

## Example

Full [example](https://github.com/turoboff/box_in_camera/tree/master/example) to use.

```
import 'dart:async';
import 'dart:typed_data';

import 'package:box_in_camera/box_in_camera.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await BoxInCamera.initialize();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BoxInCamera(
        visiblePopButton: false,
        onTake: (Uint8List imageBytes) {
          // imageBytes is croped image, you can use it.
        });
  }
}
```
