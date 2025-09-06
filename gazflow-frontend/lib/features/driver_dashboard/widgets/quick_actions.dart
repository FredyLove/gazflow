import 'package:flutter/material.dart';

class QuickActions extends StatelessWidget {
  final VoidCallback onNavigationPressed;
  final VoidCallback onEmergencyPressed;
  final VoidCallback onSupportPressed;
  final VoidCallback onTrainingPressed;

  const QuickActions({
    super.key,
    required this.onNavigationPressed,
    required this.onEmergencyPressed,
    required this.onSupportPressed,
    required this.onTrainingPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "QUICK ACTIONS",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
                letterSpacing: 1.0,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 12,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  _buildActionButton(
                    context,
                    "Navigate",
                    Icons.navigation,
                    Colors.blue[700]!,
                    onNavigationPressed,
                  ),
                  const SizedBox(width: 12),
                  _buildActionButton(
                    context,
                    "Emergency",
                    Icons.emergency,
                    Colors.red[600]!,
                    onEmergencyPressed,
                  ),
                  const SizedBox(width: 12),
                  _buildActionButton(
                    context,
                    "Support",
                    Icons.headset_mic,
                    Colors.green[600]!,
                    onSupportPressed,
                  ),
                  const SizedBox(width: 12),
                  _buildActionButton(
                    context,
                    "Training",
                    Icons.school,
                    Colors.purple[600]!,
                    onTrainingPressed,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          splashColor: color.withOpacity(0.1),
          highlightColor: color.withOpacity(0.05),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 20,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: color,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}