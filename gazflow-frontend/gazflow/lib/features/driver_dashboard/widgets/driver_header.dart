import 'package:flutter/material.dart';

class DriverHeader extends StatelessWidget {
  final String driverName;
  final bool isOnline;
  final ValueChanged<bool> onStatusChanged;
  final VoidCallback onNotificationsPressed;

  const DriverHeader({
    super.key,
    required this.driverName,
    required this.isOnline,
    required this.onStatusChanged,
    required this.onNotificationsPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[700]!, Colors.blue[500]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello, $driverName",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "GazFlow Driver",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: onNotificationsPressed,
                icon: const Icon(Icons.notifications, color: Colors.white, size: 28),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Availability Toggle
          Row(
            children: [
              const Text(
                "Status: ",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              Switch(
                value: isOnline,
                onChanged: onStatusChanged,
                activeColor: Colors.green,
                inactiveThumbColor: Colors.red[200],
              ),
              Text(
                isOnline ? "Online" : "Offline",
                style: TextStyle(
                  color: isOnline ? Colors.green[200] : Colors.red[200],
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}