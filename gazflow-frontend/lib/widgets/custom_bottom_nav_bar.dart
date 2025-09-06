import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int)? onTabChanged; // Make this optional

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    this.onTabChanged, // Optional callback for parent to know about tab changes
  });

  // Handle navigation internally
  void _handleNavigation(BuildContext context, int index) {
    // Call the callback to change tabs
    if (onTabChanged != null) {
      onTabChanged!(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NavBarItem(
                icon: Icons.home,
                label: "Home",
                isActive: currentIndex == 0,
                onTap: () => _handleNavigation(context, 0),
              ),
              NavBarItem(
                icon: Icons.search,
                label: "Search",
                isActive: currentIndex == 1,
                onTap: () => _handleNavigation(context, 1),
              ),
              NavBarItem(
                icon: Icons.receipt_long,
                label: "Orders",
                isActive: currentIndex == 2,
                onTap: () => _handleNavigation(context, 2),
              ),
              NavBarItem(
                icon: Icons.person,
                label: "Profile",
                isActive: currentIndex == 3,
                onTap: () => _handleNavigation(context, 3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const NavBarItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? Colors.blue[600] : Colors.grey[500],
            size: 24,
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.blue[600] : Colors.grey[500],
              fontSize: 12,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
