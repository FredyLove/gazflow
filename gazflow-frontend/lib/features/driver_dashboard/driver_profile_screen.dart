import 'package:flutter/material.dart';
import 'package:gazflow/features/driver_dashboard/driver_bottom_nav.dart';

class DriverProfileScreen extends StatefulWidget {
  const DriverProfileScreen({super.key});

  @override
  State<DriverProfileScreen> createState() => _DriverProfileScreenState();
}

class _DriverProfileScreenState extends State<DriverProfileScreen> {
  final String driverName = "John Doe";
  final String phoneNumber = "+237 672 380 318";
  final String email = "john.doe@gmail.com";
  final String vehicleNumber = "LT-1234-XY";
  final int totalDeliveries = 127;
  final double totalEarnings = 25400; // CFA
  final double rating = 4.8;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('My Profile',
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
            icon: const Icon(Icons.edit_outlined),
            onPressed: _navigateToEditProfile,
            color: Colors.blue[600],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                const CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/images/driver_avatar.png'),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue[600],
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.camera_alt, size: 20, color: Colors.white),
                    onPressed: _changeProfilePicture,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              driverName,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, color: Colors.amber[400], size: 20),
                const SizedBox(width: 4),
                Text(
                  rating.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            _buildProfileSection('Personal Information', Icons.person_outline, [
              _buildInfoItem(Icons.phone_outlined, 'Phone', phoneNumber, true),
              _buildInfoItem(Icons.email_outlined, 'Email', email, false),
              _buildInfoItem(Icons.directions_car_outlined, 'Vehicle', vehicleNumber, false),
            ]),
            
            const SizedBox(height: 16),
            
            _buildProfileSection('Performance Stats', Icons.analytics_outlined, [
              _buildInfoItem(Icons.local_shipping_outlined, 'Total Deliveries', '$totalDeliveries', false),
              _buildInfoItem(Icons.monetization_on_outlined, 'Total Earnings', '${totalEarnings.toStringAsFixed(0)} CFA', false),
              _buildInfoItem(Icons.thumb_up_outlined, 'Completion Rate', '98%', false),
            ]),
            
            const SizedBox(height: 24),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _buildActionButton(
                    icon: Icons.settings_outlined,
                    label: 'Settings',
                    onPressed: _navigateToSettings,
                  ),
                  const SizedBox(height: 12),
                  _buildActionButton(
                    icon: Icons.help_outline,
                    label: 'Help & Support',
                    onPressed: _navigateToHelp,
                  ),
                  const SizedBox(height: 12),
                  _buildActionButton(
                    icon: Icons.logout,
                    label: 'Logout',
                    color: Colors.red,
                    textColor: Colors.red,
                    onPressed: _confirmLogout,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: DriverBottomNavBar(
        currentIndex: 3,
        onItemSelected: _onNavItemSelected,
      ),
    );
  }

  Widget _buildProfileSection(String title, IconData icon, List<Widget> children) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.blue[600], size: 20),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value, bool isClickable) {
    return InkWell(
      onTap: isClickable ? () => _handleItemClick(label, value) : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey[600], size: 22),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            if (isClickable)
              Icon(Icons.chevron_right, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    Color color = Colors.blue,
    Color textColor = Colors.black87,
  }) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: textColor,
        side: BorderSide(color: Colors.grey[200]!),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 16),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: textColor,
            ),
          ),
          const Spacer(),
          Icon(Icons.chevron_right, color: Colors.grey[400]),
        ],
      ),
    );
  }

  void _navigateToEditProfile() {
    // Navigate to edit profile screen
  }

  void _changeProfilePicture() {
    // Handle profile picture change
  }

  void _navigateToSettings() {
    // Navigate to settings screen
  }

  void _navigateToHelp() {
    // Navigate to help screen
  }

  void _confirmLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              Navigator.pop(context);
              // Handle logout
            },
            child: const Text('Logout', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _handleItemClick(String label, String value) {
    // Handle click on profile items
    if (label == 'Phone') {
      // Handle phone click
    }
  }

  void _onNavItemSelected(int index) {
    if (index == 3) return;
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