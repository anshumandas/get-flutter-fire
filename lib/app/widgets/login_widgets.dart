import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/auth_service.dart';
import '../../models/screens.dart';
import 'menu_sheet_button.dart';

class LoginWidgets {
  static Widget headerBuilder(context, constraints, shrinkOffset) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: AspectRatio(
        aspectRatio: 1,
        child: Image.asset('assets/images/flutterfire_300x.png'),
      ),
    );
  }

  static Widget footerBuilder(myWidget) {
    return Column(
      children: [
        myWidget,
        const Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text(
              'By signing in, you agree to our terms and conditions.',
              style: TextStyle(color: Colors.grey),
            ))
      ],
    );
  }

  static Widget sideBuilder(context, shrinkOffset) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: AspectRatio(
        aspectRatio: 1,
        child: Image.asset('assets/images/flutterfire_300x.png'),
      ),
    );
  }
}

class LoginBottomSheetToggle extends MenuSheetButton<Screen> {
  const LoginBottomSheetToggle(this.current, {super.key});
  final GetNavConfig current;

  @override
  Iterable<Screen> get values {
    MenuItemsController<Screen> controller = Get.find();
    return controller.values.value;
  }

  @override
  Icon? get icon => (AuthService.to.isLoggedInValue)
      ? values.length == 1
          ? const Icon(Icons.logout)
          : const Icon(Icons.menu)
      : const Icon(Icons.login);

  @override
  String? get label => (AuthService.to.isLoggedInValue)
      ? values.length == 1
          ? 'Logout'
          : 'Click for Options'
      : 'Login';

  @override
  void buttonPressed(Iterable<Screen> values) async => values.isEmpty
      ? callbackFunc(await Screen.LOGOUT.doAction())
      : super.buttonPressed(values);

  @override
  Widget build(BuildContext context) {
    MenuItemsController<Screen> controller =
        MenuItemsController<Screen>(const Iterable<Screen>.empty());
    return Obx(() => (AuthService.to.isLoggedInValue)
        ? builder(context, vals: controller.values.value)
        : !(current.currentPage!.name == Screen.LOGIN.path)
            ? IconButton(
                onPressed: () async {
                  await Screen.LOGIN.doAction();
                },
                icon: Icon(Screen.LOGIN.icon),
                tooltip: Screen.LOGIN.label,
              )
            : const SizedBox.shrink());
  }

  Widget builder(BuildContext context, {Iterable<Screen>? vals}) {
    // Implement the logic that was previously handled by `RemotelyConfigObx`
    // You might want to directly use GetX or another method to retrieve and handle configuration
    return SizedBox.shrink(); // Replace with actual implementation
  }
}
