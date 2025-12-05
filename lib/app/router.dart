import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../ui/views/login/login_view.dart';
import '../ui/views/users/users_view.dart';
import '../ui/views/shipments/list/shipments_list_view.dart';
import '../ui/views/shipments/create/create_shipment_view.dart';
import '../ui/views/shipments/detail/shipment_detail_view.dart';
import '../ui/views/track/track_view.dart';

part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page, initial: true, path: '/'),
        AutoRoute(page: ShipmentsListRoute.page, path: '/shipments'),
        AutoRoute(page: CreateShipmentRoute.page, path: '/shipments/create'),
        AutoRoute(page: ShipmentDetailRoute.page, path: '/shipments/:id'),
        AutoRoute(page: UsersRoute.page, path: '/users'),
        AutoRoute(page: TrackRoute.page, path: '/track'),
      ];
}
