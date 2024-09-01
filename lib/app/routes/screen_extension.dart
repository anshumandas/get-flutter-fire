part of 'app_pages.dart';

extension ScreenExtension on Screen {
  GetPage<dynamic> getPage({
    required Widget Function() page,
    Bindings? binding,
    List<Bindings> bindings = const [],
    List<GetMiddleware>? middlewares,
    List<GetPage<dynamic>>? children,
    bool preventDuplicates = true,
    Role? role,
  }) {
    return GetPage(
      name: this.route,
      page: page,
      binding: binding,
      bindings: bindings,
      middlewares: middlewares ?? defaultMiddlewares(role),
      children: children ?? [],
      preventDuplicates: preventDuplicates,
    );
  }

  List<GetMiddleware>? defaultMiddlewares(Role? role) {
    switch (this.accessLevel) {
      case AccessLevel.public:
        return null;
      case AccessLevel.guest:
        return [EnsureAuthOrGuestMiddleware()];
      case AccessLevel.authenticated:
        return [EnsureAuthedMiddleware()];
      case AccessLevel.roleBased:
        return [
          EnsureAuthedMiddleware(),
          EnsureRoleMiddleware(role ?? Role.buyer)
        ];
      case AccessLevel.notAuthed:
        return [EnsureNotAuthedMiddleware()];
      default:
        return null;
    }
  }

  GetPage<dynamic> getPages({
    required Widget Function() page,
    Bindings? binding,
    List<Bindings> bindings = const [],
    List<GetMiddleware>? middlewares,
    bool preventDuplicates = false,
    Role? role,
  }) {
    return getPage(
      page: page,
      binding: binding,
      bindings: bindings,
      middlewares: middlewares,
      preventDuplicates: preventDuplicates,
      role: role,
    );
  }
}
