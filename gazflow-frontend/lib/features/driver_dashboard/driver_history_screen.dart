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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Delivery History',
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
            icon: const Icon(Icons.filter_alt_outlined),
            onPressed: _showFilterOptions,
            color: Colors.blue[600],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search delivery history...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onChanged: (value) {
                // Implement search functionality
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Chip(
                  label: const Text('Today'),
                  backgroundColor: Colors.blue[50],
                  labelStyle: TextStyle(color: Colors.blue[700]),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 8),
                Chip(
                  label: const Text('This Week'),
                  backgroundColor: Colors.grey[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const Spacer(),
                Text(
                  '${completedOrders.length} deliveries',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: completedOrders.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/empty_history.png',
                            height: 150),
                        const SizedBox(height: 16),
                        Text(
                          'No delivery history yet',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Your completed deliveries will appear here',
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                      ],
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: _refreshHistory,
                    child: ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: completedOrders.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final order = completedOrders[index];
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          child: OrderCard(
                            order: order,
                            onNavigationPressed: () => _viewOnMap(order),
                            onCallPressed: () => _callCustomer(order),
                            onChatPressed: () => _chatWithCustomer(order),
                            onStatusPressed: () {}, // Disabled for history
                          ),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
      bottomNavigationBar: DriverBottomNavBar(
        currentIndex: 2,
        onItemSelected: _onNavItemSelected,
      ),
    );
  }

  Future<void> _refreshHistory() async {
    // Implement refresh logic
    await Future.delayed(const Duration(seconds: 1));
  }

  void _showFilterOptions() {
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
              'Filter Deliveries',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildFilterOption('Today', Icons.today),
            _buildFilterOption('This Week', Icons.calendar_view_week),
            _buildFilterOption('This Month', Icons.calendar_today),
            _buildFilterOption('All Time', Icons.all_inclusive),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterOption(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue[600]),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        // Apply filter
      },
    );
  }

  void _viewOnMap(DeliveryOrder order) {
    // Implement map view
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

  void _onNavItemSelected(int index) {
    if (index == 2) return;
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