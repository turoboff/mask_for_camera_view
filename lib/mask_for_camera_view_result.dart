import 'dart:typed_data';

class MaskForCameraViewResult {
  MaskForCameraViewResult(
      {this.croppedImage, this.firstPartImage, this.secondPartImage});
  Uint8List? croppedImage;
  Uint8List? firstPartImage;
  Uint8List? secondPartImage;
}
