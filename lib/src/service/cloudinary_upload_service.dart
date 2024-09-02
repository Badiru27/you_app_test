import 'dart:io';

import 'package:cloudinary/cloudinary.dart';
import 'package:logger/logger.dart';

class CloudinaryUploadService {
  final cloudinary = Cloudinary.signedConfig(
    cloudName: 'dvccilbf7',
    apiSecret: 'XjSlUlERKbWYbbmocvjYs2PxbY4',
    apiKey: '292826973154556',
  );

  final log = Logger();

  Future<String?> uploadImage(File file, String name) async {
    try {
      final response = await cloudinary.upload(
          file: file.path,
          fileBytes: file.readAsBytesSync(),
          resourceType: CloudinaryResourceType.image,
          folder: 'you-app',
          fileName: name,
          progressCallback: (count, total) {
            log.i('Uploading image from file with progress: $count/$total');
          });

      if (response.isSuccessful) {
        return response.secureUrl;
      }
    } catch (e) {
      log.e(e.toString());
      return null;
    }

    return null;
  }
}
