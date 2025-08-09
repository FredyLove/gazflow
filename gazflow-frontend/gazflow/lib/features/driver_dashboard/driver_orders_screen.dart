import 'package:flutter/material.dart';
import 'package:gazflow/features/driver_dashboard/models/delivery_status.dart';
import 'package:gazflow/features/driver_dashboard/widgets/order_card.dart';
import 'package:gazflow/features/driver_dashboard/models/delivery_order.dart';
import 'package:gazflow/features/driver_dashboard/driver_bottom_nav.dart';

class DriverOrdersScreen extends StatefulWidget {
  const DriverOrdersScreen({super.key});

  @override
  State<DriverOrdersScreen> createState() => _DriverOrdersScreenState();
}

class _DriverOrdersScreenState extends State<DriverOrdersScreen> {
  // Sample orders data
  final List<DeliveryOrder> orders = [
    DeliveryOrder(
      id: "GF001235",
      customerName: "Marie Talla",
      address: "123 Main Street, Yaoundé",
      phone: "+237 6XX XXX XXX",
      gasType: "12.5kg Gas",
      status: DeliveryStatus.assigned,
      estimatedTime: "2:30 PM",
      distance: "3.2 km",
    ),
    // Add more orders...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: OrderCard(
              order: order,
              onNavigationPressed: () => _openNavigation(order),
              onCallPressed: () => _callCustomer(order),
              onChatPressed: () => _chatWithCustomer(order),
              onStatusPressed: () => _updateStatus(order),
            ),
          );
        },
      ),
      bottomNavigationBar: DriverBottomNavBar(
        currentIndex: 1,
        onItemSelected: _onNavItemSelected,
      ),
    );
  }

  void _onNavItemSelected(int index) {
    if (index == 1) return; // Already on orders screen
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/driver-dashboard');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/driver-history');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/driver-profile');
        break;
    }
  }

  void _openNavigation(DeliveryOrder order) {
    // Implement navigation
  }

  void _callCustomer(DeliveryOrder order) {
    // Implement call
  }

  void _chatWithCustomer(DeliveryOrder order) {
    // Implement chat
  }

  void _updateStatus(DeliveryOrder order) {
    // Implement status update
  }
}