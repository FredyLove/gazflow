import 'package:flutter/material.dart';
import 'package:gazflow/features/driver_dashboard/driver_bottom_nav.dart';
import 'package:gazflow/features/driver_dashboard/models/delivery_order.dart';
import 'package:gazflow/features/driver_dashboard/models/delivery_status.dart';
import 'package:gazflow/features/driver_dashboard/widgets/active_orders.dart';
import 'package:gazflow/features/driver_dashboard/widgets/driver_header.dart';
import 'package:gazflow/features/driver_dashboard/widgets/quick_actions.dart';
import 'package:gazflow/features/driver_dashboard/widgets/quick_stats.dart';
import 'package:gazflow/features/driver_dashboard/widgets/status_update_sheet.dart';

class DriverDashboardScreen extends StatefulWidget {
  const DriverDashboardScreen({super.key});

  @override
  State<DriverDashboardScreen> createState() => _DriverDashboardScreenState();
}

class _DriverDashboardScreenState extends State<DriverDashboardScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  // Driver data
  String driverName = "John Doe";
  bool isOnline = true;
  int totalDeliveries = 24;
  double earnings = 45000; // CFA
  int pendingOrders = 3;

  // Sample orders data
  List<DeliveryOrder> orders = [
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
      customerName: "Joseph Owona",
      address: "456 Market Street, Yaoundé",
      phone: "+237 6XX XXX XXX",
      gasType: "6kg Gas",
      status: DeliveryStatus.inTransit,
      estimatedTime: "3:15 PM",
      distance: "5.1 km",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeIn));
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Driver Header
            SliverToBoxAdapter(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: DriverHeader(
                  driverName: driverName,
                  isOnline: isOnline,
                  onStatusChanged: (value) {
                    setState(() {
                      isOnline = value;
                    });
                  },
                  onNotificationsPressed: _handleNotifications,
                ),
              ),
            ),

            // Quick Stats
            SliverToBoxAdapter(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: QuickStats(
                  totalDeliveries: totalDeliveries,
                  earnings: earnings,
                  pendingOrders: pendingOrders,
                ),
              ),
            ),

            // Quick Actions
            SliverToBoxAdapter(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: QuickActions(
                  onEmergencyPressed: _showEmergencyDialog,
                  onSupportPressed: _contactSupport,
                ),
              ),
            ),

            // Active Orders
            SliverToBoxAdapter(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: ActiveOrders(
                  orders: orders,
                  onViewAllPressed: _viewAllOrders,
                  onNavigationPressed: _openNavigation,
                  onCallPressed: _callCustomer,
                  onChatPressed: _chatWithCustomer,
                  onStatusPressed: _updateStatus,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: DriverBottomNavBar(
        currentIndex: 0,
        onItemSelected: _onNavItemSelected,
      ),
    );
  }

  void _onNavItemSelected(int index) {
    // Handle navigation item selection
    switch (index) {
      case 0:
        // Already on dashboard
        break;
      case 1:
        Navigator.pushNamed(context, '/driver-orders');
        break;
      case 2:
        Navigator.pushNamed(context, '/driver-history');
        break;
      case 3:
        Navigator.pushNamed(context, '/driver-profile');
        break;
    }
  }

  void _handleNotifications() {
    // Handle notifications
    Navigator.pushNamed(context, '/notifications');
  }

  void _viewAllOrders(DeliveryOrder order) {
    Navigator.pushNamed(context, '/driver-orders');
  }

  void _openNavigation(DeliveryOrder order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Navigation"),
        content: Text("Open navigation to:\n${order.address}"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Launch GPS app with coordinates
            },
            child: const Text("Open GPS"),
          ),
        ],
      ),
    );
  }

  void _callCustomer(DeliveryOrder order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Call Customer"),
        content: Text("Call ${order.customerName}?\n${order.phone}"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Launch phone dialer
            },
            child: const Text("Call"),
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
      builder: (context) => StatusUpdateSheet(
        order: order,
        onStatusUpdated: (newStatus) {
          _updateOrderStatus(order, newStatus);
        },
      ),
    );
  }

  void _updateOrderStatus(DeliveryOrder order, DeliveryStatus newStatus) {
    setState(() {
      final index = orders.indexWhere((o) => o.id == order.id);
      if (index != -1) {
        orders[index] = order.copyWith(status: newStatus);
      }
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Status updated: ${newStatus.displayText}"),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _showEmergencyDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.warning, color: Colors.red),
            SizedBox(width: 8),
            Text("Emergency"),
          ],
        ),
        content: const Text("Contact emergency services?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
              // Call emergency services
            },
            child: const Text("Call Emergency"),
          ),
        ],
      ),
    );
  }

  void _contactSupport() {
    Navigator.pushNamed(context, '/support');
  }
}