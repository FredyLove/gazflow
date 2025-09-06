import 'package:flutter/material.dart';
import 'package:gazflow/features/driver_dashboard/models/delivery_order.dart';
import 'package:gazflow/features/driver_dashboard/widgets/order_card.dart';

class ActiveOrders extends StatelessWidget {
  final List<DeliveryOrder> orders;
  final Function(DeliveryOrder) onViewAllPressed;
  final Function(DeliveryOrder) onNavigationPressed;
  final Function(DeliveryOrder) onCallPressed;
  final Function(DeliveryOrder) onChatPressed;
  final Function(DeliveryOrder) onStatusPressed;

  const ActiveOrders({
    super.key,
    required this.orders,
    required this.onViewAllPressed,
    required this.onNavigationPressed,
    required this.onCallPressed,
    required this.onChatPressed,
    required this.onStatusPressed,
  });

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
              Text(
                "Assigned Orders",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              TextButton(
                onPressed: () => onViewAllPressed(orders.first),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue,
                ),
                child: const Text("View All"),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...orders.map((order) => OrderCard(
                order: order,
                onNavigationPressed: () => onNavigationPressed(order),
                onCallPressed: () => onCallPressed(order),
                onChatPressed: () => onChatPressed(order),
                onStatusPressed: () => onStatusPressed(order),
              )),
        ],
      ),
    );
  }
}