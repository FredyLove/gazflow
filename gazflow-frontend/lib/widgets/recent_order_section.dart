import 'package:flutter/material.dart';
import 'package:gazflow/widgets/header_section.dart';

class RecentOrdersSection extends StatelessWidget {
  final VoidCallback onViewAllPressed;
  final Function(String) onOrderPressed;

  const RecentOrdersSection({
    super.key,
    required this.onViewAllPressed,
    required this.onOrderPressed,
  });

  @override
  Widget build(BuildContext context) {
    final recentOrders = [
      {
        'id': 'GF001234',
        'date': '2024-08-07',
        'status': 'Delivered',
        'amount': 4500,
        'items': '1x 6kg Gas Bottle',
      },
      {
        'id': 'GF001233',
        'date': '2024-08-02',
        'status': 'Delivered',
        'amount': 8500,
        'items': '1x 12kg Gas Bottle',
      },
    ];

    return Column(
      children: [
        SectionHeader(
          title: "Recent Orders",
          actionText: "View All",
          onActionPressed: onViewAllPressed,
        ),
        SizedBox(height: 16),
        Column(
          children:
              recentOrders.map((order) {
                return RecentOrderCard(
                  order: order,
                  onPressed: () => onOrderPressed(order['id'] as String),
                );
              }).toList(),
        ),
      ],
    );
  }
}

class RecentOrderCard extends StatelessWidget {
  final Map<String, dynamic> order;
  final VoidCallback onPressed;

  const RecentOrderCard({
    super.key,
    required this.order,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
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
      child: InkWell(
        onTap: onPressed,
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.check_circle,
                color: Colors.green[600],
                size: 20,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Order ${order['id']}",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${order['amount']} FCFA",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    order['items'],
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  Text(
                    order['date'],
                    style: TextStyle(color: Colors.grey[500], fontSize: 11),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
