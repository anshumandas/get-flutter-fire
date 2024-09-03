import 'package:get/get.dart';
import 'package:get_flutter_fire/models/screens.dart';
import '../../models/role.dart';
import '../../services/auth_service.dart';

class EnsureNotAuthedMiddleware extends GetMiddleware {
  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    if (AuthService.to.isLoggedIn && !AuthService.to.user!.isAnonymous) {
      return GetNavConfig.fromRoute(Screen.HOME.route);
    }
    return await super.redirectDelegate(route);
  }
}

class EnsureAuthedMiddleware extends GetMiddleware {
  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    if (!AuthService.to.isLoggedIn || AuthService.to.user!.isAnonymous) {
      return GetNavConfig.fromRoute(Screen.LOGIN.route +
          '?then=${Uri.encodeQueryComponent(route.location)}');
    }
    return await super.redirectDelegate(route);
  }
}

class EnsureRoleMiddleware extends GetMiddleware {
  final Role role;
  EnsureRoleMiddleware(this.role);

  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    if (!AuthService.to.isLoggedIn || !AuthService.to.hasRole(role)) {
      return GetNavConfig.fromRoute(Screen.LOGIN.route +
          '?then=${Uri.encodeQueryComponent(route.location)}');
    }
    return await super.redirectDelegate(route);
  }
}

class EnsureAuthOrGuestMiddleware extends GetMiddleware {
  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    if (!AuthService.to.isLoggedIn) {
      bool? value = await AuthService.to.signInAnonymously();
      if (value != true) {
        return GetNavConfig.fromRoute(Screen.LOGIN.route);
      }
    }
    return await super.redirectDelegate(route);
  }
}
