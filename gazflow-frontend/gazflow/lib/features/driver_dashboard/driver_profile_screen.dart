import 'package:flutter/material.dart';
import 'package:gazflow/features/driver_dashboard/driver_bottom_nav.dart';

class DriverProfileScreen extends StatefulWidget {
  const DriverProfileScreen({super.key});

  @override
  State<DriverProfileScreen> createState() => _DriverProfileScreenState();
}

class _DriverProfileScreenState extends State<DriverProfileScreen> {
  final String driverName = "John Doe";
  final String phoneNumber = "+237 6XX XXX XXX";
  final String email = "john.doe@gazflow.com";
  final String vehicleNumber = "LT-1234-XY";
  final int totalDeliveries = 127;
  final double totalEarnings = 2540000; // CFA

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/driver_avatar.png'),
            ),
            const SizedBox(height: 16),
            Text(
              driverName,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 24),
            
            _buildProfileSection('Personal Info', [
              _buildInfoItem(Icons.phone, 'Phone', phoneNumber),
              _buildInfoItem(Icons.email, 'Email', email),
              _buildInfoItem(Icons.directions_car, 'Vehicle', vehicleNumber),
            ]),
            
            const SizedBox(height: 24),
            
            _buildProfileSection('Performance', [
              _buildInfoItem(Icons.local_shipping, 'Total Deliveries', totalDeliveries.toString()),
              _buildInfoItem(Icons.monetization_on, 'Total Earnings', '${totalEarnings.toStringAsFixed(0)} CFA'),
            ]),
            
            const SizedBox(height: 24),
            
            ElevatedButton(
              onPressed: () {
                // Handle logout
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: DriverBottomNavBar(
        currentIndex: 3,
        onItemSelected: _onNavItemSelected,
      ),
    );
  }

  Widget _buildProfileSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: children),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onNavItemSelected(int index) {
    if (index == 3) return; // Already on profile screen
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/driver-dashboard');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/driver-orders');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/driver-history');
        break;
    }
  }
}