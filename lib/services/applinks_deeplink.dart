import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AppLinksDeepLink extends GetxController {
  static AppLinksDeepLink get instance => Get.find<AppLinksDeepLink>();

  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;

  @override
  void onInit() {
    super.onInit();
    _appLinks = AppLinks();
    initDeepLinks();
  }

  Future<void> initDeepLinks() async {
    // Check initial link if app was terminated
    final Uri? appLink = await _appLinks.getInitialLink();
    if (appLink != null) {
      _handleDeepLink(appLink);
    }

    // foreground or background
    _linkSubscription = _appLinks.uriLinkStream.listen(
      (Uri? uriValue) {
        if (uriValue != null) {
          _handleDeepLink(uriValue);
        }
      },
      onError: (err) {
        debugPrint('====>>> error : $err');
      },
    );
  }

  void _handleDeepLink(Uri uri) {
    print('Deep link received: $uri');
    // logic to navigate
  }

  @override
  void onClose() {
    _linkSubscription?.cancel();
    super.onClose();
  }
}
