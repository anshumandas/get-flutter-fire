import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

enum ImageSources { camera, gallery, file }

//TODO abstract out the menuOrBottomSheet component

class ImagePickerButton extends StatefulWidget {
  final ValueSetter<String?> callback;

  const ImagePickerButton(this.callback, {super.key});

  @override
  State<ImagePickerButton> createState() => _ImagePickerButtonState();
}

class _ImagePickerButtonState extends State<ImagePickerButton> {
  static List<PopupMenuEntry<ImageSources>> getItems(BuildContext context) {
    return [
      const PopupMenuItem<ImageSources>(
        value: ImageSources.camera,
        child: Text('Camera'),
      ),
      const PopupMenuItem<ImageSources>(
        value: ImageSources.gallery,
        child: Text('Gallery'),
      ),
      const PopupMenuItem<ImageSources>(
        value: ImageSources.file,
        child: Text('File'),
      ),
    ];
  }

  static Future<String?> select(ImageSources value) async {
    switch (value) {
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

//This should be a modal bottom sheet if on Mobile (See https://mercyjemosop.medium.com/select-and-upload-images-to-firebase-storage-flutter-6fac855970a9)

  void _showPicker(context) {
    Get.bottomSheet(
      SizedBox(
        height: 180,
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text(
                  'Gallery',
                ),
                onTap: () async {
                  Get.back();
                  widget.callback(await getImage(ImageSource.gallery));
                }),
            ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () async {
                  Get.back();
                  widget.callback(await getImage(ImageSource.camera));
                }),
            ListTile(
                leading: const Icon(Icons.file_upload),
                title: const Text('File'),
                onTap: () async {
                  Get.back();
                  widget.callback(await getFile());
                  // Navigator.of(context).pop();
                }),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return !(GetPlatform.isAndroid || GetPlatform.isIOS)
        ? IconButton(
            onPressed: () async => widget.callback(await getFile()),
            icon: const Icon(Icons.image),
            tooltip: 'Pick an Image from',
          )
        : Get.mediaQuery.orientation == Orientation.portrait
            // : Get.context!.isPortrait
            ? IconButton(
                onPressed: () => _showPicker(context),
                icon: const Icon(Icons.image),
                tooltip: 'Pick an Image from',
              )
            : PopupMenuButton<ImageSources>(
                itemBuilder: getItems,
                icon: const Icon(Icons.image),
                initialValue: ImageSources.gallery,
                tooltip: 'Pick an Image from',
                onSelected: (ImageSources value) async =>
                    {widget.callback(await select(value))});
  }
}
