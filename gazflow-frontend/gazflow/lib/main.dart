import 'package:flutter/material.dart';
import 'package:gazflow/screens/customer_hone_screen.dart';
import 'package:gazflow/screens/driver_dashboard.dart';
import 'package:gazflow/screens/login_screen.dart';
import 'package:gazflow/screens/main_layout.dart';
import 'package:gazflow/screens/orders_screen.dart';
import 'package:gazflow/screens/profile_screen.dart';
import 'package:gazflow/screens/register_screen.dart';
import 'package:gazflow/screens/search_screen.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(GazFlowApp());
}

class GazFlowApp extends StatelessWidget {
  const GazFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GazFlow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),

      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/customerHome': (context) => MainLayout(),
        '/driverDashboard': (context) => DriverDashboardScreen(),
        '/search': (context) => SearchScreen(),
        '/orders': (context) => OrdersScreen(),
        '/profile': (context) => ProfileScreen(),
      },
    );
  }
}
