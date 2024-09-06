import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/action_enum.dart';

class MenuItemsController<T extends ActionEnum> extends GetxController {
  MenuItemsController(Iterable<T> iter) : values = Rx<Iterable<T>>(iter);
  final Rx<Iterable<T>> values;
}

class MenuSheetButton<T extends ActionEnum> extends StatelessWidget {
  final Iterable<T>? values_;
  final Icon? icon;
  final String? label;

  const MenuSheetButton(
      {super.key,
      this.values_,
      this.icon,
      this.label});

  Iterable<T> get values => values_!;

  static Widget bottomSheet(
      Iterable<ActionEnum> values, ValueSetter<String?>? callback) {
    return SizedBox(
      height: 180,
      width: Get.mediaQuery.size.width,
      child: ListView(
        children: values
            .map(
              (ActionEnum value) => ListTile(
                  leading: Icon(value.icon),
                  title: Text(
                    value.label!,
                  ),
                  onTap: () async {
                    Get.back();
                    callback != null
                        ? callback(await value.doAction())
                        : await value.doAction();
                  }),
            )
            .toList(),
      ),
    );
  }

  List<PopupMenuEntry<T>> getItems(BuildContext context, Iterable<T> values) {
    return values.map<PopupMenuEntry<T>>(createPopupMenuItem).toList();
  }

  PopupMenuEntry<T> createPopupMenuItem(dynamic value) => PopupMenuItem<T>(
        value: value,
        child: Text(value.label ?? ''),
      );

  @override
  Widget build(BuildContext context) {
    return builder(context);
  }

  Widget builder(BuildContext context, {Iterable<T>? vals}) {
    Iterable<T> values = vals ?? values_!;
    return values.length <= 1 ||
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
                callbackFunc(await value.doAction()));
  }

  void buttonPressed(Iterable<T> values) async => values.length == 1
      ? callbackFunc(await values.first.doAction())
      : Get.bottomSheet(MenuSheetButton.bottomSheet(values, callbackFunc),
          backgroundColor: Colors.white);

  void callbackFunc(act) {}
}
