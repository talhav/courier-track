import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../ui/views/login/login_view.dart';
import '../ui/views/users/users_view.dart';
import '../ui/views/shipments/list/shipments_list_view.dart';
import '../ui/views/shipments/create/create_shipment_view.dart';
import '../ui/views/shipments/detail/shipment_detail_view.dart';
import '../ui/views/track/track_view.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: LoginView, initial: true),
    MaterialRoute(page: ShipmentsListView),
    MaterialRoute(page: CreateShipmentView),
    MaterialRoute(page: ShipmentDetailView),
    MaterialRoute(page: UsersView),
    MaterialRoute(page: TrackView),
  ],
  dependencies: [
    // Navigation Services
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: SnackbarService),
  ],
  logger: StackedLogger(),
)
class App {}
