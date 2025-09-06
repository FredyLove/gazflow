import 'package:flutter/material.dart';

class StoreManagerNavBar extends StatelessWidget {
  final int currentIndex;

  const StoreManagerNavBar({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                context,
                0,
                Icons.dashboard_outlined,
                Icons.dashboard,
                "Dashboard",
                currentIndex == 0,
              ),
              _buildNavItem(
                context,
                1,
                Icons.warehouse_outlined,
                Icons.warehouse,
                "Inventory",
                currentIndex == 1,
              ),
              _buildNavItem(
                context,
                2,
                Icons.analytics_outlined,
                Icons.analytics,
                "Analytics",
                currentIndex == 2,
              ),
              _buildNavItem(
                context,
                3,
                Icons.people_outline,
                Icons.people,
                "Drivers",
                currentIndex == 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    int index,
    IconData inactiveIcon,
    IconData activeIcon,
    String label,
    bool isActive,
  ) {
    return GestureDetector(
      onTap: () => _handleNavigation(context, index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? Colors.purple[50] : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? activeIcon : inactiveIcon,
              color: isActive ? Colors.purple[700] : Colors.grey[500],
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.purple[700] : Colors.grey[500],
                fontSize: 12,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleNavigation(BuildContext context, int index) {
    switch (index) {
      case 0:
        if (currentIndex != 0) {
          Navigator.pushReplacementNamed(context, '/store-manager-dashboard');
        }
        break;
      case 1:
        Navigator.pushNamed(context, '/inventory-management');
        break;
      case 2:
        Navigator.pushNamed(context, '/analytics-reports');
        break;
      case 3:
        Navigator.pushNamed(context, '/driver-management');
        break;
    }
  }
}