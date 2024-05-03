import 'dart:io';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:image/image.dart';

Future<Uint8List?> rotateImage(File imageFile, {required num angle}) async =>
    await Isolate.run<Uint8List?>(() async {
      Uint8List imgBytes = await imageFile.readAsBytes();

      Image? image = decodeImage(imgBytes);

      if (image == null) {
        return null;
      }

      Image rotatedImage = copyRotate(image, angle: angle);

      List<int> rotatedList = encodeJpg(rotatedImage);
      Uint8List rotatedBytes = Uint8List.fromList(rotatedList);
      return rotatedBytes;
    });
