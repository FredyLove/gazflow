class DashboardStats {
  final int totalOrders;
  final int completedOrders;
  final int pendingOrders;
  final double totalRevenue;
  final int activeDrivers;
  final int lowStockItems;

  DashboardStats({
    required this.totalOrders,
    required this.completedOrders,
    required this.pendingOrders,
    required this.totalRevenue,
    required this.activeDrivers,
    required this.lowStockItems,
  });
}