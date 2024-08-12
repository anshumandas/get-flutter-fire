import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/action_enum.dart';
import 'menu_sheet_button.dart';

enum ImageSources implements ActionEnum {
  camera(Icons.camera, 'Camera'),
  gallery(Icons.photo_library, 'Gallery'),
  file(Icons.file_upload, 'File');

  const ImageSources(this.icon, this.label);

  @override
  Future<dynamic> doAction() async {
    switch (this) {
      case ImageSources.camera:
        return await getImage(ImageSource.camera);
      case ImageSources.gallery:
        return await getImage(ImageSource.gallery);
      case ImageSources.file:
        return await getFile();
      default:
    }
    return null;
  }

  @override
  final IconData? icon;
  @override
  final String? label;

  static Future<String?> getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      return pickedFile.path;
    } else {
      Get.snackbar('Error', 'Image Not Selected');
      return null;
    }
  }

  static Future<String?> getFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: false);

    if (result != null && result.files.isNotEmpty) {
      final fileBytes = result.files.first.bytes;
      final fileName = result.files.first.name;
      GetStorage().write(fileName, fileBytes);

      return fileName;
      //result.files.single.path;//is causing issues for Web, see https://github.com/miguelpruivo/flutter_file_picker/wiki/FAQ
    } else {
      Get.snackbar('Error', 'Image Not Selected');
      return null;
    }
  }
}

class ImagePickerButton extends MenuSheetButton<ImageSources> {
  final ValueSetter<String>? callback;

  const ImagePickerButton(
      {super.key,
      super.icon = const Icon(Icons.image),
      super.label = 'Pick an Image',
      this.callback});

  @override
  Iterable<ImageSources> get values => ImageSources.values;

  @override
  void callbackFunc(act) {
    if (callback != null) callback!(act);
  }

  @override
  Widget build(BuildContext context) {
    return !(GetPlatform.isAndroid || GetPlatform.isIOS)
        ? TextButton.icon(
            onPressed: () async => callbackFunc(await ImageSources.getFile()),
            icon: icon,
            label: const Text('Pick an Image'),
          )
        : builder(context, vals: values);
  }
}
