import 'package:flutter/material.dart';
import 'package:gazflow/features/admin_dashboard/admin_dashboard_screen.dart';
import 'package:gazflow/features/driver_dashboard/driver_dashboard_screen.dart';
import 'package:gazflow/features/driver_dashboard/driver_history_screen.dart';
import 'package:gazflow/features/driver_dashboard/driver_orders_screen.dart';
import 'package:gazflow/features/driver_dashboard/driver_profile_screen.dart';
import 'package:gazflow/features/store_manager_dashboard/store_manager_dashboard_screen.dart';
import 'package:gazflow/screens/login_screen.dart';
import 'package:gazflow/features/customer_dashboard/main_layout.dart';
import 'package:gazflow/features/customer_dashboard/orders_screen.dart';
import 'package:gazflow/features/customer_dashboard/profile_screen.dart';
import 'package:gazflow/screens/register_screen.dart';
import 'package:gazflow/features/customer_dashboard/search_screen.dart';
import 'package:gazflow/screens/welcome_page.dart';
import 'screens/onboarding_screen.dart';

void main() {
  runApp(const GazFlowApp());
}

class GazFlowApp extends StatelessWidget {
  const GazFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GazFlow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const OnboardingScreen(),
        '/home': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/customer-home': (context) => const MainLayout(),
        '/driver-dashboard': (context) => const DriverDashboardScreen(),
        '/driver-orders': (context) => const DriverOrdersScreen(),
        '/driver-history': (context) => const DriverHistoryScreen(),
        '/driver-profile': (context) => const DriverProfileScreen(),
        '/admin-dashboard': (context) => const AdminDashboardScreen(),
        '/store-manager-dashboard': (context) => const StoreManagerDashboardScreen(),
        '/search': (context) => const SearchScreen(),
        '/orders': (context) => const OrdersScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}