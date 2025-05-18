import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:percent_indicator/percent_indicator.dart'; // For progress
import 'package:workflowx/core/themes/app_text_theme.dart';
import 'package:workflowx/core/utils/helpers/helpers.dart'; // Assuming this has formatCurrency
import 'package:workflowx/core/utils/utils.dart';
import 'package:workflowx/features/projects/project_model.dart';

import '../../../core/themes/app_colors.dart'; // Adjust import path


class ProjectCard extends StatelessWidget {
  final Project project;

  const ProjectCard({required this.project, super.key});

  // --- Helper to build Tags ---
  Widget _buildTag(BuildContext context, String text, Color bgColor, Color textColor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: 11.sp, fontWeight: FontWeight.w500),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  // --- Helper for Phase Timeline Item ---
  Widget _buildPhaseTimelineItem(BuildContext context, Phase phase, bool isLast) {
     // Determine color based on status (example logic)
    Color circleColor = appColors.grey; // Default
    bool isActive = phase.status.toUpperCase() == 'ACTIVE';
    bool isCompleted = phase.status.toUpperCase() == 'COMPLETED'; // Assuming you might have 'COMPLETED'
    bool isInactive = phase.status.toUpperCase() == 'INACTIVE';

    if (isActive) {
      circleColor = Colors.blue; // Active phase color
    } else if (isCompleted) {
        circleColor = Colors.green; // Completed phase color
    } else if (isInactive && project.phases.any((p) => p.status.toUpperCase() == 'ACTIVE' || p.status.toUpperCase() == 'COMPLETED')){
       // If inactive but some other phase is active/completed, show as grey/passed
       circleColor = appColors.grey.withOpacity(0.6);
    } else {
        // Default inactive/future state
         circleColor = appColors.grey.withOpacity(0.6);
    }


    // Simple name mapping if needed
    String displayName = StringExtension(phase.name.replaceAll('_', ' ')).capitalizeFirst ?? phase.name;


    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 20.w,
              height: 20.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: circleColor,
                 border: Border.all(color: Colors.white, width: 1.5) // Optional border
              ),
            ),
            SizedBox(height: 4.h),
            SizedBox(
              width: 50.w, // Constrain width for text wrapping
              child: Text(
                displayName,
                textAlign: TextAlign.center,
                style: AppTextTheme.instance.bodySmall?.copyWith(fontSize: 9.sp, color: appColors.secondaryTextColor),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        // Connecting Line (don't draw after the last item)
        if (!isLast)
          Padding(
            padding: EdgeInsets.only(top: 9.h), // Align with center of circle
            child: Container(
              width: 30.w, // Adjust width between circles
              height: 2.h,
              color: appColors.grey.withOpacity(0.5), // Line color
            ),
          ),
      ],
    );
  }


  // --- Helper for Member Avatars ---
  Widget _buildMemberAvatars(BuildContext context) {
    const double avatarRadius = 16.0;
    const double overlap = 10.0; // Amount of overlap
    int maxAvatars = 4; // Max avatars to show before "+N"

    List<Widget> avatarWidgets = [];
    int membersToShow = project.assignedMembers.length > maxAvatars
        ? maxAvatars
        : project.assignedMembers.length;

    for (int i = 0; i < membersToShow; i++) {
      final member = project.assignedMembers[i];
      // Basic placeholder logic - replace with better default image if needed
      Widget avatarContent = member.image != null && member.image!.isNotEmpty
          ? CircleAvatar(
               radius: avatarRadius.r,
               backgroundColor: appColors.grey.withOpacity(0.3), // Background for failed load
               backgroundImage: NetworkImage(
                 
                Utils.imageUrl(""), // Use your image URL function
               ),
            )
          : CircleAvatar( // Placeholder if no image
              radius: avatarRadius.r,
              backgroundColor: appColors.primaryColor.withOpacity(0.6),
              child: Text(
                member.fullName.isNotEmpty ? member.fullName[0].toUpperCase() : '?',
                style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.bold),
              ),
            );


      avatarWidgets.add(
        Positioned(
          left: i * (avatarRadius * 2 - overlap).w,
          child: CircleAvatar(
            radius: (avatarRadius + 2).r, // Add border space
            backgroundColor: Theme.of(context).cardColor, // Match card background for border
            child: avatarContent,
          ),
        ),
      );
    }

     // Add "+N" indicator if there are more members
    if (project.assignedMembers.length > maxAvatars) {
      avatarWidgets.add(
        Positioned(
          left: maxAvatars * (avatarRadius * 2 - overlap).w,
          child: CircleAvatar(
            radius: (avatarRadius + 2).r, // Match border size
            backgroundColor: Theme.of(context).cardColor,
            child: CircleAvatar(
               radius: avatarRadius.r,
               backgroundColor: appColors.secondaryTextColor.withOpacity(0.7),
              child: Text(
                '+${project.assignedMembers.length - maxAvatars}',
                style: TextStyle(color: Colors.white, fontSize: 11.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      );
    }

    // Calculate the required width for the Stack
    double stackWidth = (project.assignedMembers.length <= maxAvatars
                          ? project.assignedMembers.length
                          : maxAvatars + 1) * (avatarRadius * 2 - overlap).w + overlap.w;
    if (project.assignedMembers.isEmpty) stackWidth = 0;
    if (project.assignedMembers.length == 1) stackWidth = (avatarRadius * 2 + 4).w; // Adjust for single avatar


    return SizedBox(
        width: stackWidth,
        height: (avatarRadius * 2 + 4).h, // Height accounts for border
        child: Stack(children: avatarWidgets)
    );
  }


  @override
  Widget build(BuildContext context) {
    // Date Formatting
    final DateFormat dateFormat = DateFormat('MMM dd, yyyy');
    final String formattedDate = project.createdAt != null
        ? dateFormat.format(project.createdAt)
        : 'N/A'; // Or use updatedAt

    final String formattedLastUpdate = project.updatedAt != null
        ? DateFormat('hh:mma, dd-MM-yyyy').format(project.updatedAt.toLocal()) // Ensure local time
        : 'N/A';

    // Progress Calculation (Example: based on completed phases)
    int completedPhases = project.phases
        .where((p) => p.status.toUpperCase() == 'COMPLETED') // Assuming 'COMPLETED' status exists
        .length;
    double overallProgress = project.phases.isNotEmpty
        ? completedPhases / project.phases.length
        : 0.0;

    return Container(
      width: 320.w, // Fixed width for horizontal list items
      margin: EdgeInsets.only(right: 16.w, top: 8.h, bottom: 12.h), // Margin between cards
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor, // Use theme card color
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
         border: Border.all(color: appColors.borderColor.withOpacity(0.5), width: 0.5)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // Important for Column in horizontal list
        children: [
          // --- Top Row: Title & Button ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  project.name,
                  style: AppTextTheme.instance.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 10.w),
              ElevatedButton(
                onPressed: () {
                  // TODO: Implement Visit Group Action
                  print('Visit Group for ${project.name}');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: appColors.primaryColor.withOpacity(0.15),
                  foregroundColor: appColors.primaryColor,
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                  elevation: 0,
                  textStyle: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w500)
                ),
                child: Text('Visit Group'), // TODO: Localize
              ),
            ],
          ),
          SizedBox(height: 4.h),

          // --- Duration & Date ---
          Text(
            "${project.duration ?? 'N/A'} days   •   $formattedDate", // TODO: Localize 'days'
            style: AppTextTheme.instance.bodySmall?.copyWith(color: appColors.secondaryTextColor, fontSize: 11.sp),
          ),
          SizedBox(height: 12.h),

          // --- Tags ---
          Wrap(
            spacing: 8.w,
            runSpacing: 6.h,
            children: [
              if (project.salesName != null && project.salesName!.isNotEmpty)
                _buildTag(context, project.salesName!, Colors.teal.shade100, Colors.teal.shade800),
              if (project.totalBudget != null)
                // _buildTag(context, '\$${project.totalBudget}', Colors.pink.shade100, Colors.pink.shade800),
                 _buildTag(context, Helpers.formatCurrency(project.totalBudget!.toDouble(), context), Colors.pink.shade100, Colors.pink.shade800), // Use helper
              if (project.clientName != null && project.clientName!.isNotEmpty)
                _buildTag(context, project.clientName!, Colors.amber.shade100, Colors.amber.shade800),
               // Add more tags if needed based on other data
            ],
          ),
          SizedBox(height: 16.h),

          // --- Phase Timeline ---
           if (project.phases.isNotEmpty)
              SingleChildScrollView( // Allow scrolling if phases exceed width
                 scrollDirection: Axis.horizontal,
                 child: Row(
                    children: List.generate(project.phases.length, (index) {
                      return _buildPhaseTimelineItem(context, project.phases[index], index == project.phases.length - 1);
                    }),
                 ),
              ),
          SizedBox(height: 16.h),


          // --- Phase Progress (Simplified: Just lists active/ongoing phases) ---
          Text(
            'Phase Progress', // TODO: Localize
             style: AppTextTheme.instance.labelLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 6.h),
          // Example: Show only active phases, or first few
          ...project.phases
              .where((p) => p.status.toUpperCase() == 'ACTIVE' || p.status.toUpperCase() == 'INACTIVE') // Example filter
              .take(2) // Limit to 2 for this example
              .map((phase) => Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                          GetStringUtils(phase.name.replaceAll('_', ' ')).capitalizeFirst ?? phase.name,
                           style: AppTextTheme.instance.bodyMedium?.copyWith(fontSize: 12.sp),
                           overflow: TextOverflow.ellipsis,
                          )
                      ),
                    SizedBox(width: 10.w),
                    Expanded(
                      flex: 2,
                      child: LinearProgressIndicator(
                        value: phase.status.toUpperCase() == 'ACTIVE' ? 0.5 : 0.0, // Placeholder progress
                        backgroundColor: appColors.grey.withOpacity(0.3),
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                        minHeight: 6.h,
                        borderRadius: BorderRadius.circular(3.r),
                      ),
                    ),
                  ],
                ),
              ))
              .toList(),
           if (project.phases.where((p) => p.status.toUpperCase() == 'ACTIVE' || p.status.toUpperCase() == 'INACTIVE').isEmpty)
              Text("No active phases", style: AppTextTheme.instance.bodySmall?.copyWith(color: appColors.secondaryTextColor)), // TODO: Localize


          SizedBox(height: 16.h),

          // --- Assigned Members & Progress ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Assigned Members', // TODO: Localize
                     style: AppTextTheme.instance.labelLarge?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 8.h),
                  if(project.assignedMembers.isNotEmpty)
                    _buildMemberAvatars(context)
                  else
                     Text("No members assigned", style: AppTextTheme.instance.bodySmall?.copyWith(color: appColors.secondaryTextColor)), // TODO: Localize
                ],
              ),
              // Spacer(),
              Column(
                  mainAxisSize: MainAxisSize.min,
                   children: [
                      Text(
                          'Progress', // TODO: Localize
                          style: AppTextTheme.instance.bodySmall?.copyWith(color: appColors.secondaryTextColor, fontSize: 11.sp),
                      ),
                      SizedBox(height: 4.h),
                      CircularPercentIndicator(
                        radius: 28.r,
                        lineWidth: 6.0.w,
                        percent: overallProgress,
                        center: Text(
                          "${(overallProgress * 100).toStringAsFixed(0)}%",
                          style: AppTextTheme.instance.labelLarge?.copyWith(fontWeight: FontWeight.w600, color: appColors.primaryColor),
                        ),
                        progressColor: appColors.primaryColor,
                        backgroundColor: appColors.primaryColor.withOpacity(0.2),
                        circularStrokeCap: CircularStrokeCap.round,
                      ),
                   ]
              )

            ],
          ),
          SizedBox(height: 16.h),

          // --- Latest Update ---
          Flexible(
            child: Text(
              "Latest Update: ${project.description ?? 'No description available.'}", // TODO: Localize
              style: AppTextTheme.instance.bodySmall?.copyWith(fontSize: 11.sp, color: appColors.secondaryTextColor),
              maxLines: 2, // Limit lines
              overflow: TextOverflow.ellipsis, // Add ellipsis if overflow
            ),
          ),
          SizedBox(height: 4.h),
           Text(
            formattedLastUpdate,
            style: AppTextTheme.instance.bodySmall?.copyWith(fontSize: 10.sp, color: appColors.grey),
          ),
        ],
      ),
    );
  }
}

// Helper extension for capitalizeFirst (if not already available)
extension StringExtension on String {
  String? get capitalizeFirst {
    if (isEmpty) {
      return this;
    }
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}