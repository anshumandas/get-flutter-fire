import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

import 'image_uploads.dart';

class ImageController extends GetxController {
  var files = <File>[].obs;

  Future<void> getFiles() async {
    // Use file picker to select files
    final pickedFiles = await FilePicker.platform.pickFiles(allowMultiple: true);

    if (pickedFiles != null) {
      files.value = pickedFiles.paths.map((path) => File(path!)).toList();
      Get.to(() => ImageUploads()); // Navigate to the upload screen
    }
  }
}
