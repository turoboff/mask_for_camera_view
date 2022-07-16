# mask_for_camera_view

Plugin to cut a portion of a picture from the camera.

## Getting Started

This plugin works on Android & iOS.
Used to crop an image from the camera section. Without any hassle, just use the MaskForCameraView class to get a picture from its onTake(Uint8List) function.

**Example App**
<br>
<img src="https://github.com/turoboff/mask_for_camera_view/blob/c321233b544b97932ec512921b05bb325072b1c4/assets/example.gif" height="480" alt="example app"/>

**How to use dotted border**
<br>
<img src="https://raw.githubusercontent.com/turoboff/mask_for_camera_view/master/example/lib/assets/1.png" height="380" alt="example app"/>

```
MaskForCameraView(
  visiblePopButton: false,
  onTake: (MaskForCameraViewResult res) {
    // res.croppedImage is cropped image, you can use it.
  }
);
```

**How to use solid border**
<br>
<img src="https://raw.githubusercontent.com/turoboff/mask_for_camera_view/master/example/lib/assets/2.png" height="380" alt="example app"/>

```
MaskForCameraView(
  visiblePopButton: false,
  appBarColor: Colors.red,
  bottomBarColor: Colors.red,
  takeButtonActionColor: Colors.red,
  borderType: MaskForCameraViewBorderType.solid,
  boxBorderWidth: 3.8,
  boxBorderRadius: 3.2,
  onTake: (MaskForCameraViewResult res) {
    // res.croppedImage is cropped image, you can use it.
  }
);
```

**How to use Navigator.pop() button**
<br>
<img src="https://raw.githubusercontent.com/turoboff/mask_for_camera_view/master/example/lib/assets/3.png" height="380" alt="example app"/>

```
MaskForCameraView(
  visiblePopButton: true,
  appBarColor: Colors.white,
  bottomBarColor: Colors.white,
  takeButtonActionColor: Colors.white,
  takeButtonColor: Colors.black,
  boxBorderColor: Colors.red,
  iconsColor: Colors.black,
  titleStyle: const TextStyle(
    color: Colors.black,
    fontSize: 18.0,
    fontWeight: FontWeight.w800,
  ),
  boxBorderWidth: 2.8,
  onTake: (MaskForCameraViewResult res) {
    // res.croppedImage is cropped image, you can use it.
  }
);
```

**Create your own style**
<br>
<img src="https://raw.githubusercontent.com/turoboff/mask_for_camera_view/master/example/lib/assets/4.png" height="380" alt="example app"/>

```
MaskForCameraView(
  visiblePopButton: false,
  appBarColor: Colors.yellow,
  bottomBarColor: Colors.yellow,
  takeButtonActionColor: Colors.green,
  takeButtonColor: Colors.white,
  boxBorderColor: Colors.green,
  iconsColor: Colors.white,
  titleStyle: const TextStyle(
    color: Colors.white,
    fontSize: 18.0,
    fontWeight: FontWeight.w800,
  ),
  boxBorderWidth: 3.8,
  onTake: (MaskForCameraViewResult res) {
    // res.croppedImage is cropped image, you can use it.
  }
);
```

## Usege in Android

In the **android/app/build.gradle** file, change

```
minSdkVersion 16
```

to

```
minSdkVersion 21
```

In the **android/app/src/main/AndroidManifest.xml** file, add this

```
<uses-permission android:name="android.permission.CAMERA" />
```

## Usage in IOS

Upgrade Ios version

```
ios 9
```

to

```
ios 10
```


In the **ios/Runner/Info.plist** file, add this

```
<key>NSCameraUsageDescription</key>
<string>Can I use the camera please?</string>
<key>NSMicrophoneUsageDescription</key>
<string>Can I use the mic please?</string>
```

## For information

**If you want to cut a picture yourself.**

```
cropImage(
    File("...").path,
    cropHeight,
    cropWidth,
    screenHeight,
    screenWidth,
  );
```

This function cuts the image only from the center of the image

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
  onTake: (MaskForCameraViewResult res) {
    // res.croppedImage is cropped image, you can use it.
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
    onTake: (MaskForCameraViewResult res) {},
    insideLine: MaskForCameraViewInsideLine(
      position: MaskForCameraViewInsideLinePosition.eenter,
      direction: MaskForCameraViewInsideLineDirection.horizontal,
    ),
    cameraDescription: MaskForCameraViewCameraDescription.rear,
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
import 'dart:typed_data';
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
      onTake: (MaskForCameraViewResult res) {
        // res.croppedImage is cropped image, you can use it.
      }
    );
  }
}
```
