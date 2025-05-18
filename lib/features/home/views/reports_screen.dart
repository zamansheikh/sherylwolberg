// ------------------------------
// Home Screen Main Widget
// ------------------------------
import 'package:flutter/material.dart';
import 'package:workflowx/core/constants/app_assets.dart';

import '../widget/custom_buttom_navbar.dart';
import '../widget/drone_card.dart';
import '../widget/report_ticket_card.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  int _currentNavIndex = 0;

  final List<String> droneCategories = [
    'DJI Mini',
    'DJI Air 3',
    'Skydio',
    'DJI',
    'DJI Air',
  ];

  final List<String> droneCategoryImages = [
    'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=160&q=80', // dummy images
    'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=160&q=80', // dummy images
    'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=160&q=80', // dummy images
    'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=160&q=80', // dummy images
    'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=160&q=80', // dummy images
  ];

  final List<Map<String, String>> droneCards = [
    {
      'image':
          'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=160&q=80',
      'title': 'DJI Mini 2',
      'description': 'Compact, 4K drone with long-range stable flight.',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=160&q=80',
      'title': 'DJI Air 3',
      'description': 'Compact, 4K drone with long-range stable flight.',
    },
  ];

  final List<Map<String, String>> reportTickets = [
    {
      'ticketNo': 'Ticket No-07',
      'status': 'In progress',
      'title': 'Technical Issue Reporting',
      'userName': 'John Max',
      'code': '54654',
      'date': '10/5/2025',
    },
    {
      'ticketNo': 'Ticket No-07',
      'status': 'Solved',
      'title': 'Technical Issue Reporting',
      'userName': 'John Max',
      'code': '52656',
      'date': '10/5/2025',
    },
    {
      'ticketNo': 'Ticket No-07',
      'status': 'Solved',
      'title': 'Technical Issue Reporting',
      'userName': 'John Max',
      'code': '52656',
      'date': '10/5/2025',
    },
  ];

  void _onReportTicketPressed() {
    // TODO: Implement report ticket button pressed action
  }

  void _onReportPressed(String droneName) {
    // TODO: Implement individual drone report button action
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leadingWidth: 80,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Image.asset(AppAssets.logo, fit: BoxFit.contain, height: 36),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                'https://thispersondoesnotexist.com/',
              ),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: ListView(
            children: [
              // Recent Report Ticket header
              const Text(
                'Reports',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),

              const SizedBox(height: 12),

              // Report Ticket cards list vertical
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: reportTickets.length,
                itemBuilder: (context, index) {
                  final ticket = reportTickets[index];
                  return ReportTicketCard(
                    ticketNo: ticket['ticketNo']!,
                    status: ticket['status']!,
                    title: ticket['title']!,
                    userName: ticket['userName']!,
                    code: ticket['code']!,
                    date: ticket['date']!,
                  );
                },
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),            

      backgroundColor: Colors.white,
    );
  }
}
