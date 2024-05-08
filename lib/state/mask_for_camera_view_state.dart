import 'package:camera/camera.dart';
import 'package:mask_for_camera_view/mask_for_camera_view_result.dart';

abstract class MaskForCameraViewState {}

class MaskForCameraViewOnTake extends MaskForCameraViewState {
  final XFile takenImage;

  MaskForCameraViewOnTake({
    required this.takenImage,
  });
}

class MaskForCameraViewOnCropped extends MaskForCameraViewState {
  final MaskForCameraViewResult? result;

  MaskForCameraViewOnCropped({
    required this.result,
  });
}
