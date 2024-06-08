// ignore_for_file: avoid_print

import 'package:get/get.dart';

import '../../services/auth_service.dart';
import '../routes/app_pages.dart';

Future<GetNavConfig?> loginVerify(bool check, GetNavConfig route,
    Future<GetNavConfig?> Function(GetNavConfig) redirector) async {
  final newRoute = Routes.LOGIN_THEN(route.location);
  if (check) {
    return GetNavConfig.fromRoute(newRoute);
  }

  return await redirector(route);
}

class EnsureAuthMiddleware extends GetMiddleware {
  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    // you can do whatever you want here
    // but it's preferable to make this method fast

    return await loginVerify(
        !AuthService.to.isLoggedInValue, route, super.redirectDelegate);
  }
}

class EnsureNotAuthedOrGuestMiddleware extends GetMiddleware {
  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    if (AuthService.to.isLoggedInValue && !AuthService.to.isAnon) {
      //NEVER navigate to auth screen, when user is already authed
      return GetNavConfig.fromRoute(Routes.HOME);
    }
    return await super.redirectDelegate(route);
  }
}

class EnsureAuthedAndNotGuestMiddleware extends GetMiddleware {
  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    return await loginVerify(
        !AuthService.to.isLoggedInValue || AuthService.to.isAnon,
        route,
        super.redirectDelegate);
  }
}

class EnsureAdminMiddleware extends GetMiddleware {
  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    // you can do whatever you want here
    // but it's preferable to make this method fast

    if (!AuthService.to.isLoggedInValue || AuthService.to.isAdmin) {
      final newRoute = Routes.LOGIN_THEN(route.location);
      return GetNavConfig.fromRoute(newRoute);
    }
    return await super.redirectDelegate(route);
  }
}

class EnsureGuestMiddleware extends GetMiddleware {
  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    // you can do whatever you want here
    // but it's preferable to make this method fast
    // In this case this is taking human input and is not fast

    if (!AuthService.to.isLoggedInValue) {
      bool? value = await AuthService.to.guest();
      if (value != true) {
        return GetNavConfig.fromRoute(Routes.LOGIN);
      }
    }
    return await super.redirectDelegate(route);
  }
}
