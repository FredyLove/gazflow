import 'package:flutter/material.dart';
import 'package:gazflow/features/driver_dashboard/models/delivery_order.dart';
import 'package:gazflow/features/driver_dashboard/models/delivery_status.dart';


class OrderCard extends StatelessWidget {
  final DeliveryOrder order;
  final VoidCallback onNavigationPressed;
  final VoidCallback onCallPressed;
  final VoidCallback onChatPressed;
  final VoidCallback onStatusPressed;

  const OrderCard({
    super.key,
    required this.order,
    required this.onNavigationPressed,
    required this.onCallPressed,
    required this.onChatPressed,
    required this.onStatusPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      order.id,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: order.status.color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        order.status.displayText,
                        style: TextStyle(
                          color: order.status.color,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                
                _buildInfoRow(Icons.person, order.customerName),
                const SizedBox(height: 8),
                _buildInfoRow(Icons.location_on, order.address),
                const SizedBox(height: 8),
                _buildInfoRow(Icons.propane_tank, order.gasType),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.access_time, color: Colors.grey, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      "ETA: ${order.estimatedTime}",
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const Spacer(),
                    const Icon(Icons.navigation, color: Colors.grey, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      order.distance,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Action buttons
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                _buildOrderActionButton(
                  "Navigate",
                  Icons.navigation,
                  Colors.blue,
                  onNavigationPressed,
                ),
                const SizedBox(width: 8),
                _buildOrderActionButton(
                  "Call",
                  Icons.phone,
                  Colors.green,
                  onCallPressed,
                ),
                const SizedBox(width: 8),
                _buildOrderActionButton(
                  "Chat",
                  Icons.chat,
                  Colors.orange,
                  onChatPressed,
                ),
                const SizedBox(width: 8),
                _buildOrderActionButton(
                  "Update",
                  Icons.update,
                  Colors.purple,
                  onStatusPressed,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey, size: 16),
        const SizedBox(width: 8),
        Expanded(child: Text(text)),
      ],
    );
  }

  Widget _buildOrderActionButton(String label, IconData icon, Color color, VoidCallback onTap) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 16),
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}