// ignore_for_file: inference_failure_on_function_invocation

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

// class SwitchX extends GetxController {
//   RxBool isLoginPage =
//       (Get.rootDelegate.currentConfiguration!.currentPage!.name ==
//               Screen.LOGIN.path)
//           .obs; // our observable

//   void toggle(Screen screen) {
//     isLoginPage.value = screen == Screen.LOGIN;
//   }
// }

class LoginBottomSheetToggle extends MenuSheetButton<Screen> {
  const LoginBottomSheetToggle(this.current, {super.key});
  final GetNavConfig current;

  @override
  Iterable<Screen> get values => Screen.sheet(null);

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

  // @override
  // void callbackFunc(act) {
  //   SwitchX controller = Get.find();
  //   controller.toggle(Screen.LOGIN);
  // }

  @override
  Widget build(BuildContext context) {
    // SwitchX controller =
    //     Get.put(SwitchX(), permanent: true); //must make true else gives error
    return Obx(() => (AuthService.to.isLoggedInValue)
        ? builder(context)
        : !(current.currentPage!.name == Screen.LOGIN.path)
            ? IconButton(
                onPressed: () async {
                  await Screen.LOGIN.doAction();
                  // controller.toggle(Screen.LOGIN);
                },
                icon: Icon(Screen.LOGIN.icon),
                tooltip: Screen.LOGIN.label,
              )
            : const SizedBox.shrink()); //should be only for loggedin case
  }
}
