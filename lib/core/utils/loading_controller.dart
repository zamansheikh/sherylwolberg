import 'package:get/get.dart';

class LoadingController extends GetxController {
  static LoadingController get to => Get.find();
  RxBool isLoading = false.obs;

  void showLoading() => isLoading.value = true;
  void hideLoading() => isLoading.value = false;
}
