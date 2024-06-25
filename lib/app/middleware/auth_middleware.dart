// ignore_for_file: avoid_print
import 'package:get/get.dart';
import 'package:get_flutter_fire/models/role.dart';

import '../../services/auth_service.dart';
import '../routes/app_pages.dart';

Future<GetNavConfig?> loginVerify(bool check, GetNavConfig route,
    Future<GetNavConfig?> Function(GetNavConfig) redirector) async {
  final newRoute = route.location == Routes.LOGIN
      ? Routes.LOGIN
      : Routes.LOGIN_THEN(route.location);
  if (check) {
    return GetNavConfig.fromRoute(newRoute);
  }

  // Below could be used if the login was happening without verification.
  // This will never get reached if server is sending error in login due to non verification
  // With customClaims status == "creating", it will reach here for SignUp case only
  if (!AuthService.to.isEmailVerified && !AuthService.to.registered.value) {
    return GetNavConfig.fromRoute(route.location == Routes.REGISTER
        ? Routes.REGISTER
        : Routes.REGISTER_THEN(route.location));
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
      return GetNavConfig.fromRoute(
          AuthService.to.registered.value ? Routes.HOME : Routes.REGISTER);
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

class EnsureRoleMiddleware extends GetMiddleware {
  Role role;
  EnsureRoleMiddleware(this.role);

  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    if (!AuthService.to.isLoggedInValue || !AuthService.to.hasRole(role)) {
      final newRoute = Routes.LOGIN_THEN(route.location);
      return GetNavConfig.fromRoute(newRoute);
    }
    return await super.redirectDelegate(route);
  }
}

class EnsureAuthOrGuestMiddleware extends GetMiddleware {
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
