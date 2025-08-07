import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // User data
  Map<String, dynamic> userData = {
    'name': 'John Doe',
    'phone': '+237 6XX XXX XXX',
    'email': 'john.doe@example.com',
    'address': 'Yaoundé, Centre',
    'memberSince': '2024',
    'totalOrders': 24,
    'totalSpent': 180000,
  };

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[600]!, Colors.blue[50]!],
            stops: [0.0, 0.3],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Profile Header
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Profile",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Spacer(),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.settings, color: Colors.white),
                            ),
                          ],
                        ),

                        SizedBox(height: 20),

                        // User Avatar and Info
                        Column(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.white,
                              child: Text(
                                userData['name']
                                    .split(' ')
                                    .map((e) => e[0])
                                    .join(),
                                style: TextStyle(
                                  color: Colors.blue[600],
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            SizedBox(height: 16),

                            Text(
                              userData['name'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            Text(
                              userData['phone'],
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                            ),

                            SizedBox(height: 20),

                            // Stats Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildStatItem(
                                  "Orders",
                                  "${userData['totalOrders']}",
                                ),
                                _buildStatItem(
                                  "Spent",
                                  "${userData['totalSpent']} FCFA",
                                ),
                                _buildStatItem(
                                  "Member Since",
                                  userData['memberSince'],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Profile Content
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // Personal Information
                        _buildSectionCard("Personal Information", [
                          _buildInfoTile(
                            Icons.person,
                            "Full Name",
                            userData['name'],
                          ),
                          _buildInfoTile(
                            Icons.phone,
                            "Phone Number",
                            userData['phone'],
                          ),
                          _buildInfoTile(
                            Icons.email,
                            "Email",
                            userData['email'],
                          ),
                          _buildInfoTile(
                            Icons.location_on,
                            "Address",
                            userData['address'],
                          ),
                        ]),

                        SizedBox(height: 16),

                        // App Settings
                        _buildSectionCard("App Settings", [
                          _buildActionTile(
                            Icons.notifications,
                            "Notifications",
                            "Manage your notifications",
                            () {},
                          ),
                          _buildActionTile(
                            Icons.payment,
                            "Payment Methods",
                            "Manage payment options",
                            () {},
                          ),
                          _buildActionTile(
                            Icons.location_on,
                            "Delivery Addresses",
                            "Manage your addresses",
                            () {},
                          ),
                          _buildActionTile(
                            Icons.language,
                            "Language",
                            "English",
                            () {},
                          ),
                        ]),

                        SizedBox(height: 16),

                        // Support
                        _buildSectionCard("Support", [
                          _buildActionTile(
                            Icons.help,
                            "Help Center",
                            "Get help and support",
                            () {},
                          ),
                          _buildActionTile(
                            Icons.feedback,
                            "Feedback",
                            "Share your thoughts",
                            () {},
                          ),
                          _buildActionTile(
                            Icons.star,
                            "Rate App",
                            "Rate us on the store",
                            () {},
                          ),
                        ]),

                        SizedBox(height: 24),

                        // Logout Button
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              _showLogoutDialog();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[500],
                              padding: EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              "Logout",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(label, style: TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }

  Widget _buildSectionCard(String title, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
          ),
          Divider(height: 1, color: Colors.grey[200]),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String label, String value) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.blue[600], size: 20),
      ),
      title: Text(
        label,
        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
      ),
      subtitle: Text(
        value,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      trailing: IconButton(
        icon: Icon(Icons.edit, color: Colors.grey[400], size: 20),
        onPressed: () {
          // Handle edit
        },
      ),
    );
  }

  Widget _buildActionTile(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.grey[600], size: 20),
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey[400],
      ),
      onTap: onTap,
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text("Logout", style: TextStyle(fontWeight: FontWeight.w600)),
          content: Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel", style: TextStyle(color: Colors.grey[600])),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle logout
                Navigator.pop(context);
                // Navigate to login screen
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[500],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text("Logout", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
