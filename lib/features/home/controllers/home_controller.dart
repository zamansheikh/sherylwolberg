import 'package:get/get.dart';

import '../../../core/utils/loading_controller.dart';

class HomeController extends GetxController {
  final count = 0.obs;

  void increment() {
    LoadingController.to.showLoading();
    Future.delayed(const Duration(seconds: 2), () {
      count.value++;
      LoadingController.to.hideLoading();
    });
  }
}
