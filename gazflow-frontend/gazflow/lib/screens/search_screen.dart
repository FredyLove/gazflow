import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  List<String> searchHistory = [
    '6kg Gas Bottle',
    '12kg Gas Bottle',
    'Emergency delivery',
  ];
  List<String> popularSearches = [
    '6kg bottle',
    '12kg bottle',
    '25kg bottle',
    'Emergency',
    'Schedule delivery',
  ];

  List<Map<String, dynamic>> searchResults = [];
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    setState(() {
      isSearching = true;
    });

    // Simulate API call
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        isSearching = false;
        searchResults = [
          {
            'name': '6kg Gas Bottle',
            'price': 4500,
            'available': true,
            'rating': 4.8,
            'delivery': '30-45 min',
            'description': 'Perfect for small households',
          },
          {
            'name': '12kg Gas Bottle',
            'price': 8500,
            'available': true,
            'rating': 4.9,
            'delivery': '30-45 min',
            'description': 'Most popular choice for families',
          },
          {
            'name': '25kg Gas Bottle',
            'price': 16000,
            'available': false,
            'rating': 4.7,
            'delivery': '1-2 hours',
            'description': 'Commercial use, restaurant grade',
          },
        ];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[600]!, Colors.blue[50]!],
            stops: [0.0, 0.25],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              children: [
                // Search Header
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Search Gas Bottles",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 16),

                      // Search Bar
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _searchController,
                          onSubmitted: _performSearch,
                          decoration: InputDecoration(
                            hintText: "Search for gas bottles, services...",
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.grey[600],
                            ),
                            suffixIcon:
                                _searchController.text.isNotEmpty
                                    ? IconButton(
                                      icon: Icon(
                                        Icons.clear,
                                        color: Colors.grey[600],
                                      ),
                                      onPressed: () {
                                        _searchController.clear();
                                        setState(() {
                                          searchResults.clear();
                                        });
                                      },
                                    )
                                    : null,
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Search Content
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child:
                        searchResults.isEmpty && !isSearching
                            ? _buildSearchSuggestions()
                            : isSearching
                            ? _buildLoadingState()
                            : _buildSearchResults(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchSuggestions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search History
        if (searchHistory.isNotEmpty) ...[
          _buildSectionTitle("Recent Searches"),
          SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                searchHistory
                    .map((term) => _buildSearchChip(term, Icons.history))
                    .toList(),
          ),
          SizedBox(height: 24),
        ],

        // Popular Searches
        _buildSectionTitle("Popular Searches"),
        SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              popularSearches
                  .map((term) => _buildSearchChip(term, Icons.trending_up))
                  .toList(),
        ),
      ],
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: Colors.blue[600]),
          SizedBox(height: 16),
          Text(
            "Searching...",
            style: TextStyle(color: Colors.grey[600], fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final product = searchResults[index];
        return _buildProductCard(product);
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.grey[800],
      ),
    );
  }

  Widget _buildSearchChip(String term, IconData icon) {
    return GestureDetector(
      onTap: () {
        _searchController.text = term;
        _performSearch(term);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: Colors.grey[600]),
            SizedBox(width: 6),
            Text(term, style: TextStyle(color: Colors.grey[700])),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
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
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.propane_tank, color: Colors.blue[600], size: 30),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product['name'],
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  product['description'],
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    Text(
                      "${product['rating']}",
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                    SizedBox(width: 12),
                    Icon(Icons.access_time, color: Colors.grey[500], size: 16),
                    Text(
                      product['delivery'],
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              Text(
                "${product['price']} FCFA",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[600],
                ),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: product['available'] ? () {} : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      product['available']
                          ? Colors.blue[600]
                          : Colors.grey[300],
                  minimumSize: Size(60, 32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  product['available'] ? "Order" : "N/A",
                  style: TextStyle(
                    fontSize: 12,
                    color:
                        product['available'] ? Colors.white : Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
