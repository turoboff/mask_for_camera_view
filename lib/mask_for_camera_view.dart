import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'crop_image.dart';
import 'mask_for_camera_view_border_type.dart';

CameraController? _cameraController;
List<CameraDescription>? _cameras;

double? _screenWidth;
double? _screenHeight;
double? _boxWidthForCrop;
double? _boxHeightForCrop;

FlashMode _flashMode = FlashMode.auto;

class MaskForCameraView extends StatefulWidget {
  MaskForCameraView({
    this.title = "Crop image from camera",
    this.boxWidth = 300.0,
    this.boxHeight = 168.0,
    this.boxBorderWidth = 1.8,
    this.boxBorderRadius = 3.2,
    required this.onTake,
    this.borderType = MaskForCameraViewBorderType.dotted,
    this.visiblePopButton = true,
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

  String title;
  double boxWidth;
  double boxHeight;
  double boxBorderWidth;
  double boxBorderRadius;
  bool visiblePopButton;
  Color appBarColor;
  TextStyle titleStyle;
  Color boxBorderColor;
  Color bottomBarColor;
  Color takeButtonColor;
  Color takeButtonActionColor;
  Color iconsColor;
  ValueSetter<Uint8List> onTake;
  MaskForCameraViewBorderType borderType;
  @override
  State<StatefulWidget> createState() => _MaskForCameraViewState();

  static Future<void> initialize() async {
    _cameras = await availableCameras();
  }
}

class _MaskForCameraViewState extends State<MaskForCameraView> {
  bool isRunning = false;

  @override
  void initState() {
    _cameraController = CameraController(
      _cameras![0],
      ResolutionPreset.max,
      enableAudio: false,
    );
    super.initState();
    _cameraController!.initialize().then((_) {
      if (!mounted) {
        return;
      }

      setState(() {});
    });
  }

  @override
  void dispose() {
    _cameraController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;

    _screenHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top + 54.0);

    // _screenHeight = MediaQuery.of(context).size.height;

    _boxWidthForCrop = widget.boxWidth;
    _boxHeightForCrop = widget.boxHeight;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: !_cameraController!.value.isInitialized
                ? Container()
                : Center(
                    child: CameraPreview(
                      _cameraController!,
                      child: Center(
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          strokeWidth: widget.borderType ==
                                  MaskForCameraViewBorderType.dotted
                              ? widget.boxBorderWidth
                              : 0.0,
                          color: widget.borderType ==
                                  MaskForCameraViewBorderType.dotted
                              ? widget.boxBorderColor
                              : Colors.transparent,
                          dashPattern: [4, 3],
                          radius: Radius.circular(
                            widget.boxBorderRadius,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: isRunning
                                  ? Colors.white60
                                  : Colors.transparent,
                              borderRadius:
                                  BorderRadius.circular(widget.boxBorderWidth),
                            ),
                            child: Container(
                              width: widget.borderType ==
                                      MaskForCameraViewBorderType.solid
                                  ? widget.boxWidth + widget.boxBorderWidth * 2
                                  : widget.boxWidth,
                              height: widget.borderType ==
                                      MaskForCameraViewBorderType.solid
                                  ? widget.boxHeight + widget.boxBorderWidth * 2
                                  : widget.boxHeight,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: widget.borderType ==
                                          MaskForCameraViewBorderType.solid
                                      ? widget.boxBorderWidth
                                      : 0.0,
                                  color: widget.borderType ==
                                          MaskForCameraViewBorderType.solid
                                      ? widget.boxBorderColor
                                      : Colors.transparent,
                                ),
                                borderRadius: BorderRadius.circular(
                                  widget.boxBorderRadius,
                                ),
                              ),
                              child: isRunning &&
                                      widget.boxWidth >= 50.0 &&
                                      widget.boxHeight >= 50.0
                                  ? Center(
                                      child: CupertinoActivityIndicator(
                                      radius: 12.8,
                                    ))
                                  : Container(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              color: widget.appBarColor,
              padding: EdgeInsets.symmetric(horizontal: 6.0),
              child: SafeArea(
                child: SizedBox(
                  height: 54.0,
                  child: Row(
                    children: [
                      widget.visiblePopButton
                          ? iconButton(
                              Icons.arrow_back_ios_rounded,
                              widget.iconsColor,
                              () => Navigator.pop(context),
                            )
                          : Container(),
                      const SizedBox(width: 4.0),
                      Expanded(
                        child: Text(
                          widget.title,
                          style: widget.titleStyle,
                        ),
                      ),
                      iconButton(
                        _flashMode == FlashMode.auto
                            ? Icons.flash_auto_outlined
                            : _flashMode == FlashMode.torch
                                ? Icons.flash_on_outlined
                                : Icons.flash_off_outlined,
                        widget.iconsColor,
                        () {
                          if (_flashMode == FlashMode.auto) {
                            _cameraController!.setFlashMode(FlashMode.torch);
                            _flashMode = FlashMode.torch;
                          } else if (_flashMode == FlashMode.torch) {
                            _cameraController!.setFlashMode(FlashMode.off);
                            _flashMode = FlashMode.off;
                          } else {
                            _cameraController!.setFlashMode(FlashMode.auto);
                            _flashMode = FlashMode.auto;
                          }
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              decoration: BoxDecoration(
                color: widget.bottomBarColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.takeButtonColor,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60.0),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor:
                              widget.takeButtonActionColor.withOpacity(0.26),
                          onTap: () async {
                            if (isRunning) {
                              return;
                            }
                            setState(() {
                              isRunning = true;
                            });
                            Uint8List? imageBytes = await _cropPicture();

                            print("finish");
                            if (imageBytes == null) {
                              throw "Camera expansion is very small";
                            }

                            widget.onTake(imageBytes);
                            setState(() {
                              isRunning = false;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.all(1.8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 2.0,
                                color: widget.takeButtonActionColor,
                              ),
                            ),
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color: widget.takeButtonActionColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<Uint8List?> _cropPicture() async {
  XFile xFile = await _cameraController!.takePicture();
  File imageFile = File(xFile.path);
  Uint8List? cropedImage = await cropImage(
    imageFile.path,
    _boxHeightForCrop!.toInt(),
    _boxWidthForCrop!.toInt(),
    _screenHeight!,
    _screenWidth!,
  );

  print("image croped");
  return cropedImage;
}

Widget iconButton(IconData icon, Color color, VoidCallback onTap) {
  return InkWell(
    borderRadius: BorderRadius.circular(22.0),
    onTap: () => onTap(),
    child: Padding(
      padding: EdgeInsets.all(8.0),
      child: Icon(
        icon,
        color: color,
      ),
    ),
  );
}
