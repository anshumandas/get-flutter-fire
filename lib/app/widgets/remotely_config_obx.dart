import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/remote_config.dart';

class RemoteConfigController<L extends Iterable> extends GetxController {
  RemoteConfigController(L iter) : values = Rx<L>(iter);
  final Rx<L> values;
}

class RemotelyConfigObx<X, C extends RemoteConfigController<Iterable<X>>>
    extends ObxWidget {
  final Widget Function() builder;
  final X param;
  final C controller;
  final String config;
  final Typer configType;
  final Future Function(X) func;

  RemotelyConfigObx(this.builder, this.controller, this.func, this.param,
      this.config, this.configType,
      {super.key}) {
    Get.put(controller, permanent: true); //must make true else gives error
    func(param).then((v) {
      controller.values.value = v;
    });
    RemoteConfig.instance.then((ins) => ins.addListener(config, configType,
            (val) async => {controller.values.value = await func(param)}));
  }

  @override
  Widget build() => builder();
}

class RemotelyConfigObxVal<T extends RxObjectMixin, X> extends ObxWidget {
  final Widget Function(T) builder;
  final T data;
  final String config;
  final Typer configType;

  RemotelyConfigObxVal(this.builder, this.data, this.config, this.configType,
      {super.key, required Future Function(X) func, required X param}) {
    func(param).then((v) => {data.value = v});
    RemoteConfig.instance.then((ins) => ins.addListener(
        config, configType, (val) async => {data.value = await func(param)}));
  }

  RemotelyConfigObxVal.noparam(
      this.builder, this.data, this.config, this.configType,
      {super.key, required Future Function() func}) {
    func().then((v) => {data.value = v});
    RemoteConfig.instance.then((ins) => ins.addListener(
        config, configType, (val) async => {data.value = await func()}));
  }

  @override
  Widget build() => builder(data);
}