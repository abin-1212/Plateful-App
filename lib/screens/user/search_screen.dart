import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../../themes/modern_theme.dart';
import '../../widgets/modern/glass_card.dart';
import '../../widgets/modern/modern_button.dart';
import '../../widgets/modern/food_pack_card.dart';
import '../../models/food_pack_model.dart';
import '../../constants/app_constants.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _searchAnimationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _searchFocusNode = FocusNode();
  
  String _searchQuery = '';
  String _selectedCategory = 'All';
  String _selectedSortBy = 'Relevance';
  double _maxPrice = 50.0;
  double _maxDistance = 10.0;
  bool _isVegetarian = false;
  bool _isVegan = false;
  bool _isGlutenFree = false;
  bool _showFilters = false;
  bool _isSearching = false;
  
  // Mock data - replace with real data later
  final List<FoodPack> _allFoodPacks = _generateMockFoodPacks();
  List<FoodPack> _filteredFoodPacks = [];
  List<FoodPack> _searchResults = [];
  
  final List<String> _categories = [
    'All',
    'Bakery',
    'Desserts',
    'Main Course',
    'Appetizers',
    'Beverages',
    'Snacks',
    'Salads',
    'Soups',
  ];
  
  final List<String> _sortOptions = [
    'Relevance',
    'Price: Low to High',
    'Price: High to Low',
    'Distance: Near to Far',
    'Rating: High to Low',
    'Expiry: Soon to Later',
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _searchAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
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
    
    _filteredFoodPacks = _allFoodPacks;
    _searchResults = _allFoodPacks;
    
    _animationController.forward();
    
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchAnimationController.dispose();
    _searchController.dispose();
    _scrollController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim();
    setState(() {
      _searchQuery = query;
      _isSearching = query.isNotEmpty;
    });
    
    if (query.isEmpty) {
      _searchResults = _filteredFoodPacks;
    } else {
      _searchResults = _filteredFoodPacks.where((pack) {
        return pack.title.toLowerCase().contains(query.toLowerCase()) ||
               pack.description.toLowerCase().contains(query.toLowerCase()) ||
               pack.vendorName.toLowerCase().contains(query.toLowerCase()) ||
               pack.category.toLowerCase().contains(query.toLowerCase()) ||
               pack.tags.any((tag) => tag.toLowerCase().contains(query.toLowerCase()));
      }).toList();
    }
  }

  void _applyFilters() {
    setState(() {
      _filteredFoodPacks = _allFoodPacks.where((pack) {
        // Category filter
        if (_selectedCategory != 'All' && pack.category != _selectedCategory) {
          return false;
        }
        
        // Price filter
        if (pack.price > _maxPrice) {
          return false;
        }
        
        // Distance filter
        if (pack.distance > _maxDistance) {
          return false;
        }
        
        // Dietary filters
        if (_isVegetarian && !pack.isVegetarian) {
          return false;
        }
        
        if (_isVegan && !pack.isVegan) {
          return false;
        }
        
        if (_isGlutenFree && !pack.isGlutenFree) {
          return false;
        }
        
        return true;
      }).toList();
      
      // Apply sorting
      _applySorting();
      
      // Update search results
      if (_searchQuery.isEmpty) {
        _searchResults = _filteredFoodPacks;
      } else {
        _onSearchChanged();
      }
    });
  }

  void _applySorting() {
    switch (_selectedSortBy) {
      case 'Price: Low to High':
        _filteredFoodPacks.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Price: High to Low':
        _filteredFoodPacks.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Distance: Near to Far':
        _filteredFoodPacks.sort((a, b) => a.distance.compareTo(b.distance));
        break;
      case 'Rating: High to Low':
        _filteredFoodPacks.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'Expiry: Soon to Later':
        _filteredFoodPacks.sort((a, b) => a.expiryTime.compareTo(b.expiryTime));
        break;
      default:
        // Relevance - keep original order
        break;
    }
  }

  void _toggleFilters() {
    setState(() {
      _showFilters = !_showFilters;
    });
    
    if (_showFilters) {
      _searchAnimationController.forward();
    } else {
      _searchAnimationController.reverse();
    }
  }

  void _clearFilters() {
    setState(() {
      _selectedCategory = 'All';
      _selectedSortBy = 'Relevance';
      _maxPrice = 50.0;
      _maxDistance = 10.0;
      _isVegetarian = false;
      _isVegan = false;
      _isGlutenFree = false;
    });
    _applyFilters();
  }

  void _onFoodPackTap(FoodPack foodPack) {
    Navigator.pushNamed(
      context,
      AppRoutes.packDetail,
      arguments: {'id': foodPack.id},
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    
    return Scaffold(
      backgroundColor: ModernColors.deepGray,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(isMobile),
            if (_showFilters) _buildFiltersPanel(isMobile),
            Expanded(
              child: _buildSearchResults(isMobile),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 24,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        gradient: ModernGradients.darkGradient,
        boxShadow: ModernShadows.cardShadow,
      ),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: ModernColors.textPrimary,
                  size: 24,
                ),
              ),
              Expanded(
                child: _buildSearchBar(isMobile),
              ),
              const SizedBox(width: 12),
              _buildFilterButton(isMobile),
            ],
          ),
          if (_searchQuery.isNotEmpty) ...[
            const SizedBox(height: 12),
            _buildSearchStats(isMobile),
          ],
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.3, end: 0);
  }

  Widget _buildSearchBar(bool isMobile) {
    return GlassCard(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Icon(
              Icons.search,
              color: ModernColors.textSecondary,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: _searchController,
                focusNode: _searchFocusNode,
                style: GoogleFonts.poppins(
                  color: ModernColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: 'Search food packs, vendors, or categories...',
                  hintStyle: GoogleFonts.poppins(
                    color: ModernColors.textTertiary,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                onSubmitted: (value) {
                  _searchFocusNode.unfocus();
                },
              ),
            ),
            if (_searchQuery.isNotEmpty)
              IconButton(
                onPressed: () {
                  _searchController.clear();
                  _searchFocusNode.unfocus();
                },
                icon: Icon(
                  Icons.clear,
                  color: ModernColors.textSecondary,
                  size: 20,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(bool isMobile) {
    return GlassCard(
      child: IconButton(
        onPressed: _toggleFilters,
        icon: Icon(
          _showFilters ? Icons.tune : Icons.filter_list,
          color: _showFilters ? ModernColors.electricBlue : ModernColors.textSecondary,
          size: 24,
        ),
      ),
    );
  }

  Widget _buildSearchStats(bool isMobile) {
    return Row(
      children: [
        Icon(
          Icons.search,
          color: ModernColors.electricBlue,
          size: 16,
        ),
        const SizedBox(width: 8),
        Text(
          '${_searchResults.length} results for "$_searchQuery"',
          style: GoogleFonts.poppins(
            color: ModernColors.textSecondary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        if (_searchResults.isNotEmpty)
          TextButton(
            onPressed: _clearFilters,
            child: Text(
              'Clear filters',
              style: GoogleFonts.poppins(
                color: ModernColors.electricBlue,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildFiltersPanel(bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 24,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: ModernColors.darkGray,
        border: Border(
          bottom: BorderSide(
            color: ModernColors.lightGray,
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Filters',
                style: GoogleFonts.poppins(
                  color: ModernColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: _clearFilters,
                child: Text(
                  'Clear all',
                  style: GoogleFonts.poppins(
                    color: ModernColors.electricBlue,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Category filter
          _buildFilterSection(
            'Category',
            _buildCategoryFilter(),
          ),
          
          const SizedBox(height: 16),
          
          // Sort by filter
          _buildFilterSection(
            'Sort by',
            _buildSortFilter(),
          ),
          
          const SizedBox(height: 16),
          
          // Price range filter
          _buildFilterSection(
            'Max Price: \$${_maxPrice.toStringAsFixed(0)}',
            _buildPriceFilter(),
          ),
          
          const SizedBox(height: 16),
          
          // Distance filter
          _buildFilterSection(
            'Max Distance: ${_maxDistance.toStringAsFixed(1)} km',
            _buildDistanceFilter(),
          ),
          
          const SizedBox(height: 16),
          
          // Dietary filters
          _buildFilterSection(
            'Dietary Preferences',
            _buildDietaryFilters(),
          ),
          
          const SizedBox(height: 16),
          
          // Apply filters button
          SizedBox(
            width: double.infinity,
            child: ModernButton(
              text: 'Apply Filters',
              onPressed: () {
                _applyFilters();
                _toggleFilters();
              },
              gradient: ModernGradients.primaryGradient,
            ),
          ),
        ],
      ),
    ).animate().slideY(begin: -0.5, end: 0, curve: Curves.easeOutCubic);
  }

  Widget _buildFilterSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            color: ModernColors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        content,
      ],
    );
  }

  Widget _buildCategoryFilter() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _categories.map((category) {
        final isSelected = _selectedCategory == category;
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedCategory = category;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              gradient: isSelected ? ModernGradients.primaryGradient : null,
              color: isSelected ? null : ModernColors.mediumGray,
              borderRadius: BorderRadius.circular(20),
              border: isSelected ? null : Border.all(
                color: ModernColors.lightGray,
                width: 1,
              ),
            ),
            child: Text(
              category,
              style: GoogleFonts.poppins(
                color: isSelected ? ModernColors.textPrimary : ModernColors.textSecondary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSortFilter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: ModernColors.mediumGray,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: ModernColors.lightGray,
          width: 1,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedSortBy,
          dropdownColor: ModernColors.mediumGray,
          style: GoogleFonts.poppins(
            color: ModernColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          items: _sortOptions.map((option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() {
                _selectedSortBy = value;
              });
            }
          },
        ),
      ),
    );
  }

  Widget _buildPriceFilter() {
    return Column(
      children: [
        Slider(
          value: _maxPrice,
          min: 5.0,
          max: 100.0,
          divisions: 19,
          activeColor: ModernColors.electricBlue,
          inactiveColor: ModernColors.lightGray,
          onChanged: (value) {
            setState(() {
              _maxPrice = value;
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '\$5',
              style: GoogleFonts.poppins(
                color: ModernColors.textSecondary,
                fontSize: 12,
              ),
            ),
            Text(
              '\$100',
              style: GoogleFonts.poppins(
                color: ModernColors.textSecondary,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDistanceFilter() {
    return Column(
      children: [
        Slider(
          value: _maxDistance,
          min: 1.0,
          max: 20.0,
          divisions: 19,
          activeColor: ModernColors.electricBlue,
          inactiveColor: ModernColors.lightGray,
          onChanged: (value) {
            setState(() {
              _maxDistance = value;
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '1 km',
              style: GoogleFonts.poppins(
                color: ModernColors.textSecondary,
                fontSize: 12,
              ),
            ),
            Text(
              '20 km',
              style: GoogleFonts.poppins(
                color: ModernColors.textSecondary,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDietaryFilters() {
    return Column(
      children: [
        _buildDietaryOption('Vegetarian', _isVegetarian, (bool? value) {
          setState(() {
            _isVegetarian = value ?? false;
          });
        }),
        const SizedBox(height: 8),
        _buildDietaryOption('Vegan', _isVegan, (bool? value) {
          setState(() {
            _isVegan = value ?? false;
          });
        }),
        const SizedBox(height: 8),
        _buildDietaryOption('Gluten Free', _isGlutenFree, (bool? value) {
          setState(() {
            _isGlutenFree = value ?? false;
          });
        }),
      ],
    );
  }

  Widget _buildDietaryOption(String label, bool value, Function(bool?) onChanged) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: ModernColors.electricBlue,
          checkColor: ModernColors.textPrimary,
          side: BorderSide(
            color: ModernColors.lightGray,
            width: 1,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
            color: ModernColors.textSecondary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchResults(bool isMobile) {
    if (_isSearching && _searchResults.isEmpty) {
      return _buildEmptyState(
        'No results found',
        'Try adjusting your search terms or filters',
        Icons.search_off,
      );
    }

    if (_searchResults.isEmpty) {
      return _buildEmptyState(
        'Start searching',
        'Search for food packs, vendors, or categories',
        Icons.search,
      );
    }

    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 24,
        vertical: 16,
      ),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final foodPack = _searchResults[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: FoodPackCard(
            foodPack: foodPack,
            onTap: () => _onFoodPackTap(foodPack),
          ).animate().fadeIn(
            delay: Duration(milliseconds: index * 100),
            duration: 400.ms,
          ).slideX(
            begin: 0.3,
            end: 0,
            delay: Duration(milliseconds: index * 100),
            duration: 400.ms,
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(String title, String subtitle, IconData icon) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              gradient: ModernGradients.glassGradient,
              borderRadius: BorderRadius.circular(60),
              boxShadow: ModernShadows.glassShadow,
            ),
            child: Icon(
              icon,
              size: 60,
              color: ModernColors.textSecondary,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: GoogleFonts.poppins(
              color: ModernColors.textPrimary,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: GoogleFonts.poppins(
              color: ModernColors.textSecondary,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// Mock data generation function
List<FoodPack> _generateMockFoodPacks() {
  return [
    FoodPack(
      id: '1',
      vendorId: 'vendor1',
      vendorName: 'Sweet Delights Bakery',
      title: 'Artisan Bread Collection',
      description: 'Freshly baked artisan breads including sourdough, ciabatta, and whole grain.',
      images: ['https://example.com/bread1.jpg'],
      category: 'Bakery',
      price: 12.99,
      originalPrice: 18.99,
      quantity: 10,
      reservedQuantity: 2,
      expiryTime: DateTime.now().add(const Duration(hours: 4)),
      pickupStartTime: DateTime.now(),
      pickupEndTime: DateTime.now().add(const Duration(hours: 6)),
      location: {'lat': 40.7128, 'lng': -74.0060},
      distance: 2.5,
      rating: 4.8,
      reviewCount: 127,
      ingredients: ['Flour', 'Water', 'Salt', 'Yeast'],
      nutritionalInfo: {'calories': 250, 'protein': 8, 'carbs': 45, 'fat': 2},
      isHygieneCertified: true,
      hygieneScore: 4.9,
      allergens: ['Gluten'],
      isVegetarian: true,
      isVegan: false,
      isGlutenFree: false,
      status: 'available',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      updatedAt: DateTime.now(),
      tags: ['Fresh', 'Artisan', 'Bread'],
    ),
    FoodPack(
      id: '2',
      vendorId: 'vendor2',
      vendorName: 'Green Garden Cafe',
      title: 'Vegan Buddha Bowl',
      description: 'Nutritious vegan bowl with quinoa, roasted vegetables, and tahini dressing.',
      images: ['https://example.com/bowl1.jpg'],
      category: 'Main Course',
      price: 15.99,
      originalPrice: 22.99,
      quantity: 8,
      reservedQuantity: 1,
      expiryTime: DateTime.now().add(const Duration(hours: 3)),
      pickupStartTime: DateTime.now(),
      pickupEndTime: DateTime.now().add(const Duration(hours: 5)),
      location: {'lat': 40.7589, 'lng': -73.9851},
      distance: 1.8,
      rating: 4.6,
      reviewCount: 89,
      ingredients: ['Quinoa', 'Sweet Potato', 'Kale', 'Chickpeas', 'Tahini'],
      nutritionalInfo: {'calories': 420, 'protein': 15, 'carbs': 65, 'fat': 12},
      isHygieneCertified: true,
      hygieneScore: 4.7,
      allergens: ['Nuts'],
      isVegetarian: true,
      isVegan: true,
      isGlutenFree: true,
      status: 'available',
      createdAt: DateTime.now().subtract(const Duration(hours: 1)),
      updatedAt: DateTime.now(),
      tags: ['Vegan', 'Healthy', 'Buddha Bowl'],
    ),
    FoodPack(
      id: '3',
      vendorId: 'vendor3',
      vendorName: 'Dessert Paradise',
      title: 'Chocolate Lava Cake',
      description: 'Warm chocolate lava cake with vanilla ice cream and fresh berries.',
      images: ['https://example.com/cake1.jpg'],
      category: 'Desserts',
      price: 8.99,
      originalPrice: 14.99,
      quantity: 15,
      reservedQuantity: 3,
      expiryTime: DateTime.now().add(const Duration(hours: 2)),
      pickupStartTime: DateTime.now(),
      pickupEndTime: DateTime.now().add(const Duration(hours: 4)),
      location: {'lat': 40.7505, 'lng': -73.9934},
      distance: 3.2,
      rating: 4.9,
      reviewCount: 203,
      ingredients: ['Dark Chocolate', 'Butter', 'Eggs', 'Sugar', 'Flour'],
      nutritionalInfo: {'calories': 380, 'protein': 6, 'carbs': 45, 'fat': 22},
      isHygieneCertified: true,
      hygieneScore: 4.8,
      allergens: ['Gluten', 'Eggs', 'Dairy'],
      isVegetarian: true,
      isVegan: false,
      isGlutenFree: false,
      status: 'available',
      createdAt: DateTime.now().subtract(const Duration(hours: 30)),
      updatedAt: DateTime.now(),
      tags: ['Chocolate', 'Dessert', 'Lava Cake'],
    ),
  ];
} 