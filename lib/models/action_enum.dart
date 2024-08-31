import 'package:flutter/material.dart';

abstract class ActionEnum {
  Future<dynamic> doAction();
  IconData? get icon;
  String? get label;
}
