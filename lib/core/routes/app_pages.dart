import 'package:get/get.dart';
import 'package:workflowx/features/auth/view/create_new_password_screen.dart';
import 'package:workflowx/features/auth/view/forget_password_verify_screen.dart';
import 'package:workflowx/features/auth/view/sign_in_now_screen.dart';
import 'package:workflowx/features/auth/view/sign_in_screen.dart';
import 'package:workflowx/features/auth/view/sign_up_now_screen.dart';
import 'package:workflowx/features/auth/view/forget_password_screen.dart';
import 'package:workflowx/features/home/views/file_report_screen.dart';
import 'package:workflowx/features/home/views/privacy_policy_screen.dart';
import 'package:workflowx/features/home/views/profile_details_screen.dart';
import 'package:workflowx/features/home/views/report_preview_reply_screen.dart';
import 'package:workflowx/features/home/views/report_preview_screen.dart';

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
    GetPage(name: Routes.signUpNow, page: () => const SignUpNowScreen()),
    GetPage(
      name: Routes.forgotPassword,
      page: () => const ForgetPasswordScreen(),
    ),
    GetPage(
      name: Routes.forgotPasswordVerify,
      page: () => const ForgetPasswordVerifyScreen(),
    ),
    GetPage(
      name: Routes.createNewPassword,
      page: () => const CreateNewPasswordScreen(),
    ),
    GetPage(name: Routes.profile, page: () => const ProfileDetailsScreen()),
    GetPage(name: Routes.privacyPolicy, page: () => const PrivacyPolicyScreen()),
    GetPage(name: Routes.report, page: () => const FileReportScreen()),
    GetPage(name: Routes.ticketDetails, page: () =>  ReportPreviewScreen()),
    GetPage(name: Routes.reportReply, page: () =>  ReportDetailsWithMessagesScreen()),
  ];
}
