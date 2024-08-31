import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import 'menu_sheet_button.dart';

enum ImageSources {
  camera(Icons.camera, 'Camera'),
  gallery(Icons.photo_library, 'Gallery'),
  file(Icons.file_upload, 'File');

  const ImageSources(this.icon, this.label);

  final IconData? icon;
  final String? label;

  Future<String?> doAction() async {
    switch (this) {
      case ImageSources.camera:
        return await getImage(ImageSource.camera);
      case ImageSources.gallery:
        return await getImage(ImageSource.gallery);
      case ImageSources.file:
        return await getFile();
      default:
        return null;
    }
  }

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
    } else {
      Get.snackbar('Error', 'Image Not Selected');
      return null;
    }
  }
}

class ImagePickerButton extends StatelessWidget {
  final ValueSetter<String?>? callback;

  const ImagePickerButton({
    Key? key,
    this.callback,
  }) : super(key: key);

  void callbackFunc(String? act) {
    if (callback != null && act != null) {
      callback!(act);
    } else if (act == null) {
      Get.snackbar('Error', 'No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return !GetPlatform.isAndroid && !GetPlatform.isIOS
        ? TextButton.icon(
      onPressed: () async => callbackFunc(await ImageSources.getFile()),
      icon: const Icon(Icons.image),
      label: const Text('Pick an Image'),
    )
        : IconButton(
      icon: const Icon(Icons.image),
      onPressed: () async {
        final result = await showModalBottomSheet<ImageSources>(
          context: context,
          builder: (context) => _buildBottomSheet(),
        );
        if (result != null) {
          final actionResult = await result.doAction();
          callbackFunc(actionResult);
        }
      },
    );
  }

  Widget _buildBottomSheet() {
    return SizedBox(
      height: 180,
      child: ListView(
        children: ImageSources.values.map((source) {
          return ListTile(
            leading: Icon(source.icon),
            title: Text(source.label ?? ''),
            onTap: () => Get.back(result: source),
          );
        }).toList(),
      ),
    );
  }
}
