import 'package:flutter/material.dart';
import 'package:gazflow/features/admin_dashboard/models/dashboard_stats.dart';

class StatsCard extends StatelessWidget {
  final DashboardStats stats;
  
  const StatsCard({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                _buildStatItem('Total Orders', stats.totalOrders, Icons.shopping_bag),
                _buildStatItem('Completed', stats.completedOrders, Icons.check_circle),
                _buildStatItem('Pending', stats.pendingOrders, Icons.pending),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildStatItem('Revenue', stats.totalRevenue, Icons.attach_money),
                _buildStatItem('Active Drivers', stats.activeDrivers, Icons.directions_car),
                _buildStatItem('Low Stock', stats.lowStockItems, Icons.warning),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, dynamic value, IconData icon) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: Colors.blue[600], size: 28),
          const SizedBox(height: 8),
          Text(
            value.toString(),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}