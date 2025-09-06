import 'package:flutter/material.dart';

class QuickActionsGrid extends StatelessWidget {
  final VoidCallback onManageLocationsPressed;
  final VoidCallback onManageBottlesPressed;
  final VoidCallback onSendNotificationPressed;
  final VoidCallback onGenerateReportPressed;
  final VoidCallback onInventoryPressed;
  final VoidCallback onDriverManagementPressed;

  const QuickActionsGrid({
    super.key,
    required this.onManageLocationsPressed,
    required this.onManageBottlesPressed,
    required this.onSendNotificationPressed,
    required this.onGenerateReportPressed,
    required this.onInventoryPressed,
    required this.onDriverManagementPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Quick Actions",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          
          // Primary Actions (Larger cards)
          Row(
            children: [
              Expanded(
                child: _buildPrimaryActionCard(
                  title: "Manage Locations",
                  subtitle: "Add, edit, delete storage",
                  icon: Icons.warehouse,
                  color: Colors.blue,
                  onTap: onManageLocationsPressed,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildPrimaryActionCard(
                  title: "Manage Bottles",
                  subtitle: "Update inventory levels",
                  icon: Icons.propane_tank,
                  color: Colors.green,
                  onTap: onManageBottlesPressed,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Secondary Actions (Smaller grid)
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 2.2,
            children: [
              _buildSecondaryActionCard(
                title: "Send Notification",
                icon: Icons.notifications_active,
                color: Colors.orange,
                onTap: onSendNotificationPressed,
              ),
              _buildSecondaryActionCard(
                title: "Analytics Reports",
                icon: Icons.analytics,
                color: Colors.purple,
                onTap: onGenerateReportPressed,
              ),
              _buildSecondaryActionCard(
                title: "Inventory Overview",
                icon: Icons.inventory_2,
                color: Colors.teal,
                onTap: onInventoryPressed,
              ),
              _buildSecondaryActionCard(
                title: "Driver Management",
                icon: Icons.people,
                color: Colors.indigo,
                onTap: onDriverManagementPressed,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPrimaryActionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.arrow_forward,
                  color: color,
                  size: 16,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecondaryActionCard({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
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
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}