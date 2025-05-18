// ------------------------------
// Home Screen Main Widget
// ------------------------------
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workflowx/core/constants/app_assets.dart';
import 'package:workflowx/core/routes/app_pages.dart';

import '../widget/custom_buttom_navbar.dart';
import '../widget/drone_card.dart';
import '../widget/report_ticket_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  void _onNavTap(int index) {
    setState(() {
      _currentNavIndex = index;
      // TODO: Navigate or change views accordingly
    });
  }

  void _onReportTicketPressed() {
    Get.toNamed(Routes.report);
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
              // Search Bar & filter icon
              Container(
                height: 44,
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.grey),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Search Drone',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // TODO: Implement filter
                      },
                      icon: const Icon(Icons.filter_list, color: Colors.grey),
                    ),
                  ],
                ),
              ),

              // Drone categories list (horizontal)
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: droneCategories.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 70,
                      margin: EdgeInsets.only(
                        right: index == droneCategories.length - 1 ? 0 : 16,
                      ),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundImage: NetworkImage(
                              droneCategoryImages[index],
                            ),
                            backgroundColor: Colors.transparent,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            droneCategories[index],
                            style: const TextStyle(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 8),

              // Drone cards horizontal scroll
              SizedBox(
                height: 280,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: droneCards.length,
                  itemBuilder: (context, index) {
                    final drone = droneCards[index];
                    return DroneCard(
                      imageUrl: drone['image']!,
                      title: drone['title']!,
                      description: drone['description']!,
                      onReport: () => _onReportPressed(drone['title']!),
                    );
                  },
                ),
              ),

              const SizedBox(height: 12),

              // Recent Report Ticket header
              const Text(
                'Recent Report Ticket',
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
                  return InkWell(
                    onTap: () {
                      Get.toNamed(Routes.ticketDetails, arguments: ticket);
                    },
                    child: ReportTicketCard(
                      ticketNo: ticket['ticketNo']!,
                      status: ticket['status']!,
                      title: ticket['title']!,
                      userName: ticket['userName']!,
                      code: ticket['code']!,
                      date: ticket['date']!,
                    ),
                  );
                },
              ),

              const SizedBox(height: 16),

              // Report Problem button
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _onReportTicketPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Report Problem',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
