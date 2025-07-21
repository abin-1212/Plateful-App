import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../themes/modern_theme.dart';
import '../../widgets/modern/glass_card.dart';
import '../../widgets/modern/modern_button.dart';
import '../../widgets/modern/food_pack_card.dart';
import '../../models/food_pack_model.dart';
import '../../constants/app_constants.dart';
import 'package:provider/provider.dart';

class ThemeModeNotifier extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;
  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }
}

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  
  String _selectedCategory = 'All';
  bool _isSearching = false;
  bool _showFilters = false;
  
  // Mock data - replace with real data later
  final List<FoodPack> _foodPacks = _generateMockFoodPacks();
  final List<FoodPack> _recommendations = _generateMockRecommendations();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _slideAnimation = Tween<double>(
      begin: 50.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    setState(() {
      _isSearching = value.isNotEmpty;
    });
  }

  void _toggleFilters() {
    setState(() {
      _showFilters = !_showFilters;
    });
  }

  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  void _onFoodPackTap(FoodPack foodPack) {
    Navigator.pushNamed(
      context,
      AppRoutes.packDetail,
      arguments: {'id': foodPack.id},
    );
  }

  void _onFavoriteToggle(FoodPack foodPack) {
    // TODO: Implement favorite toggle logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${foodPack.title} ${foodPack.isFavorite ? 'removed from' : 'added to'} favorites'),
        backgroundColor: ModernColors.success,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Dashboard'),
        actions: [
          PopupMenuButton<ThemeMode>(
            icon: const Icon(Icons.brightness_6),
            onSelected: (mode) {
              Provider.of<ThemeModeNotifier>(context, listen: false).setThemeMode(mode);
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: ThemeMode.system,
                child: Row(
                  children: [
                    Icon(Icons.settings, color: Theme.of(context).iconTheme.color),
                    const SizedBox(width: 8),
                    const Text('System'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: ThemeMode.light,
                child: Row(
                  children: [
                    Icon(Icons.light_mode, color: Theme.of(context).iconTheme.color),
                    const SizedBox(width: 8),
                    const Text('Light'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: ThemeMode.dark,
                child: Row(
                  children: [
                    Icon(Icons.dark_mode, color: Theme.of(context).iconTheme.color),
                    const SizedBox(width: 8),
                    const Text('Dark'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: ModernGradients.darkGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              _buildHeader(),
              
              // Search and filters
              _buildSearchSection(),
              
              // Main content
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    // TODO: Implement refresh logic
                    await Future.delayed(const Duration(seconds: 1));
                  },
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(ModernSpacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // AI Recommendations
                        _buildRecommendationsSection(),
                        
                        const SizedBox(height: ModernSpacing.xxl),
                        
                        // Categories
                        _buildCategoriesSection(),
                        
                        const SizedBox(height: ModernSpacing.xxl),
                        
                        // Food packs grid
                        _buildFoodPacksSection(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // Bottom navigation
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildHeader() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _slideAnimation.value),
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: Padding(
              padding: const EdgeInsets.all(ModernSpacing.lg),
              child: Row(
                children: [
                  // User avatar
                  GlassCard(
                    width: 50,
                    height: 50,
                    borderRadius: BorderRadius.circular(ModernBorderRadius.full),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(ModernBorderRadius.full),
                        gradient: ModernGradients.primaryGradient,
                      ),
                      child: const Icon(
                        Icons.person,
                        color: ModernColors.textPrimary,
                        size: 24,
                      ),
                    ),
                  ),
                  
                  const SizedBox(width: ModernSpacing.md),
                  
                  // Welcome text
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome back!',
                          style: ModernTextStyles.bodyMedium.copyWith(
                            color: ModernColors.textSecondary,
                          ),
                        ),
                        Text(
                          'John Doe',
                          style: ModernTextStyles.headlineSmall,
                        ),
                      ],
                    ),
                  ),
                  
                  // Notifications
                  GlassCard(
                    width: 50,
                    height: 50,
                    borderRadius: BorderRadius.circular(ModernBorderRadius.full),
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.notifications);
                    },
                    child: Stack(
                      children: [
                        const Icon(
                          Icons.notifications_outlined,
                          color: ModernColors.textPrimary,
                          size: 24,
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: ModernColors.error,
                              borderRadius: BorderRadius.circular(ModernBorderRadius.full),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearchSection() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: ModernSpacing.lg),
            child: Column(
              children: [
                // Search bar
                GlassCard(
                  padding: const EdgeInsets.symmetric(horizontal: ModernSpacing.md),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.search,
                        color: ModernColors.textSecondary,
                        size: 24,
                      ),
                      const SizedBox(width: ModernSpacing.md),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          onChanged: _onSearchChanged,
                          style: ModernTextStyles.bodyLarge,
                          decoration: const InputDecoration(
                            hintText: 'Search for food...',
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: ModernColors.textTertiary),
                          ),
                        ),
                      ),
                      if (_isSearching)
                        IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            _onSearchChanged('');
                          },
                        ),
                      IconButton(
                        icon: const Icon(Icons.tune),
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.search);
                        },
                        tooltip: 'Advanced Search',
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: ModernSpacing.md),
                
                // Filter toggle
                Row(
                  children: [
                    ModernOutlinedButton(
                      text: _showFilters ? 'Hide Filters' : 'Show Filters',
                      onPressed: _toggleFilters,
                      icon: _showFilters ? Icons.keyboard_arrow_up : Icons.filter_list,
                    ),
                    const Spacer(),
                    Text(
                      '${_foodPacks.length} items available',
                      style: ModernTextStyles.bodySmall.copyWith(
                        color: ModernColors.textTertiary,
                      ),
                    ),
                  ],
                ),
                
                // Filters
                if (_showFilters)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.only(top: ModernSpacing.md),
                    child: GlassCard(
                      padding: const EdgeInsets.all(ModernSpacing.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Filters',
                            style: ModernTextStyles.titleMedium,
                          ),
                          const SizedBox(height: ModernSpacing.md),
                          // Add filter options here
                          Row(
                            children: [
                              _buildFilterChip('Price: Low to High', true),
                              const SizedBox(width: ModernSpacing.sm),
                              _buildFilterChip('Distance', false),
                              const SizedBox(width: ModernSpacing.sm),
                              _buildFilterChip('Rating', false),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        // TODO: Implement filter logic
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: ModernSpacing.md,
          vertical: ModernSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: isSelected ? ModernColors.electricBlue.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(ModernBorderRadius.lg),
          border: Border.all(
            color: isSelected ? ModernColors.electricBlue : ModernColors.textTertiary,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: ModernTextStyles.labelSmall.copyWith(
            color: isSelected ? ModernColors.electricBlue : ModernColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildRecommendationsSection() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _slideAnimation.value),
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.psychology,
                      color: ModernColors.mintGreen,
                      size: 24,
                    ),
                    const SizedBox(width: ModernSpacing.sm),
                    Text(
                      'AI Recommendations',
                      style: ModernTextStyles.headlineMedium.copyWith(
                        color: ModernColors.mintGreen,
                      ),
                    ),
                    const Spacer(),
                    ModernTextButton(
                      text: 'View All',
                      onPressed: () {
                        // TODO: Navigate to recommendations page
                      },
                      textColor: ModernColors.mintGreen,
                    ),
                  ],
                ),
                
                const SizedBox(height: ModernSpacing.lg),
                
                SizedBox(
                  height: 400,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _recommendations.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                          right: index < _recommendations.length - 1 ? ModernSpacing.md : 0,
                        ),
                        child: FoodPackCard(
                          foodPack: _recommendations[index],
                          onTap: () => _onFoodPackTap(_recommendations[index]),
                          onFavorite: () => _onFavoriteToggle(_recommendations[index]),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCategoriesSection() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Categories',
                style: ModernTextStyles.headlineMedium,
              ),
              
              const SizedBox(height: ModernSpacing.lg),
              
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: FoodCategories.categories.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return _buildCategoryCard('All', Icons.all_inclusive, ModernColors.electricBlue, true);
                    }
                    final category = FoodCategories.categories[index - 1];
                    final icon = FoodCategories.categoryIcons[category] ?? '🍽️';
                    final isSelected = _selectedCategory == category;
                    return _buildCategoryCard(category, Icons.restaurant, ModernColors.neonPurple, isSelected);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCategoryCard(String title, IconData icon, Color color, bool isSelected) {
    return GestureDetector(
      onTap: () => _onCategorySelected(title),
      child: Container(
        width: 100,
        margin: EdgeInsets.only(
          right: title != 'All' ? ModernSpacing.md : 0,
        ),
        child: GlassCard(
          borderRadius: BorderRadius.circular(ModernBorderRadius.lg),
          borderColor: isSelected ? color : Colors.transparent,
          borderWidth: isSelected ? 2.0 : 1.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? color : ModernColors.textSecondary,
                size: 32,
              ),
              const SizedBox(height: ModernSpacing.sm),
              Text(
                title,
                style: ModernTextStyles.labelMedium.copyWith(
                  color: isSelected ? color : ModernColors.textSecondary,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFoodPacksSection() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Available Food Packs',
                style: ModernTextStyles.headlineMedium,
              ),
              
              const SizedBox(height: ModernSpacing.lg),
              
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: ModernSpacing.md,
                  mainAxisSpacing: ModernSpacing.md,
                ),
                itemCount: _foodPacks.length,
                itemBuilder: (context, index) {
                  return FoodPackCard(
                    foodPack: _foodPacks[index],
                    onTap: () => _onFoodPackTap(_foodPacks[index]),
                    onFavorite: () => _onFavoriteToggle(_foodPacks[index]),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomNavigation() {
    return GlassCard(
      margin: EdgeInsets.zero,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(ModernBorderRadius.lg),
        topRight: Radius.circular(ModernBorderRadius.lg),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: ModernColors.electricBlue,
        unselectedItemColor: ModernColors.textSecondary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0: // Home
              Navigator.pushReplacementNamed(context, AppRoutes.userDashboard);
              break;
            case 1: // Search
              Navigator.pushNamed(context, AppRoutes.search);
              break;
            case 2: // Favorites
              Navigator.pushNamed(context, AppRoutes.favorites);
              break;
            case 3: // Orders
              Navigator.pushNamed(context, AppRoutes.orders);
              break;
            case 4: // Profile
              Navigator.pushNamed(context, AppRoutes.profile);
              break;
          }
        },
      ),
    );
  }
}

// Mock data generators
List<FoodPack> _generateMockFoodPacks() {
  return [
    FoodPack(
      id: '1',
      vendorId: 'v1',
      vendorName: 'Tasty Bites',
      title: 'Fresh Pasta Carbonara',
      description: 'Delicious homemade pasta with creamy carbonara sauce',
      images: ['https://example.com/pasta.jpg'],
      category: 'Italian',
      price: 8.99,
      originalPrice: 18.99,
      quantity: 5,
      reservedQuantity: 2,
      expiryTime: DateTime.now().add(const Duration(hours: 2)),
      pickupStartTime: DateTime.now(),
      pickupEndTime: DateTime.now().add(const Duration(hours: 3)),
      location: {'lat': 37.7749, 'lng': -122.4194},
      distance: 1.2,
      rating: 4.8,
      reviewCount: 45,
      ingredients: ['Pasta', 'Eggs', 'Parmesan', 'Bacon'],
      nutritionalInfo: {'calories': 450, 'protein': 15},
      isHygieneCertified: true,
      hygieneScore: 9.2,
      allergens: ['Gluten', 'Dairy'],
      isVegetarian: false,
      isVegan: false,
      isGlutenFree: false,
      status: 'available',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      tags: ['Italian', 'Pasta', 'Creamy'],
    ),
    // Add more mock food packs...
  ];
}

List<FoodPack> _generateMockRecommendations() {
  return [
    FoodPack(
      id: 'rec1',
      vendorId: 'v2',
      vendorName: 'Green Garden',
      title: 'Organic Salad Bowl',
      description: 'Fresh organic vegetables with house dressing',
      images: ['https://example.com/salad.jpg'],
      category: 'Salads',
      price: 6.99,
      originalPrice: 12.99,
      quantity: 8,
      reservedQuantity: 1,
      expiryTime: DateTime.now().add(const Duration(hours: 4)),
      pickupStartTime: DateTime.now(),
      pickupEndTime: DateTime.now().add(const Duration(hours: 5)),
      location: {'lat': 37.7749, 'lng': -122.4194},
      distance: 0.8,
      rating: 4.9,
      reviewCount: 67,
      ingredients: ['Lettuce', 'Tomatoes', 'Cucumber', 'Avocado'],
      nutritionalInfo: {'calories': 180, 'protein': 8},
      isHygieneCertified: true,
      hygieneScore: 9.5,
      allergens: [],
      isVegetarian: true,
      isVegan: true,
      isGlutenFree: true,
      status: 'available',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      tags: ['Organic', 'Vegan', 'Healthy'],
    ),
    // Add more recommendations...
  ];
} 