import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get_storage/get_storage.dart';
import '../../models/action_enum.dart';

class MenuItemsController<T extends ActionEnum> extends GetxController {
  MenuItemsController(Iterable<T> iter) : values = Rx<Iterable<T>>(iter);

  final Rx<Iterable<T>> values;
}

class MenuSheetButton<T extends ActionEnum> extends StatelessWidget {
  final Iterable<T>? values_;
  final Icon? icon;
  final String? label;

  const MenuSheetButton({
    super.key,
    this.values_,
    this.icon,
    this.label,
  });

  Iterable<T> get values => values_ ?? const [];

  static Widget bottomSheet(
      Iterable<ActionEnum> values, ValueSetter<dynamic>? callback) {
    return SizedBox(
      height: 180,
      width: Get.mediaQuery.size.width,
      child: ListView(
        children: values
            .map(
              (ActionEnum value) => ListTile(
            leading: Icon(value.icon),
            title: Text(value.label ?? ''),
            onTap: () async {
              Get.back();
              callback?.call(await value.doAction());
            },
          ),
        )
            .toList(),
      ),
    );
  }

  List<PopupMenuEntry<T>> getItems(BuildContext context, Iterable<T> values) {
    return values.map<PopupMenuEntry<T>>(createPopupMenuItem).toList();
  }

  PopupMenuEntry<T> createPopupMenuItem(T value) => PopupMenuItem<T>(
    value: value,
    child: Text(value.label ?? ''),
  );

  @override
  Widget build(BuildContext context) {
    return builder(context);
  }

  Widget builder(BuildContext context, {Iterable<T>? vals}) {
    Iterable<T> values = vals ?? this.values;
    if (values.isEmpty) {
      return const SizedBox.shrink();
    }
    return values.length == 1 ||
        Get.mediaQuery.orientation == Orientation.portrait
        ? (icon != null
        ? IconButton(
      onPressed: () => buttonPressed(values),
      icon: icon!,
      tooltip: label,
    )
        : TextButton(
        onPressed: () => buttonPressed(values),
        child: Text(label ?? 'Need Label')))
        : PopupMenuButton<T>(
      itemBuilder: (context_) => getItems(context_, values),
      icon: icon,
      tooltip: label,
      onSelected: (T value) async =>
          callbackFunc(await value.doAction()),
    );
  }

  void buttonPressed(Iterable<T> values) async {
    if (values.length == 1) {
      callbackFunc(await values.first.doAction());
    } else {
      Get.bottomSheet(MenuSheetButton.bottomSheet(values, callbackFunc),
          backgroundColor: Colors.white);
    }
  }

  void callbackFunc(dynamic act) {}
}

class ImagePickerButton extends StatelessWidget {
  final ValueSetter<String?>? callback;

  const ImagePickerButton({
    super.key,
    this.icon = const Icon(Icons.image),
    this.label = 'Pick an Image',
    this.callback,
  });

  final Icon icon;
  final String label;

  void callbackFunc(dynamic act) {
    if (callback != null && act is String?) {
      callback!(act);
    } else if (act == null) {
      Get.snackbar('Error', 'No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return !(GetPlatform.isAndroid || GetPlatform.isIOS)
        ? TextButton.icon(
      onPressed: () async => callbackFunc(await ImageSources.getFile()),
      icon: icon,
      label: const Text('Pick an Image'),
    )
        : IconButton(
      icon: icon,
      tooltip: label,
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

// Assuming you have an enum called ImageSources
enum ImageSources implements ActionEnum {
  camera(Icons.camera, 'Camera'),
  gallery(Icons.photo_library, 'Gallery'),
  file(Icons.file_upload, 'File');

  const ImageSources(this.icon, this.label);

  @override
  final IconData? icon;
  @override
  final String? label;

  @override
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
