import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workflowx/features/projects/controller/project_controller.dart';
import 'package:workflowx/features/projects/views/project_card.dart';

import '../../../core/themes/app_colors.dart'; // Adjust import path
import '../../../l10n/app_localizations.dart'; // Adjust import path

class ProjectsView extends GetView<ProjectController> {
  const ProjectsView({super.key});

  @override
  Widget build(BuildContext context) {
    // ThemeController themeController = Get.find<ThemeController>(); // Keep if needed elsewhere

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.projects),
        actions: [
           // Optional: Add refresh button directly if needed
           IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: controller.refreshProjects,
              tooltip: AppLocalizations.of(context)!.refresh // Add tooltip
           ),
        ],
      ),
      body: Obx(() { // Use Obx to react to changes in controller's state


        // --- Error State ---
        if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, color: Colors.red, size: 50.sp),
                  SizedBox(height: 10.h),
                  Text(
                    controller.errorMessage.value,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16.sp, color: Colors.red),
                  ),
                  SizedBox(height: 20.h),
                  ElevatedButton(
                    onPressed: controller.refreshProjects,
                    child: Text(AppLocalizations.of(context)!.retry),
                  )
                ],
              ),
            ),
          );
        }

        // --- Empty State ---
        if (controller.projectList.isEmpty) {
          return Center(
            child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                    Icon(Icons.folder_off_outlined, size: 60.sp, color: appColors.secondaryTextColor),
                    SizedBox(height: 10.h),
                    Text(
                      AppLocalizations.of(context)!.noProjectsFound,
                       style: TextStyle(fontSize: 16.sp, color: appColors.secondaryTextColor),
                    ),
                     SizedBox(height: 20.h),
                     ElevatedButton.icon(
                       icon: const Icon(Icons.refresh),
                       label: Text(AppLocalizations.of(context)!.refresh),
                       onPressed: controller.refreshProjects,
                     )
                 ],
            )

          );
        }

        // --- Success State: Display Horizontal List ---
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Text(
                // Example Section Title
                AppLocalizations.of(context)!.onGoinProjects, // Add this to your localizations
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            // Container to constrain the height of the horizontal list
            Container(
              height: 400.h, // Adjust height as needed for your ProjectCard content
              padding: EdgeInsets.only(left: 16.w), // Start padding for the first card
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.projectList.length,
                itemBuilder: (context, index) {
                  final project = controller.projectList[index];
                  // Return the custom card widget
                  return ProjectCard(project: project);
                },
              ),
            ),
            // --- Add more sections/widgets below if needed ---
             SizedBox(height: 20.h),
             Padding(
               padding: EdgeInsets.symmetric(horizontal: 16.w),
               child: Text(
                 AppLocalizations.of(context)!.allProjects, 
                 style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
               ),
             ),
             // TODO: Add another list (e.g., vertical) or other content here
             Expanded(child: Center(child: Text("Other content area..."))),
          ],
        );
      }),
    );
  }
}