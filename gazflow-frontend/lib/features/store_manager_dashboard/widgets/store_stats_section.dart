import 'package:flutter/material.dart';

class StoreStatsSection extends StatelessWidget {
  final int totalLocations;
  final int totalBottles;
  final double dailySales;
  final int activeDrivers;
  final int lowStockLocations;

  const StoreStatsSection({
    super.key,
    required this.totalLocations,
    required this.totalBottles,
    required this.dailySales,
    required this.activeDrivers,
    required this.lowStockLocations,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Overview",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          
          // First Row - Main Stats
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  title: "Storage Locations",
                  value: totalLocations.toString(),
                  icon: Icons.warehouse,
                  color: Colors.blue,
                  subtitle: "Active locations",
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  title: "Total Bottles",
                  value: totalBottles.toString(),
                  icon: Icons.propane_tank,
                  color: Colors.green,
                  subtitle: "In inventory",
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Second Row - Performance Stats
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  title: "Daily Sales",
                  value: "${(dailySales / 1000).toStringAsFixed(0)}K",
                  icon: Icons.trending_up,
                  color: Colors.purple,
                  subtitle: "CFA today",
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  title: "Active Drivers",
                  value: activeDrivers.toString(),
                  icon: Icons.local_shipping,
                  color: Colors.orange,
                  subtitle: "Online now",
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Alert Card for Low Stock
          if (lowStockLocations > 0)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.red[200]!),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning, color: Colors.red[600], size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Low Stock Alert",
                          style: TextStyle(
                            color: Colors.red[800],
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "$lowStockLocations locations need restocking",
                          style: TextStyle(
                            color: Colors.red[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to inventory management
                    },
                    child: Text(
                      "View",
                      style: TextStyle(color: Colors.red[700]),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Icon(
                Icons.arrow_upward,
                color: Colors.green,
                size: 16,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}