
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workflowx/core/routes/app_pages.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/themes/theme_controller.dart';
import '../../../l10n/app_localizations.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.homeTitle),
        // backgroundColor: appColors.appBarBackgroundColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => Text(
                AppLocalizations.of(context)!.welcomeMessage,
                style: TextStyle(
                  fontSize: 20.sp,
                  color: appColors.primaryTextColor,
                ),
              ),
            ),
            Obx(
              () => Text(
                AppLocalizations.of(
                  context,
                )!.count(controller.count.value.toString()),
                style: TextStyle(
                  fontSize: 24.sp,
                  color: appColors.primaryTextColor,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Obx(
              () => ElevatedButton(
                onPressed: controller.increment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: appColors.buttonBackgroundColor,
                  foregroundColor: Colors.white,
                ),
                child: Text(AppLocalizations.of(context)!.increment),
              ),
            ),
            SizedBox(height: 20.h),
            Obx(
              () => ElevatedButton(
                onPressed: () {
                  if (Get.locale?.languageCode == 'es') {
                    Get.updateLocale(const Locale('en'));
                  } else {
                    Get.updateLocale(const Locale('es'));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: appColors.buttonBackgroundColor,
                  foregroundColor: Colors.white,
                ),
                child: Text(AppLocalizations.of(context)!.changeLanguage),
              ),
            ),
            SizedBox(height: 20.h),
            // Theme Toggle Dropdown
            Obx(
              () => DropdownButton<ThemeType>(
                value: themeController.currentTheme.value,
                items: [
                  DropdownMenuItem(
                    value: ThemeType.light,
                    child: Text(AppLocalizations.of(context)!.lightMode),
                  ),
                  DropdownMenuItem(
                    value: ThemeType.dark,
                    child: Text(AppLocalizations.of(context)!.darkMode),
                  ),
                  DropdownMenuItem(
                    value: ThemeType.eco,
                    child: Text(AppLocalizations.of(context)!.ecomode),
                  ),
                ],
                onChanged: (ThemeType? value) {
                  if (value != null) {
                    themeController.switchTheme(value);
                  }
                },
              ),
            ),
            SizedBox(height: 20.h),
            // Button
            Obx(
              () => ElevatedButton(
                onPressed: () {
                 Get.toNamed(Routes.projects);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: appColors.buttonBackgroundColor,
                  foregroundColor: Colors.white,
                ),
                child: Text(AppLocalizations.of(context)!.increment),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
