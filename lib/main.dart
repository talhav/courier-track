import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app/app.locator.dart';
import 'app/router.dart';
import 'core/constants/app_colors.dart';
import 'core/services/auth_service.dart';
import 'core/services/api_service.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();

  // Setup SnackbarService UI
  setupSnackbarUi();

  // Initialize and register SharedPreferences
  final prefs = await SharedPreferences.getInstance();

  // Create Dio instance
  final dio = Dio(BaseOptions(
    baseUrl: 'http://localhost:3000/api',
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ));

  // Add auth interceptor
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        // Add token to all requests except login
        final token = prefs.getString('auth_token');
        if (token != null && !options.path.contains('/login')) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (DioException error, handler) {
        // Handle 401 Unauthorized - token expired
        if (error.response?.statusCode == 401) {
          // Clear token on 401
          prefs.remove('auth_token');
        }
        return handler.next(error);
      },
    ),
  );

  // Add logging interceptor
  dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

  // Register services manually
  locator.registerLazySingleton(() => prefs);
  locator.registerLazySingleton(() => dio);
  locator.registerLazySingleton(() => ApiService(dio));
  locator.registerLazySingleton(() => AuthService(prefs, locator<ApiService>()));

  runApp(const MyApp());
}

void setupSnackbarUi() {
  final service = locator<SnackbarService>();

  // Configure the service to use our global key
  service.registerSnackbarConfig(
    SnackbarConfig(
      backgroundColor: Colors.grey[800]!,
      textColor: Colors.white,
      borderRadius: 8,
      dismissDirection: DismissDirection.horizontal,
      margin: const EdgeInsets.all(16),
    ),
  );

  // Register custom snackbar configuration
  service.registerCustomSnackbarConfig(
    variant: 'error',
    config: SnackbarConfig(
      backgroundColor: Colors.red,
      textColor: Colors.white,
      borderRadius: 8,
      dismissDirection: DismissDirection.horizontal,
      margin: const EdgeInsets.all(16),
    ),
  );

  service.registerCustomSnackbarConfig(
    variant: 'success',
    config: SnackbarConfig(
      backgroundColor: Colors.green,
      textColor: Colors.white,
      borderRadius: 8,
      dismissDirection: DismissDirection.horizontal,
      margin: const EdgeInsets.all(16),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = locator<AppRouter>();
    final routerDelegate = appRouter.delegate();
    final routeInformationParser = appRouter.defaultRouteParser();
    final routeInformationProvider = appRouter.routeInfoProvider();

    return GetMaterialApp.router(
      scaffoldMessengerKey: scaffoldMessengerKey,
      title: 'Courier Track',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          secondary: AppColors.accent,
        ),
        scaffoldBackgroundColor: AppColors.background,
        textTheme: GoogleFonts.robotoTextTheme(),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textWhite,
          elevation: 2,
          centerTitle: false,
          titleTextStyle: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.textWhite,
          ),
        ),
        cardTheme: const CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.textWhite,
            elevation: 2,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: AppColors.surface,
        ),
      ),
      routerDelegate: routerDelegate,
      routeInformationParser: routeInformationParser,
      routeInformationProvider: routeInformationProvider,
    );
  }
}
