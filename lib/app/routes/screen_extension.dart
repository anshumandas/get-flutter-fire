part of 'app_pages.dart';

extension ScreenExtension on Screen {
  GetPage<dynamic> getPage(
          {required Widget Function() page,
          Bindings? binding,
          List<Bindings> bindings = const [],
          List<GetMiddleware>? middlewares,
          List<GetPage<dynamic>>? children,
          bool preventDuplicates = false,
          Role? role}) =>
      binding != null
          ? GetPage(
              preventDuplicates: preventDuplicates,
              middlewares: middlewares ?? defaultMiddlewares(role),
              name: path,
              page: page,
              title: label,
              transition: Transition.fade,
              binding: binding,
              children: children ?? const [])
          : GetPage(
              preventDuplicates: preventDuplicates,
              middlewares: middlewares,
              name: path,
              page: page,
              title: label,
              transition: Transition.fade,
              bindings: bindings,
              children: children ?? const []);

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
