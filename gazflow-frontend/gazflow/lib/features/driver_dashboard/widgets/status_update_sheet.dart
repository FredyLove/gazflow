import 'package:flutter/material.dart';
import 'package:gazflow/features/driver_dashboard/models/delivery_order.dart';
import 'package:gazflow/features/driver_dashboard/models/delivery_status.dart';

class StatusUpdateSheet extends StatelessWidget {
  final DeliveryOrder order;
  final Function(DeliveryStatus) onStatusUpdated;

  const StatusUpdateSheet({
    super.key,
    required this.order,
    required this.onStatusUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Update Order Status",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 20),
          
          _buildStatusOption(
            context, // Pass context here
            "Picked Up", 
            Icons.check_circle, 
            Colors.orange, 
            DeliveryStatus.pickedUp,
          ),
          
          _buildStatusOption(
            context, // Pass context here
            "In Transit", 
            Icons.local_shipping, 
            Colors.purple, 
            DeliveryStatus.inTransit,
          ),
          
          _buildStatusOption(
            context, // Pass context here
            "Delivered", 
            Icons.done_all, 
            Colors.green, 
            DeliveryStatus.delivered,
          ),
          
          const SizedBox(height: 10),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
            style: TextButton.styleFrom(
              foregroundColor: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusOption(
    BuildContext context, // Add context parameter
    String title, 
    IconData icon, 
    Color color, 
    DeliveryStatus status,
  ) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(title),
      onTap: () {
        Navigator.pop(context); // Now context is available
        onStatusUpdated(status);
      },
      contentPadding: EdgeInsets.zero,
    );
  }
}