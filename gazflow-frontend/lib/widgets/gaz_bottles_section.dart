import 'package:flutter/material.dart';
import 'package:gazflow/widgets/header_section.dart';

class GasBottlesSection extends StatelessWidget {
  final VoidCallback onViewAllPressed;
  final Function(Map<String, dynamic>) onBottleOrderPressed;

  const GasBottlesSection({
    super.key,
    required this.onViewAllPressed,
    required this.onBottleOrderPressed,
  });

  @override
  Widget build(BuildContext context) {
    final gasBottles = [
      {
        'name': '6kg Gas Bottle',
        'price': 4500,
        'image': Icons.propane_tank,
        'available': true,
        'delivery': '30-45 min',
      },
      {
        'name': '12kg Gas Bottle',
        'price': 8500,
        'image': Icons.propane_tank,
        'available': true,
        'delivery': '30-45 min',
      },
      {
        'name': '25kg Gas Bottle',
        'price': 16000,
        'image': Icons.propane_tank,
        'available': false,
        'delivery': '1-2 hours',
      },
    ];

    return Column(
      children: [
        SectionHeader(
          title: "Available Gas Bottles",
          actionText: "View All",
          onActionPressed: onViewAllPressed,
        ),
        SizedBox(height: 16),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: gasBottles.length,
            itemBuilder: (context, index) {
              final bottle = gasBottles[index];
              return GasBottleCard(
                bottle: bottle,
                onOrderPressed: () => onBottleOrderPressed(bottle),
              );
            },
          ),
        ),
      ],
    );
  }
}

class GasBottleCard extends StatelessWidget {
  final Map<String, dynamic> bottle;
  final VoidCallback onOrderPressed;

  const GasBottleCard({
    super.key,
    required this.bottle,
    required this.onOrderPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: EdgeInsets.only(right: 12),
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
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(bottle['image'], size: 32, color: Colors.blue[600]),
            ),
            SizedBox(height: 8),
            Text(
              bottle['name'],
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
            Text(
              "${bottle['price']} FCFA",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue[600],
              ),
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              height: 32,
              child: ElevatedButton(
                onPressed: bottle['available'] ? onOrderPressed : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      bottle['available'] ? Colors.blue[600] : Colors.grey[300],
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  bottle['available'] ? "Order" : "N/A",
                  style: TextStyle(
                    fontSize: 12,
                    color:
                        bottle['available'] ? Colors.white : Colors.grey[600],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
