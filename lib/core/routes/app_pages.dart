import 'package:get/get.dart';
import 'package:workflowx/features/auth/view/sign_in_now_screen.dart';
import 'package:workflowx/features/auth/view/sign_in_screen.dart';

import '../../features/home/bindings/home_binding.dart';
import '../../features/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  static const initial = Routes.signIn;

  static final routes = [
    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(name: Routes.signIn, page: () => const SignInScreen()),
    GetPage(name: Routes.signInNow, page: () => const SignInNowScreen()),
  ];
}
