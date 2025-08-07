import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  List<Map<String, dynamic>> activeOrders = [
    {
      'id': 'GF001235',
      'date': '2024-08-08',
      'status': 'On the way',
      'progress': 0.7,
      'amount': 4500,
      'items': '1x 6kg Gas Bottle',
      'estimatedTime': '15 mins',
      'driver': 'Paul Mbida',
      'driverPhone': '+237 6XX XXX XXX',
    },
  ];

  List<Map<String, dynamic>> orderHistory = [
    {
      'id': 'GF001234',
      'date': '2024-08-07',
      'status': 'Delivered',
      'amount': 4500,
      'items': '1x 6kg Gas Bottle',
      'rating': 5,
    },
    {
      'id': 'GF001233',
      'date': '2024-08-02',
      'status': 'Delivered',
      'amount': 8500,
      'items': '1x 12kg Gas Bottle',
      'rating': 4,
    },
    {
      'id': 'GF001232',
      'date': '2024-07-28',
      'status': 'Cancelled',
      'amount': 16000,
      'items': '1x 25kg Gas Bottle',
      'rating': null,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
    _tabController.dispose();
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
            stops: [0.0, 0.25],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              children: [
                // Header
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "My Orders",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 20),

                      // Tab Bar
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TabBar(
                          controller: _tabController,
                          indicator: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          labelColor: Colors.blue[600],
                          unselectedLabelColor: Colors.white,
                          tabs: [
                            Tab(text: "Active (${activeOrders.length})"),
                            Tab(text: "History"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Tab Views
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildActiveOrdersTab(),
                      _buildOrderHistoryTab(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActiveOrdersTab() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child:
          activeOrders.isEmpty
              ? _buildEmptyState(
                "No active orders",
                "Your current orders will appear here",
              )
              : ListView.builder(
                itemCount: activeOrders.length,
                itemBuilder: (context, index) {
                  final order = activeOrders[index];
                  return _buildActiveOrderCard(order);
                },
              ),
    );
  }

  Widget _buildOrderHistoryTab() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
        itemCount: orderHistory.length,
        itemBuilder: (context, index) {
          final order = orderHistory[index];
          return _buildHistoryOrderCard(order);
        },
      ),
    );
  }

  Widget _buildActiveOrderCard(Map<String, dynamic> order) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange[400]!, Colors.orange[500]!],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order #${order['id']}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      order['items'],
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  order['status'],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 16),

          LinearProgressIndicator(
            value: order['progress'],
            backgroundColor: Colors.white.withOpacity(0.3),
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),

          SizedBox(height: 12),

          Row(
            children: [
              Icon(Icons.person, color: Colors.white70, size: 16),
              SizedBox(width: 4),
              Text(
                "Driver: ${order['driver']}",
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
              Spacer(),
              Text(
                "ETA: ${order['estimatedTime']}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.location_on, size: 16),
                  label: Text("Track Order"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.orange[600],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.phone, size: 16),
                label: Text("Call"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.2),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryOrderCard(Map<String, dynamic> order) {
    Color statusColor = Colors.green;
    IconData statusIcon = Icons.check_circle;

    if (order['status'] == 'Cancelled') {
      statusColor = Colors.red;
      statusIcon = Icons.cancel;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
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
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(statusIcon, color: statusColor, size: 20),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Order #${order['id']}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${order['amount']} FCFA",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Text(
                  order['items'],
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
                Row(
                  children: [
                    Text(
                      order['date'],
                      style: TextStyle(color: Colors.grey[500], fontSize: 11),
                    ),
                    if (order['rating'] != null) ...[
                      Spacer(),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            Icons.star,
                            size: 12,
                            color:
                                index < order['rating']
                                    ? Colors.amber
                                    : Colors.grey[300],
                          );
                        }),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(String title, String subtitle) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.receipt_long_outlined, size: 80, color: Colors.grey[400]),
          SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8),
          Text(
            subtitle,
            style: TextStyle(color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
