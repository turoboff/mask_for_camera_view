import 'dart:typed_data';

class MaskForCameraViewResult {
  MaskForCameraViewResult(
      {this.image, this.firstHalfImage, this.secondHalfImage});
  Uint8List? image;
  Uint8List? firstHalfImage;
  Uint8List? secondHalfImage;
}
