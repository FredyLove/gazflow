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
    DeliveryOrder(
      id: "GF001236",
      customerName: "Jean Dupont",
      address: "456 Market Avenue, Yaoundé",
      phone: "+237 6XX XXX XXX",
      gasType: "6kg Gas",
      status: DeliveryStatus.inTransit,
      estimatedTime: "3:45 PM",
      distance: "5.1 km",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('My Orders',
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 20)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black87),
        actions: [
          IconButton(
            icon: Badge(
              backgroundColor: Colors.red[400],
              child: const Icon(Icons.notifications_outlined),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search orders...',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue[600],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.filter_list, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: orders.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/empty_orders.png',
                            height: 150),
                        const SizedBox(height: 16),
                        Text(
                          'No orders assigned yet',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'When you get new orders, they will appear here',
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                      ],
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: () async {
                      // Add refresh logic
                      await Future.delayed(const Duration(seconds: 1));
                    },
                    child: ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: orders.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final order = orders[index];
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
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
                  ),
          ),
        ],
      ),
      bottomNavigationBar: DriverBottomNavBar(
        currentIndex: 1,
        onItemSelected: _onNavItemSelected, // Correctly passing the handler
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new order action
        },
        backgroundColor: Colors.blue[600],
        child: const Icon(Icons.add, color: Colors.white),
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
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        height: 300,
        child: Column(
          children: [
            Text(
              'Navigate to ${order.customerName}',
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.map_outlined, color: Colors.blue),
              title: const Text('Open in Maps'),
              onTap: () {
                Navigator.pop(context);
                // Open maps
              },
            ),
            ListTile(
              leading: const Icon(Icons.directions_outlined, color: Colors.green),
              title: const Text('Get Directions'),
              onTap: () {
                Navigator.pop(context);
                // Get directions
              },
            ),
          ],
        ),
      ),
    );
  }

  void _callCustomer(DeliveryOrder order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Call ${order.customerName}?'),
        content: Text(order.phone),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            onPressed: () {
              Navigator.pop(context);
              // Initiate call
            },
            child: const Text('Call', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _chatWithCustomer(DeliveryOrder order) {
    Navigator.pushNamed(context, '/chat', arguments: order);
  }

  void _updateStatus(DeliveryOrder order) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Update Order Status',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildStatusOption(
                'Picked Up', Icons.check_circle, Colors.orange, order),
            _buildStatusOption(
                'In Transit', Icons.local_shipping, Colors.purple, order),
            _buildStatusOption(
                'Delivered', Icons.done_all, Colors.green, order),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusOption(
      String title, IconData icon, Color color, DeliveryOrder order) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        setState(() {
          // Update status logic
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Status updated to $title'),
            backgroundColor: color,
          ),
        );
      },
    );
  }
}