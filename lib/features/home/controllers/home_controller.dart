import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/loading_controller.dart';

class HomeController extends GetxController {
  final count = 0.obs;
  final RxInt _currentNavIndex = 0.obs;
  int get currentNavIndex => _currentNavIndex.value;

  set currentNavIndex(int index) {
    _currentNavIndex.value = index;
  }

  void onNavItemTapped(int index) {
    currentNavIndex = index;
    pageController.jumpToPage(index);
  }

  //Page Controller
  final PageController pageController = PageController(initialPage: 0);
  void onPageChanged(int index) {
    currentNavIndex = index;
    pageController.jumpToPage(index);
  }

  void increment() {
    LoadingController.to.showLoading();
    Future.delayed(const Duration(seconds: 2), () {
      count.value++;
      LoadingController.to.hideLoading();
    });
  }
}
