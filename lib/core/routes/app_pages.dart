import 'package:get/get.dart';
import 'package:workflowx/features/projects/bindings/project_binding.dart';
import 'package:workflowx/features/projects/views/project_view.dart';

import '../../features/home/bindings/home_binding.dart';
import '../../features/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  static const initial = Routes.home;

  static final routes = [
    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
     GetPage(
      name: Routes.projects,
      page: () => const ProjectsView(),
      binding: ProjectsBinding(),
    ),
  ];
}
