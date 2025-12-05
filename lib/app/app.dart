import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import 'router.dart';

@StackedApp(
  routes: [],
  dependencies: [
    // Router
    LazySingleton(classType: AppRouter),

    // Navigation Services
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: SnackbarService),
  ],
  logger: StackedLogger(),
)
class App {}
