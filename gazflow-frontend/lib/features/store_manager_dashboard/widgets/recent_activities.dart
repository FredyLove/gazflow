import 'package:flutter/material.dart';

enum ActivityType {
  stockUpdate,
  newOrder,
  driverAssigned,
  locationAdded,
  bottleAdded,
  lowStockAlert,
  deliveryCompleted,
  notificationSent,
  reportGenerated,
}

class ActivityItem {
  final String id;
  final ActivityType type;
  final String title;
  final String description;
  final DateTime timestamp;
  final String? userId;
  final String? userName;
  final Map<String, dynamic>? metadata;

  ActivityItem({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.timestamp,
    this.userId,
    this.userName,
    this.metadata,
  });
}

class RecentActivities extends StatefulWidget {
  const RecentActivities({super.key});

  @override
  State<RecentActivities> createState() => _RecentActivitiesState();
}

class _RecentActivitiesState extends State<RecentActivities> {
  // Sample recent activities data
  final List<ActivityItem> activities = [
    ActivityItem(
      id: "ACT001",
      type: ActivityType.newOrder,
      title: "New Order Received",
      description: "Order #GF001245 from Marie Talla - 2x 12.5kg Gas",
      timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
      userName: "System",
    ),
    ActivityItem(
      id: "ACT002",
      type: ActivityType.driverAssigned,
      title: "Driver Assigned",
      description: "Pierre Mbeng assigned to Order #GF001245",
      timestamp: DateTime.now().subtract(const Duration(minutes: 25)),
      userName: "Sarah Nguema",
    ),
    ActivityItem(
      id: "ACT003",
      type: ActivityType.stockUpdate,
      title: "Stock Updated",
      description: "Warehouse A stock increased by 50 units (12.5kg)",
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      userName: "Joseph Owona",
    ),
    ActivityItem(
      id: "ACT004",
      type: ActivityType.lowStockAlert,
      title: "Low Stock Alert",
      description: "Warehouse B has only 25 units remaining",
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      userName: "System",
    ),
    ActivityItem(
      id: "ACT005",
      type: ActivityType.deliveryCompleted,
      title: "Delivery Completed",
      description: "Order #GF001240 delivered successfully by Marie Talla",
      timestamp: DateTime.now().subtract(const Duration(hours: 3)),
      userName: "System",
    ),
    ActivityItem(
      id: "ACT006",
      type: ActivityType.notificationSent,
      title: "Notification Sent",
      description: "Sent notification to 12 online drivers about new batch arrival",
      timestamp: DateTime.now().subtract(const Duration(hours: 4)),
      userName: "Sarah Nguema",
    ),
    ActivityItem(
      id: "ACT007",
      type: ActivityType.locationAdded,
      title: "New Storage Location",
      description: "Added 'Emergency Storage E' with 100 unit capacity",
      timestamp: DateTime.now().subtract(const Duration(hours: 6)),
      userName: "Sarah Nguema",
    ),
    ActivityItem(
      id: "ACT008",
      type: ActivityType.reportGenerated,
      title: "Report Generated",
      description: "Weekly sales report generated for management review",
      timestamp: DateTime.now().subtract(const Duration(hours: 8)),
      userName: "System",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Recent Activities",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/activity-log');
                },
                child: const Text("View All"),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                // Show only the first 5 activities
                ...activities.take(5).map((activity) => _buildActivityItem(activity)),
                
                // Show more button if there are more activities
                if (activities.length > 5)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    child: Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/activity-log');
                        },
                        child: Text(
                          "View ${activities.length - 5} more activities",
                          style: TextStyle(
                            color: Colors.purple[700],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(ActivityItem activity) {
    final isLast = activities.take(5).last == activity && activities.length <= 5;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: isLast ? null : Border(
          bottom: BorderSide(color: Colors.grey[100]!, width: 1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Activity Icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _getActivityColor(activity.type).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              _getActivityIcon(activity.type),
              color: _getActivityColor(activity.type),
              size: 20,
            ),
          ),
          
          const SizedBox(width: 12),
          
          // Activity Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        activity.title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Text(
                      _formatTimestamp(activity.timestamp),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  activity.description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                    height: 1.3,
                  ),
                ),
                if (activity.userName != null && activity.userName != 'System')
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: 12,
                          color: Colors.grey[500],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "by ${activity.userName}",
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[500],
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getActivityColor(ActivityType type) {
    switch (type) {
      case ActivityType.stockUpdate:
        return Colors.blue;
      case ActivityType.newOrder:
        return Colors.green;
      case ActivityType.driverAssigned:
        return Colors.purple;
      case ActivityType.locationAdded:
        return Colors.teal;
      case ActivityType.bottleAdded:
        return Colors.indigo;
      case ActivityType.lowStockAlert:
        return Colors.orange;
      case ActivityType.deliveryCompleted:
        return Colors.green[600]!;
      case ActivityType.notificationSent:
        return Colors.cyan;
      case ActivityType.reportGenerated:
        return Colors.brown;
    }
  }

  IconData _getActivityIcon(ActivityType type) {
    switch (type) {
      case ActivityType.stockUpdate:
        return Icons.inventory_2;
      case ActivityType.newOrder:
        return Icons.shopping_cart;
      case ActivityType.driverAssigned:
        return Icons.local_shipping;
      case ActivityType.locationAdded:
        return Icons.add_location;
      case ActivityType.bottleAdded:
        return Icons.propane_tank;
      case ActivityType.lowStockAlert:
        return Icons.warning;
      case ActivityType.deliveryCompleted:
        return Icons.check_circle;
      case ActivityType.notificationSent:
        return Icons.notifications_active;
      case ActivityType.reportGenerated:
        return Icons.analytics;
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return "Just now";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes}m ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours}h ago";
    } else if (difference.inDays < 7) {
      return "${difference.inDays}d ago";
    } else {
      return "${timestamp.day}/${timestamp.month}/${timestamp.year}";
    }
  }
}

// Optional: Detailed Activity Log Screen
class ActivityLogScreen extends StatelessWidget {
  const ActivityLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          "Activity Log",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black87,
        actions: [
          IconButton(
            onPressed: () {
              _showFilterDialog(context);
            },
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: 20, // Show more activities in detailed view
        itemBuilder: (context, index) {
          // Generate more sample activities for the detailed view
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: CircleAvatar(
                backgroundColor: Colors.blue.withOpacity(0.1),
                child: Icon(Icons.inventory_2, color: Colors.blue, size: 20),
              ),
              title: Text(
                "Activity ${index + 1}",
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text("Sample activity description for item ${index + 1}"),
                  const SizedBox(height: 4),
                  Text(
                    "${index + 1}h ago",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Filter Activities"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CheckboxListTile(
              title: const Text("Stock Updates"),
              value: true,
              onChanged: (value) {},
            ),
            CheckboxListTile(
              title: const Text("New Orders"),
              value: true,
              onChanged: (value) {},
            ),
            CheckboxListTile(
              title: const Text("Driver Activities"),
              value: false,
              onChanged: (value) {},
            ),
            CheckboxListTile(
              title: const Text("System Alerts"),
              value: true,
              onChanged: (value) {},
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Apply filters
            },
            child: const Text("Apply"),
          ),
        ],
      ),
    );
  }
}