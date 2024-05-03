import 'dart:typed_data';

class MaskForCameraViewResult {
  MaskForCameraViewResult(
      {this.croppedImage, this.firstPartImage, this.secondPartImage});
  Uint8List? croppedImage;
  Uint8List? firstPartImage;
  Uint8List? secondPartImage;

  void copyFrom(MaskForCameraViewResult newResult) {
    croppedImage = newResult.croppedImage ?? croppedImage;
    firstPartImage = newResult.firstPartImage ?? firstPartImage;
    secondPartImage = newResult.secondPartImage ?? secondPartImage;
  }
}
