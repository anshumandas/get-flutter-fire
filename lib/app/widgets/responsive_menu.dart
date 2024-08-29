import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/action_enum.dart'; // Adjust path as necessary

class ResponsiveMenu extends StatelessWidget {
  final Iterable<ActionEnum> values;
  final void Function(String?)? onSelect;

  const ResponsiveMenu({
    Key? key,
    required this.values,
    this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetPlatform.isWeb
        ? PopupMenuButton<ActionEnum>(
            itemBuilder: (context) => values
                .map((e) => PopupMenuItem<ActionEnum>(
                      value: e,
                      child: Text(e.label ?? ''),
                    ))
                .toList(),
            onSelected: (ActionEnum value) {
              onSelect?.call(value.label);
            },
          )
        : IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => _buildBottomSheet(context),
              );
            },
          );
  }

  Widget _buildBottomSheet(BuildContext context) {
    return ListView(
      children: values.map((e) {
        return ListTile(
          leading: Icon(e.icon),
          title: Text(e.label ?? ''),
          onTap: () {
            Navigator.pop(context);
            onSelect?.call(e.label);
          },
        );
      }).toList(),
    );
  }
}
