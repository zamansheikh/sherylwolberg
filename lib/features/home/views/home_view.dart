import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workflowx/features/home/views/home_screen.dart';
import 'package:workflowx/features/home/views/notification_screen.dart';
import 'package:workflowx/features/home/views/profile_screen.dart';
import 'package:workflowx/features/home/views/reports_screen.dart';
import 'package:workflowx/features/home/widget/custom_buttom_navbar.dart';

import '../../../core/themes/theme_controller.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        onPageChanged: (index) {
          controller.currentNavIndex = index;
        },
        children: [
          HomeScreen(),
          ReportsScreen(),
          NotificationScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: Obx(() {
        return CustomBottomNavBar(
          currentIndex: controller.currentNavIndex,
          onTap: controller.onNavItemTapped,
        );
      }),
      backgroundColor: Colors.white,
    );
  }
}
