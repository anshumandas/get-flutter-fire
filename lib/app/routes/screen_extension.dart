part of 'app_pages.dart';

extension GetViewExtension on GetView {
  static final _screens = Expando<Screen>();

  Screen? get screen => _screens[this];
  set screen(Screen? x) => _screens[this] = x;
}

extension GetWidgetExtension on GetWidget {
  static final _screens = Expando<Screen>();

  Screen? get screen => _screens[this];
  set screen(Screen? x) => _screens[this] = x;
}

extension GetPageExtension on GetPage {}

extension ScreenExtension on Screen {
  GetPage<dynamic> getPage(
      {required GetView Function() page,
      Bindings? binding,
      List<Bindings> bindings = const [],
      List<GetMiddleware>? middlewares,
      List<GetPage<dynamic>>? children,
      bool preventDuplicates = true,
      Role? role}) {
    // we are injecting the Screen variable here
    pageW() {
      GetView p = page();
      p.screen = this;
      return p;
    }

    //check role and screen mapping for rolebased access
    if (accessLevel == AccessLevel.roleBased) {
      if (role == null &&
          (parent == null || parent!.accessLevel != AccessLevel.roleBased)) {
        throw Exception("Role must be provided for RoleBased Screens");
      }
      if (role != null && !role.permissions.contains(this)) {
        throw Exception("Role must permit this Screen");
      }
    }

    return _getPage(pageW, binding, bindings, middlewares, children,
        preventDuplicates, role);
  }

  GetPage<dynamic> getPages(
      {required GetWidget Function() page,
      Bindings? binding,
      List<Bindings> bindings = const [],
      List<GetMiddleware>? middlewares,
      List<GetPage<dynamic>>? children,
      bool preventDuplicates = false,
      Role? role}) {
    pageW() {
      GetWidget p = page();
      p.screen = this;
      return p;
    }

    return _getPage(pageW, binding, bindings, middlewares, children,
        preventDuplicates, role);
  }

  GetPage<dynamic> _getPage(
      Widget Function() pageW,
      Bindings? binding,
      List<Bindings> bindings,
      List<GetMiddleware>? middlewares,
      List<GetPage<dynamic>>? children,
      bool preventDuplicates,
      Role? role) {
    return binding != null
        ? GetPage(
            preventDuplicates: preventDuplicates,
            middlewares: middlewares ?? defaultMiddlewares(role),
            name: path,
            page: pageW,
            title: label,
            transition: Transition.fade,
            binding: binding,
            children: children ?? const [])
        : GetPage(
            preventDuplicates: preventDuplicates,
            middlewares: middlewares,
            name: path,
            page: pageW,
            title: label,
            transition: Transition.fade,
            bindings: bindings,
            children: children ?? const []);
  }

  List<GetMiddleware>? defaultMiddlewares(Role? role) => (parent == null ||
          parent!.accessLevel.index < accessLevel.index)
      ? switch (accessLevel) {
          AccessLevel.public => null,
          AccessLevel.guest => [EnsureAuthOrGuestMiddleware()],
          AccessLevel.authenticated => [EnsureAuthedAndNotGuestMiddleware()],
          AccessLevel.roleBased => [EnsureRoleMiddleware(role ?? Role.buyer)],
          AccessLevel.masked => throw UnimplementedError(), //not for screens
          AccessLevel.secret => throw UnimplementedError(), //not for screens
          AccessLevel.notAuthed => [EnsureNotAuthedOrGuestMiddleware()],
        }
      : null;
}

extension RoleExtension on Role {
  int getCurrentIndexFromRoute(GetNavConfig? currentRoute) {
    final String? currentLocation = currentRoute?.uri.toString();
    int currentIndex = 0;
    if (currentLocation != null && currentLocation.startsWith('/home')) {
      // removinng '/home' from the start of the location
      final filteredLocation = currentLocation.replaceFirst('/home', '');
      currentIndex = tabs.indexWhere((tab) {
        return filteredLocation.startsWith(tab.path);
      });
    }
    return (currentIndex > 0) ? currentIndex : 0;
  }

  void routeTo(int value, GetDelegate delegate) {
    delegate.toNamed(tabs[value].route, arguments: {'role': this});
  }
}
