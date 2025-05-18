import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';

import 'core/config/app_constants.dart';
import 'core/error/error_screen.dart';
import 'core/routes/app_pages.dart';
import 'core/themes/app_theme.dart';
import 'core/themes/theme_controller.dart';
import 'core/utils/loading_controller.dart';
import 'l10n/app_localizations.dart'; // Correct import\

//Error Handling state
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  FlutterError.onError = (FlutterErrorDetails details) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (navigatorKey.currentState?.overlay?.context.widget is! ErrorScreen) {
        navigatorKey.currentState?.push(
          MaterialPageRoute(
            builder:
                (context) => ErrorScreen(error: details.exceptionAsString()),
          ),
        );
      }
    });
  };

  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the ThemeController
    Get.put(ThemeController());
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: AppConstants.appName,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.light,
          initialRoute: AppPages.initial,
          // navigatorKey: navigatorKey,
          getPages: AppPages.routes,
          locale: Get.deviceLocale,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          debugShowCheckedModeBanner: false,
          builder: (context, widget) {
            return Stack(
              children: [
                widget!,
                GetX<LoadingController>(
                  init: LoadingController(),
                  builder:
                      (controller) =>
                          controller.isLoading.value
                              ? Container(
                                color: Colors.black.withValues(alpha: 0.5),
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                              : const SizedBox.shrink(),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
