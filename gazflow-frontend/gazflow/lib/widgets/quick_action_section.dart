import 'package:flutter/material.dart';

class QuickActionsSection extends StatelessWidget {
  final VoidCallback onOrderNowPressed;
  final VoidCallback onSchedulePressed;
  final VoidCallback onSupportPressed;

  const QuickActionsSection({
    Key? key,
    required this.onOrderNowPressed,
    required this.onSchedulePressed,
    required this.onSupportPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: QuickActionCard(
            title: "Order Now",
            icon: Icons.add_shopping_cart,
            color: Colors.green,
            onTap: onOrderNowPressed,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: QuickActionCard(
            title: "Schedule",
            icon: Icons.schedule,
            color: Colors.blue,
            onTap: onSchedulePressed,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: QuickActionCard(
            title: "Support",
            icon: Icons.support_agent,
            color: Colors.purple,
            onTap: onSupportPressed,
          ),
        ),
      ],
    );
  }
}

class QuickActionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const QuickActionCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
