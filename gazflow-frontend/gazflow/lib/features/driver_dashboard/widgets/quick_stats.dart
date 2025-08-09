import 'package:flutter/material.dart';


class QuickStats extends StatelessWidget {
  final int totalDeliveries;
  final double earnings;
  final int pendingOrders;

  const QuickStats({
    super.key,
    required this.totalDeliveries,
    required this.earnings,
    required this.pendingOrders,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              "Deliveries", 
              totalDeliveries.toString(), 
              Icons.local_shipping,
              Colors.blue,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: _buildStatCard(
              "Earnings", 
              "${earnings.toStringAsFixed(0)} CFA", 
              Icons.monetization_on,
              Colors.green,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: _buildStatCard(
              "Pending", 
              pendingOrders.toString(), 
              Icons.pending_actions,
              Colors.orange,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}