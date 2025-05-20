import 'package:flutter/material.dart';
import 'package:workflowx/core/constants/app_assets.dart';
import 'package:workflowx/core/routes/app_pages.dart';
import 'package:workflowx/features/home/widget/notification_card.dart';

// Main Notification Screen widget
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int _currentIndex = 2; // Notification tab selected

  final List<Map<String, String>> notifications = List.generate(
    6,
    (index) => {
      'title': 'Waiting for Review',
      'message':
          'Your ticket is under review. We’ll update you as soon as there’s progress.',
      'time': '12:00 am',
      'logo': AppAssets.logo,
    },
  );

  void _onNavTap(int index) {
    setState(() {
      _currentIndex = index;
      // TODO: Handle navigation to other pages
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black87,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            //If stack is not empty, pop the current screen
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              // If stack is empty, navigate to the home screen
              Navigator.pushNamed(context, Routes.home);
            }
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notif = notifications[index];
              return NotificationCard(
                title: notif['title']!,
                message: notif['message']!,
                time: notif['time']!,
                logoUrl: notif['logo']!,
              );
            },
          ),
        ),
      ),

      backgroundColor: Colors.white,
    );
  }
}
