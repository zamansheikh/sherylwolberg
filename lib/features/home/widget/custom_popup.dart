import 'package:flutter/material.dart';
import 'package:workflowx/core/constants/app_assets.dart';
import 'package:workflowx/core/utils/svg_icon.dart';

class CustomPopUp extends StatelessWidget {
  const CustomPopUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgIcon(assetName: AppAssets.iconTick),

            // Blue circle with white check icon
            const SizedBox(height: 30),

            // Success message text
            const Text(
              'TICKET CREATED SUCCESSFULLY',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.blue),
            ),
            const SizedBox(height: 10),
            const Text(
              'Your support ticket has been successfully submitted.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.blue),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
