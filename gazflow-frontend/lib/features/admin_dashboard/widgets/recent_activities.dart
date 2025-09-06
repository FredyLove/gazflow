import 'package:flutter/material.dart';
import 'package:gazflow/features/admin_dashboard/models/recent_activity.dart';

class RecentActivities extends StatelessWidget {
  const RecentActivities({super.key});

  @override
  Widget build(BuildContext context) {
    final activities = [
      RecentActivity(
        title: 'New order received',
        description: 'Order #GF-3421 for 12.5kg gas',
        time: '10 mins ago',
        icon: Icons.shopping_bag,
        color: Colors.green,
      ),
      RecentActivity(
        title: 'Delivery completed',
        description: 'Order #GF-3418 by Driver John',
        time: '25 mins ago',
        icon: Icons.check_circle,
        color: Colors.blue,
      ),
      RecentActivity(
        title: 'Low stock alert',
        description: '6kg gas cylinders running low',
        time: '1 hour ago',
        icon: Icons.warning,
        color: Colors.orange,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Activities',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ...activities.map((activity) => _buildActivityItem(activity)),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {},
                  child: const Text('View All Activities'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActivityItem(RecentActivity activity) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: activity.color.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(activity.icon, color: activity.color),
      ),
      title: Text(
        activity.title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(activity.description),
      trailing: Text(
        activity.time,
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey[600],
        ),
      ),
    );
  }
}