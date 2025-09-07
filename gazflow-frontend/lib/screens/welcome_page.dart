import 'package:flutter/material.dart';
import 'login_screen.dart';

const String baseURL = 'http://192.168.5.1:8000';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _staggerController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _staggerAnimation;

  final List<Map<String, String>> products = [
    {
      'title': '6kg Gas Bottle',
      'description': 'Perfect for camping',
      'image_path': 'assets/images/1.png',
      'price': '4,500 XAF',
      'capacity': '6 kg',
    },
    {
      'title': '12.5kg Bottle',
      'description': 'Family cooking',
      'image_path': 'assets/images/2.png',
      'price': '8,900 XAF',
      'capacity': '12.5 kg',
    },
    {
      'title': '50kg Gas Bottle',
      'description': 'Industrial use',
      'image_path': 'assets/images/3.png',
      'price': '32,000 XAF',
      'capacity': '50 kg',
    },
  ];

  final List<Map<String, String>> locations = [
    {
      'name': 'Total Station', 
      'address': 'Awae-Escalier',
      'distance': '2.3 km',
      'rating': '4.5'
    },
    {
      'name': 'Ax Oil', 
      'address': 'Ebang, Nkometou',
      'distance': '3.1 km',
      'rating': '4.2'
    },
    {
      'name': 'Carriere Depot', 
      'address': 'Awae, Ekie',
      'distance': '5.7 km',
      'rating': '4.7'
    },
    {
      'name': 'Messasi Depot', 
      'address': 'Messasi, Yaounde',
      'distance': '4.2 km',
      'rating': '4.3'
    },
  ];

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _staggerController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeInOutQuart),
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutBack,
    ));

    _staggerAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _staggerController,
      curve: Curves.easeInOut,
    ));

    // Start animations sequentially
    Future.delayed(const Duration(milliseconds: 300), () {
      _fadeController.forward();
      _slideController.forward();
      _staggerController.forward();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _staggerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenHeight < 700;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue[800]!,
              Colors.blue[600]!,
              Colors.blue[400]!,
            ],
            stops: const [0.0, 0.6, 1.0],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: isSmallScreen ? 16 : 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Header Section
                  _buildHeaderSection(isSmallScreen),
                  
                  SizedBox(height: isSmallScreen ? 24 : 32),

                  // Gas Bottles Section
                  _buildProductsSection(isSmallScreen),
                  
                  SizedBox(height: isSmallScreen ? 24 : 32),

                  // Storage Locations Section
                  _buildLocationsSection(isSmallScreen),
                  
                  SizedBox(height: isSmallScreen ? 24 : 32),

                  // Get Started Button
                  _buildGetStartedButton(),
                  
                  SizedBox(height: isSmallScreen ? 20 : 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection(bool isSmallScreen) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Column(
          children: [
            // Animated Logo Container
            Hero(
              tag: 'app-logo',
              child: Container(
                padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Colors.white, Colors.blue[100]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 25,
                      spreadRadius: 2,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.local_gas_station_rounded,
                  size: 60,
                  color: Colors.blue,
                ),
              ),
            ),
            
            SizedBox(height: isSmallScreen ? 16 : 20),
            
            // Title
            Text(
              "Welcome to GazFlow",
              style: TextStyle(
                color: Colors.white,
                fontSize: isSmallScreen ? 26 : 32,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
              textAlign: TextAlign.center,
            ),
            
            SizedBox(height: isSmallScreen ? 8 : 12),
            
            // Subtitle
            Text(
              "Discover premium gas bottles and nearby stations",
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: isSmallScreen ? 14 : 16,
                fontWeight: FontWeight.w400,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductsSection(bool isSmallScreen) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Popular Gas Bottles",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isSmallScreen ? 18 : 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "View All",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: isSmallScreen ? 12 : 16),
            
            // Products Grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: isSmallScreen ? 0.8 : 0.85,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: _staggerController,
                  builder: (context, child) {
                    final animationValue = _staggerAnimation.value;
                    final itemDelay = index * 0.2;
                    
                    final opacity = animationValue > itemDelay 
                        ? (animationValue - itemDelay) * 3 
                        : 0.0;
                    
                    return Transform.translate(
                      offset: Offset(0, (1 - animationValue) * 50 * (1 - itemDelay)),
                      child: Opacity(
                        opacity: opacity.clamp(0.0, 1.0),
                        child: child,
                      ),
                    );
                  },
                  child: ProductCard(
                    product: products[index],
                    onTap: () => _onProductTap(products[index]),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationsSection(bool isSmallScreen) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Nearby Locations",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isSmallScreen ? 18 : 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.my_location, color: Colors.white.withOpacity(0.8)),
                  onPressed: _refreshLocations,
                ),
              ],
            ),
            
            SizedBox(height: isSmallScreen ? 12 : 16),
            
            // Locations List
            Column(
              children: List.generate(locations.length, (index) {
                return AnimatedBuilder(
                  animation: _staggerController,
                  builder: (context, child) {
                    final animationValue = _staggerAnimation.value;
                    final itemDelay = 0.6 + index * 0.15;
                    
                    final opacity = animationValue > itemDelay 
                        ? (animationValue - itemDelay) * 3 
                        : 0.0;
                    
                    return Transform.translate(
                      offset: Offset(0, (1 - animationValue) * 30 * (1 - itemDelay)),
                      child: Opacity(
                        opacity: opacity.clamp(0.0, 1.0),
                        child: child,
                      ),
                    );
                  },
                  child: LocationCard(
                    location: locations[index],
                    onTap: () => _onLocationTap(locations[index]),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGetStartedButton() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: AnimatedBuilder(
          animation: _staggerController,
          builder: (context, child) {
            final opacity = _staggerAnimation.value.clamp(0.0, 1.0);
            return Transform.translate(
              offset: Offset(0, (1 - _staggerAnimation.value) * 40),
              child: Opacity(
                opacity: opacity,
                child: child,
              ),
            );
          },
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [Colors.white, Colors.blue[100]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: _navigateToLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 32),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Get Started",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue[800],
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.blue[800],
                    size: 24,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onProductTap(Map<String, String> product) {
    print('Product tapped: ${product['title']}');
  }

  void _onLocationTap(Map<String, String> location) {
    print('Location tapped: ${location['name']}');
  }

  void _refreshLocations() {
    print('Refreshing locations...');
  }

  void _navigateToLogin() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const LoginScreen(),
        transitionsBuilder: (_, animation, __, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOutQuart,
            )),
            child: FadeTransition(opacity: animation, child: child),
          );
        },
        transitionDuration: const Duration(milliseconds: 600),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Map<String, String> product;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Product Image
                  Expanded(
                    flex: 3,
                    child: Container(
                      color: Colors.white.withOpacity(0.1),
                      child: Image.asset(
                        product['image_path']!,
                        fit: BoxFit.contain,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Icon(
                              Icons.error_outline,
                              color: Colors.white.withOpacity(0.5),
                              size: 40,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  
                  // Product Info - FIXED OVERFLOW
                  Container(
                    padding: const EdgeInsets.all(12),
                    constraints: const BoxConstraints(
                      minHeight: 80,
                      maxHeight: 100,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Title
                        Text(
                          product['title']!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        
                        const SizedBox(height: 4),
                        
                        // Description
                        Text(
                          product['description']!,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 11,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        
                        const SizedBox(height: 6),
                        
                        // Price and Capacity
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                product['price']!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                product['capacity']!,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 11,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              // Favorite Button
              Positioned(
                top: 8,
                right: 8,
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.white.withOpacity(0.2),
                  child: Icon(
                    Icons.favorite_border,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LocationCard extends StatelessWidget {
  final Map<String, String> location;
  final VoidCallback onTap;

  const LocationCard({
    super.key,
    required this.location,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            // Location Icon
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
              ),
              child: Icon(
                Icons.location_on_rounded,
                color: Colors.white.withOpacity(0.9),
                size: 24,
              ),
            ),
            
            const SizedBox(width: 16),
            
            // Location Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    location['name']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: 4),
                  
                  Text(
                    location['address']!,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 13,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: 6),
                  
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        location['rating']!,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 12,
                        ),
                      ),
                      
                      const SizedBox(width: 16),
                      
                      Icon(
                        Icons.directions,
                        color: Colors.white.withOpacity(0.7),
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        location['distance']!,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Navigation Icon
            Icon(
              Icons.chevron_right,
              color: Colors.white.withOpacity(0.6),
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}