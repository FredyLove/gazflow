import 'package:flutter/material.dart';
import 'package:gazflow/screens/customer_hone_screen.dart';
import 'package:gazflow/screens/orders_screen.dart';
import 'package:gazflow/screens/profile_screen.dart';
import 'package:gazflow/screens/search_screen.dart';
import 'package:gazflow/widgets/custom_bottom_nav_bar.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    CustomerHomeContent(),
    SearchScreen(),
    OrdersScreen(),
    ProfileScreen(),
  ];

  void _onTabChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTabChanged: _onTabChanged,
      ),
    );
  }
}
