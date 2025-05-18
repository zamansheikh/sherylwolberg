import 'package:get/get.dart';
import 'package:workflowx/features/projects/controller/project_controller.dart';



class ProjectsBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut<ProjectController>(() => ProjectController());
  }
}
