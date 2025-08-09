import 'package:flutter/material.dart';
import 'package:gazflow/features/driver_dashboard/models/delivery_status.dart';
import 'package:gazflow/features/driver_dashboard/widgets/order_card.dart';
import 'package:gazflow/features/driver_dashboard/models/delivery_order.dart';
import 'package:gazflow/features/driver_dashboard/driver_bottom_nav.dart';

class DriverHistoryScreen extends StatefulWidget {
  const DriverHistoryScreen({super.key});

  @override
  State<DriverHistoryScreen> createState() => _DriverHistoryScreenState();
}

class _DriverHistoryScreenState extends State<DriverHistoryScreen> {
  // Sample completed orders
  final List<DeliveryOrder> completedOrders = [
    DeliveryOrder(
      id: "GF001230",
      customerName: "Jean Dupont",
      address: "789 Market Ave, Yaoundé",
      phone: "+237 6XX XXX XXX",
      gasType: "6kg Gas",
      status: DeliveryStatus.delivered,
      estimatedTime: "Delivered at 11:30 AM",
      distance: "4.5 km",
    ),
    DeliveryOrder(
      id: "TO451230",
      customerName: "Fredy",
      address: "Awae Escalier, Yaoundé",
      phone: "+237 699816331",
      gasType: "6kg Gas",
      status: DeliveryStatus.delivered,
      estimatedTime: "Delivered at 11:30 AM",
      distance: "4.5 km",
    ),
    // Add more history items...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivery History'),
        centerTitle: true,
      ),
      body: completedOrders.isEmpty
          ? const Center(
              child: Text('No delivery history yet'),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: completedOrders.length,
              itemBuilder: (context, index) {
                final order = completedOrders[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: OrderCard(
                    order: order,
                    onNavigationPressed: () {},
                    onCallPressed: () {},
                    onChatPressed: () {},
                    onStatusPressed: () {},
                  ),
                );
              },
            ),
      bottomNavigationBar: DriverBottomNavBar(
        currentIndex: 2,
        onItemSelected: _onNavItemSelected,
      ),
    );
  }

  void _onNavItemSelected(int index) {
    if (index == 2) return; // Already on history screen
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/driver-dashboard');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/driver-orders');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/driver-profile');
        break;
    }
  }
}