import 'package:flutter/material.dart';
import 'package:workflowx/core/constants/app_assets.dart';
import 'package:workflowx/core/utils/svg_icon.dart';

// ------------------------------
// Reusable Bottom Navigation Bar
// ------------------------------
class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      items: [
        BottomNavigationBarItem(
          icon: SvgIcon(
            assetName: AppAssets.iconHome,
            color: currentIndex == 0 ? Colors.blue : Colors.black54,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: SvgIcon(
            assetName: AppAssets.iconReport,
            color: currentIndex == 1 ? Colors.blue : Colors.black54,
          ),
          label: 'Report',
        ),
        BottomNavigationBarItem(
          icon: SvgIcon(
            assetName: AppAssets.iconNotification,
            color: currentIndex == 2 ? Colors.blue : Colors.black54,
          ),
          label: 'Notification',
        ),
        BottomNavigationBarItem(
          icon: SvgIcon(
            assetName: AppAssets.iconUser,
            color: currentIndex == 3 ? Colors.blue : Colors.black54,
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}
