// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    CreateShipmentRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CreateShipmentView(),
      );
    },
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginView(),
      );
    },
    ShipmentDetailRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ShipmentDetailRouteArgs>(
          orElse: () =>
              ShipmentDetailRouteArgs(id: pathParams.getString('id')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ShipmentDetailView(
          key: args.key,
          id: args.id,
        ),
      );
    },
    ShipmentsListRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ShipmentsListView(),
      );
    },
    TrackRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TrackView(),
      );
    },
    UsersRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const UsersView(),
      );
    },
  };
}

/// generated route for
/// [CreateShipmentView]
class CreateShipmentRoute extends PageRouteInfo<void> {
  const CreateShipmentRoute({List<PageRouteInfo>? children})
      : super(
          CreateShipmentRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateShipmentRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginView]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ShipmentDetailView]
class ShipmentDetailRoute extends PageRouteInfo<ShipmentDetailRouteArgs> {
  ShipmentDetailRoute({
    Key? key,
    required String id,
    List<PageRouteInfo>? children,
  }) : super(
          ShipmentDetailRoute.name,
          args: ShipmentDetailRouteArgs(
            key: key,
            id: id,
          ),
          rawPathParams: {'id': id},
          initialChildren: children,
        );

  static const String name = 'ShipmentDetailRoute';

  static const PageInfo<ShipmentDetailRouteArgs> page =
      PageInfo<ShipmentDetailRouteArgs>(name);
}

class ShipmentDetailRouteArgs {
  const ShipmentDetailRouteArgs({
    this.key,
    required this.id,
  });

  final Key? key;

  final String id;

  @override
  String toString() {
    return 'ShipmentDetailRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [ShipmentsListView]
class ShipmentsListRoute extends PageRouteInfo<void> {
  const ShipmentsListRoute({List<PageRouteInfo>? children})
      : super(
          ShipmentsListRoute.name,
          initialChildren: children,
        );

  static const String name = 'ShipmentsListRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TrackView]
class TrackRoute extends PageRouteInfo<void> {
  const TrackRoute({List<PageRouteInfo>? children})
      : super(
          TrackRoute.name,
          initialChildren: children,
        );

  static const String name = 'TrackRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [UsersView]
class UsersRoute extends PageRouteInfo<void> {
  const UsersRoute({List<PageRouteInfo>? children})
      : super(
          UsersRoute.name,
          initialChildren: children,
        );

  static const String name = 'UsersRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
