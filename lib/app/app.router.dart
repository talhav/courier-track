// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i8;
import 'package:flutter/material.dart';
import 'package:frontend/core/models/models.dart' as _i9;
import 'package:frontend/ui/views/login/login_view.dart' as _i2;
import 'package:frontend/ui/views/shipments/create/create_shipment_view.dart'
    as _i4;
import 'package:frontend/ui/views/shipments/detail/shipment_detail_view.dart'
    as _i5;
import 'package:frontend/ui/views/shipments/list/shipments_list_view.dart'
    as _i3;
import 'package:frontend/ui/views/track/track_view.dart' as _i7;
import 'package:frontend/ui/views/users/users_view.dart' as _i6;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i10;

class Routes {
  static const loginView = '/';

  static const shipmentsListView = '/shipments-list-view';

  static const createShipmentView = '/create-shipment-view';

  static const shipmentDetailView = '/shipment-detail-view';

  static const usersView = '/users-view';

  static const trackView = '/track-view';

  static const all = <String>{
    loginView,
    shipmentsListView,
    createShipmentView,
    shipmentDetailView,
    usersView,
    trackView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.loginView,
      page: _i2.LoginView,
    ),
    _i1.RouteDef(
      Routes.shipmentsListView,
      page: _i3.ShipmentsListView,
    ),
    _i1.RouteDef(
      Routes.createShipmentView,
      page: _i4.CreateShipmentView,
    ),
    _i1.RouteDef(
      Routes.shipmentDetailView,
      page: _i5.ShipmentDetailView,
    ),
    _i1.RouteDef(
      Routes.usersView,
      page: _i6.UsersView,
    ),
    _i1.RouteDef(
      Routes.trackView,
      page: _i7.TrackView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.LoginView: (data) {
      return _i8.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.LoginView(),
        settings: data,
      );
    },
    _i3.ShipmentsListView: (data) {
      return _i8.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.ShipmentsListView(),
        settings: data,
      );
    },
    _i4.CreateShipmentView: (data) {
      return _i8.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.CreateShipmentView(),
        settings: data,
      );
    },
    _i5.ShipmentDetailView: (data) {
      final args = data.getArgs<ShipmentDetailViewArguments>(
        orElse: () => const ShipmentDetailViewArguments(),
      );
      return _i8.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i5.ShipmentDetailView(key: args.key, shipment: args.shipment),
        settings: data,
      );
    },
    _i6.UsersView: (data) {
      return _i8.MaterialPageRoute<dynamic>(
        builder: (context) => const _i6.UsersView(),
        settings: data,
      );
    },
    _i7.TrackView: (data) {
      return _i8.MaterialPageRoute<dynamic>(
        builder: (context) => const _i7.TrackView(),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class ShipmentDetailViewArguments {
  const ShipmentDetailViewArguments({
    this.key,
    this.shipment,
  });

  final _i8.Key? key;

  final _i9.Shipment? shipment;

  @override
  String toString() {
    return '{"key": "$key", "shipment": "$shipment"}';
  }

  @override
  bool operator ==(covariant ShipmentDetailViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.shipment == shipment;
  }

  @override
  int get hashCode {
    return key.hashCode ^ shipment.hashCode;
  }
}

extension NavigatorStateExtension on _i10.NavigationService {
  Future<dynamic> navigateToLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToShipmentsListView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.shipmentsListView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCreateShipmentView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.createShipmentView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToShipmentDetailView({
    _i8.Key? key,
    _i9.Shipment? shipment,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.shipmentDetailView,
        arguments: ShipmentDetailViewArguments(key: key, shipment: shipment),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToUsersView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.usersView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToTrackView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.trackView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithShipmentsListView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.shipmentsListView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCreateShipmentView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.createShipmentView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithShipmentDetailView({
    _i8.Key? key,
    _i9.Shipment? shipment,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.shipmentDetailView,
        arguments: ShipmentDetailViewArguments(key: key, shipment: shipment),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithUsersView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.usersView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithTrackView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.trackView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
