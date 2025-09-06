import 'package:flutter/material.dart';
import 'package:gazflow/features/store_manager_dashboard/widgets/recent_activities.dart';
import '../store_manager_dashboard/widgets/store_manager_header.dart';
import '../store_manager_dashboard/widgets/store_stats_section.dart';
import '../store_manager_dashboard/widgets/quick_action_grid.dart';
import '../store_manager_dashboard/widgets/navigation_bar.dart';
import '../store_manager_dashboard/models/storage_location.dart';
import '../store_manager_dashboard/models/gas_bottle.dart';

class StoreManagerDashboardScreen extends StatefulWidget {
  const StoreManagerDashboardScreen({super.key});

  @override
  State<StoreManagerDashboardScreen> createState() => _StoreManagerDashboardScreenState();
}

class _StoreManagerDashboardScreenState extends State<StoreManagerDashboardScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  // Manager data
  String managerName = "Sarah Nguema";
  String storeName = "GazFlow Central Yaoundé";
  
  // Stats data
  int totalLocations = 5;
  int totalBottles = 847;
  double dailySales = 125000; // CFA
  int activeDrivers = 12;
  int lowStockLocations = 2;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeIn));
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Store Manager Header
            SliverToBoxAdapter(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: StoreManagerHeader(
                  managerName: managerName,
                  storeName: storeName,
                  onNotificationsPressed: () {
                    Navigator.pushNamed(context, '/manager-notifications');
                  },
                  onProfilePressed: () {
                    Navigator.pushNamed(context, '/manager-profile');
                  },
                ),
              ),
            ),

            // Stats Section
            SliverToBoxAdapter(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: StoreStatsSection(
                  totalLocations: totalLocations,
                  totalBottles: totalBottles,
                  dailySales: dailySales,
                  activeDrivers: activeDrivers,
                  lowStockLocations: lowStockLocations,
                ),
              ),
            ),

            // Quick Actions Grid
            SliverToBoxAdapter(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: QuickActionsGrid(
                  onManageLocationsPressed: () {
                    Navigator.pushNamed(context, '/manage-locations');
                  },
                  onManageBottlesPressed: () {
                    Navigator.pushNamed(context, '/manage-bottles');
                  },
                  onSendNotificationPressed: () {
                    _showSendNotificationDialog();
                  },
                  onGenerateReportPressed: () {
                    Navigator.pushNamed(context, '/analytics-reports');
                  },
                  onInventoryPressed: () {
                    Navigator.pushNamed(context, '/inventory-overview');
                  },
                  onDriverManagementPressed: () {
                    Navigator.pushNamed(context, '/driver-management');
                  },
                ),
              ),
            ),

            // Recent Activities
            SliverToBoxAdapter(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: RecentActivities(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: StoreManagerNavBar(currentIndex: 0),
    );
  }

  void _showSendNotificationDialog() {
    showDialog(
      context: context,
      builder: (context) => SendNotificationDialog(),
    );
  }
}

// Send Notification Dialog
class SendNotificationDialog extends StatefulWidget {
  @override
  State<SendNotificationDialog> createState() => _SendNotificationDialogState();
}

class _SendNotificationDialogState extends State<SendNotificationDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  String selectedAudience = 'all'; // all, specific, online_only

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Row(
        children: [
          Icon(Icons.notifications_active, color: Colors.blue[600]),
          const SizedBox(width: 8),
          const Text('Send Notification'),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Audience Selection
            const Text(
              'Send to:',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedAudience,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              items: const [
                DropdownMenuItem(value: 'all', child: Text('All Drivers')),
                DropdownMenuItem(value: 'online_only', child: Text('Online Drivers Only')),
                DropdownMenuItem(value: 'specific', child: Text('Specific Drivers')),
              ],
              onChanged: (value) {
                setState(() {
                  selectedAudience = value!;
                });
              },
            ),
            const SizedBox(height: 16),
            
            // Title Field
            const Text(
              'Title:',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'Notification title...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ),
            const SizedBox(height: 16),
            
            // Message Field
            const Text(
              'Message:',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _messageController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Type your message here...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.all(12),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[600],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {
            // Send notification logic here
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Notification sent successfully!'),
                backgroundColor: Colors.green,
              ),
            );
          },
          child: const Text('Send', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _messageController.dispose();
    super.dispose();
  }
}