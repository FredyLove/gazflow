import 'package:flutter/material.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../features/customer_dashboard/customer_hone_screen.dart';
import '../features/customer_dashboard/search_screen.dart'; // Import your other screens
import '../features/customer_dashboard/orders_screen.dart';
import '../features/customer_dashboard/profile_screen.dart';

class MainNavigationContainer extends StatefulWidget {
  const MainNavigationContainer({super.key});

  @override
  State<MainNavigationContainer> createState() =>
      _MainNavigationContainerState();
}

class _MainNavigationContainerState extends State<MainNavigationContainer> {
  int _currentIndex = 0;

  // List of all your screens
  final List<Widget> _screens = [
    CustomerHomeContent(), // Remove Scaffold from CustomerHomeScreen
    SearchScreen(),
    OrdersScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTabChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
