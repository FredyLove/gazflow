import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/active_order_card.dart';
import '../widgets/quick_action_section.dart';
import '../widgets/gaz_bottles_section.dart';
import '../widgets/recent_order_section.dart';

class CustomerHomeContent extends StatefulWidget {
  const CustomerHomeContent({super.key});

  @override
  State<CustomerHomeContent> createState() => _CustomerHomeContentState();
}

class _CustomerHomeContentState extends State<CustomerHomeContent>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // User data
  String userName = "John Doe";
  String currentAddress = "Yaoundé, Centre";
  bool hasActiveOrder = true;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeIn));

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue[600]!, Colors.blue[50]!],
          stops: [0.0, 0.3],
        ),
      ),
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Custom App Bar
            CustomAppBarWidget(
              userName: userName,
              currentAddress: currentAddress,
              fadeAnimation: _fadeAnimation,
              onNotificationPressed: () {
                // Handle notifications
              },
            ),

            // Main Content
            SliverToBoxAdapter(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Active Order Card
                        if (hasActiveOrder) ...[
                          ActiveOrderCard(
                            orderId: "GF001235",
                            status: "On the way",
                            progress: 0.7,
                            estimatedTime: "15 mins",
                            onTrackPressed: () {
                              // Navigate to tracking screen
                            },
                          ),
                          SizedBox(height: 24),
                        ],

                        // Quick Actions
                        QuickActionsSection(
                          onOrderNowPressed: () {
                            // Navigate to order screen
                          },
                          onSchedulePressed: () {
                            // Navigate to schedule screen
                          },
                          onSupportPressed: () {
                            // Navigate to support screen
                          },
                        ),
                        SizedBox(height: 24),

                        // Gas Bottles Section
                        GasBottlesSection(
                          onViewAllPressed: () {
                            // Navigate to all products
                          },
                          onBottleOrderPressed: (bottleData) {
                            // Handle individual bottle order
                          },
                        ),
                        SizedBox(height: 24),

                        // Recent Orders Section
                        RecentOrdersSection(
                          onViewAllPressed: () {
                            // Navigate to order history
                          },
                          onOrderPressed: (orderId) {
                            // Navigate to order details
                          },
                        ),
                      ],
                    ),
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
