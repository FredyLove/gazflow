import 'package:flutter/material.dart';
import 'package:gazflow/features/admin_dashboard/widgets/dashboard_header.dart';
import 'package:gazflow/features/admin_dashboard/widgets/stats_card.dart';
import 'package:gazflow/features/admin_dashboard/widgets/quick_actions.dart';
import 'package:gazflow/features/admin_dashboard/widgets/recent_activities.dart';
import 'package:gazflow/features/admin_dashboard/models/dashboard_stats.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  final DashboardStats stats = DashboardStats(
    totalOrders: 342,
    completedOrders: 289,
    pendingOrders: 53,
    totalRevenue: 12500000,
    activeDrivers: 12,
    lowStockItems: 4,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const DashboardHeader(),
              const SizedBox(height: 24),
              StatsCard(stats: stats),
              const SizedBox(height: 24),
              const QuickActions(),
              const SizedBox(height: 24),
              const RecentActivities(),
            ],
          ),
        ),
      ),
    );
  }
}