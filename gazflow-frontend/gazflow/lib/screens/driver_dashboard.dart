import 'package:flutter/material.dart';

class DriverDashboardScreen extends StatelessWidget {
  const DriverDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Driver Dashboard')),
      body: Center(child: Text('Driver-specific dashboard')),
    );
  }
}
