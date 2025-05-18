import 'package:get/get.dart';

import '../../../core/themes/theme_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ThemeController>(() => ThemeController());
  }
}
