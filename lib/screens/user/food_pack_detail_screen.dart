import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../themes/modern_theme.dart';
import '../../widgets/modern/glass_card.dart';
import '../../widgets/modern/modern_button.dart';
import '../../models/food_pack_model.dart';
import '../../constants/app_constants.dart';

class FoodPackDetailScreen extends StatefulWidget {
  final String packId;
  
  const FoodPackDetailScreen({
    super.key,
    required this.packId,
  });

  @override
  State<FoodPackDetailScreen> createState() => _FoodPackDetailScreenState();
}

class _FoodPackDetailScreenState extends State<FoodPackDetailScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  
  int _currentImageIndex = 0;
  int _selectedQuantity = 1;
  bool _isFavorite = false;
  bool _showQRCode = false;
  
  // Mock data - replace with real data later
  late FoodPack _foodPack;

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
    
    // Load food pack data
    _foodPack = _loadFoodPackData();
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  FoodPack _loadFoodPackData() {
    // TODO: Replace with real API call
    return FoodPack(
      id: widget.packId,
      vendorId: 'v1',
      vendorName: 'Tasty Bites Restaurant',
      title: 'Fresh Pasta Carbonara',
      description: 'Delicious homemade pasta with creamy carbonara sauce, made with fresh eggs, parmesan cheese, and crispy pancetta. This authentic Italian dish is prepared fresh daily and served at the perfect temperature.',
      images: [
        'https://example.com/pasta1.jpg',
        'https://example.com/pasta2.jpg',
        'https://example.com/pasta3.jpg',
      ],
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
      ingredients: ['Fresh Pasta', 'Eggs', 'Parmesan Cheese', 'Pancetta', 'Black Pepper', 'Olive Oil'],
      nutritionalInfo: {
        'calories': 450,
        'protein': 15,
        'carbs': 65,
        'fat': 12,
        'fiber': 3,
      },
      isHygieneCertified: true,
      hygieneScore: 9.2,
      allergens: ['Gluten', 'Dairy', 'Eggs'],
      isVegetarian: false,
      isVegan: false,
      isGlutenFree: false,
      status: 'available',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      tags: ['Italian', 'Pasta', 'Creamy', 'Fresh'],
    );
  }

  void _onImageChanged(int index) {
    setState(() {
      _currentImageIndex = index;
    });
  }

  void _onQuantityChanged(int quantity) {
    setState(() {
      _selectedQuantity = quantity;
    });
  }

  void _onFavoriteToggle() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isFavorite ? 'Added to favorites' : 'Removed from favorites'),
        backgroundColor: ModernColors.success,
      ),
    );
  }

  void _onBookNow() {
    setState(() {
      _showQRCode = true;
    });
    
    // Show booking confirmation
    _showBookingConfirmation();
  }

  void _showBookingConfirmation() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildBookingConfirmation(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: ModernGradients.darkGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header with back button
              _buildHeader(),
              
              // Main content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Image carousel
                      _buildImageCarousel(),
                      
                      // Content
                      Padding(
                        padding: const EdgeInsets.all(ModernSpacing.lg),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title and price
                            _buildTitleSection(),
                            
                            const SizedBox(height: ModernSpacing.lg),
                            
                            // Vendor info
                            _buildVendorSection(),
                            
                            const SizedBox(height: ModernSpacing.lg),
                            
                            // Description
                            _buildDescriptionSection(),
                            
                            const SizedBox(height: ModernSpacing.lg),
                            
                            // Ingredients and nutrition
                            _buildIngredientsSection(),
                            
                            const SizedBox(height: ModernSpacing.lg),
                            
                            // Allergens and dietary info
                            _buildDietarySection(),
                            
                            const SizedBox(height: ModernSpacing.lg),
                            
                            // Reviews
                            _buildReviewsSection(),
                            
                            const SizedBox(height: ModernSpacing.xxl),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Bottom action bar
              _buildBottomActionBar(),
            ],
          ),
        ),
      ),
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
                  GlassCard(
                    width: 50,
                    height: 50,
                    borderRadius: BorderRadius.circular(ModernBorderRadius.full),
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back,
                      color: ModernColors.textPrimary,
                      size: 24,
                    ),
                  ),
                  const Spacer(),
                  GlassCard(
                    width: 50,
                    height: 50,
                    borderRadius: BorderRadius.circular(ModernBorderRadius.full),
                    onTap: _onFavoriteToggle,
                    child: Icon(
                      _isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: _isFavorite ? ModernColors.error : ModernColors.textPrimary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: ModernSpacing.md),
                  GlassCard(
                    width: 50,
                    height: 50,
                    borderRadius: BorderRadius.circular(ModernBorderRadius.full),
                    onTap: () {
                      // TODO: Share functionality
                    },
                    child: const Icon(
                      Icons.share,
                      color: ModernColors.textPrimary,
                      size: 24,
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

  Widget _buildImageCarousel() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 300,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) => _onImageChanged(index),
                ),
                items: _foodPack.images.map((imageUrl) {
                  return Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(ModernBorderRadius.lg),
                      color: ModernColors.darkGray,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(ModernBorderRadius.lg),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: ModernColors.darkGray,
                          child: const Icon(
                            Icons.restaurant,
                            size: 64,
                            color: ModernColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              
              const SizedBox(height: ModernSpacing.md),
              
              // Image indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _foodPack.images.asMap().entries.map((entry) {
                  return Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentImageIndex == entry.key
                          ? ModernColors.electricBlue
                          : ModernColors.textTertiary,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTitleSection() {
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
                Text(
                  _foodPack.title,
                  style: ModernTextStyles.headlineMedium,
                ),
                const SizedBox(height: ModernSpacing.sm),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: ModernColors.warning,
                      size: 20,
                    ),
                    const SizedBox(width: ModernSpacing.xs),
                    Text(
                      _foodPack.rating.toString(),
                      style: ModernTextStyles.titleMedium,
                    ),
                    const SizedBox(width: ModernSpacing.xs),
                    Text(
                      '(${_foodPack.reviewCount} reviews)',
                      style: ModernTextStyles.bodyMedium.copyWith(
                        color: ModernColors.textSecondary,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '\$${_foodPack.price.toStringAsFixed(2)}',
                      style: ModernTextStyles.headlineMedium.copyWith(
                        color: ModernColors.electricBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                if (_foodPack.originalPrice > _foodPack.price) ...[
                  const SizedBox(height: ModernSpacing.xs),
                  Row(
                    children: [
                      Text(
                        '\$${_foodPack.originalPrice.toStringAsFixed(2)}',
                        style: ModernTextStyles.bodyMedium.copyWith(
                          color: ModernColors.textTertiary,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      const SizedBox(width: ModernSpacing.sm),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: ModernSpacing.sm,
                          vertical: ModernSpacing.xs,
                        ),
                        decoration: BoxDecoration(
                          color: ModernColors.success.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(ModernBorderRadius.sm),
                        ),
                        child: Text(
                          '${((_foodPack.originalPrice - _foodPack.price) / _foodPack.originalPrice * 100).round()}% OFF',
                          style: ModernTextStyles.labelSmall.copyWith(
                            color: ModernColors.success,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildVendorSection() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: GlassCard(
            padding: const EdgeInsets.all(ModernSpacing.lg),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(ModernBorderRadius.full),
                    gradient: ModernGradients.secondaryGradient,
                  ),
                  child: const Icon(
                    Icons.store,
                    color: ModernColors.textPrimary,
                    size: 28,
                  ),
                ),
                const SizedBox(width: ModernSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _foodPack.vendorName,
                        style: ModernTextStyles.titleMedium,
                      ),
                      Text(
                        '${_foodPack.distance.toStringAsFixed(1)} km away',
                        style: ModernTextStyles.bodyMedium.copyWith(
                          color: ModernColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: ModernSpacing.sm),
                      Row(
                        children: [
                          Icon(
                            Icons.verified,
                            color: ModernColors.success,
                            size: 16,
                          ),
                          const SizedBox(width: ModernSpacing.xs),
                          Text(
                            'Hygiene Score: ${_foodPack.hygieneScore}',
                            style: ModernTextStyles.bodySmall.copyWith(
                              color: ModernColors.success,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                ModernOutlinedButton(
                  text: 'View',
                  onPressed: () {
                    // TODO: Navigate to vendor profile
                  },
                  icon: Icons.arrow_forward,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDescriptionSection() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Description',
                style: ModernTextStyles.titleMedium,
              ),
              const SizedBox(height: ModernSpacing.md),
              Text(
                _foodPack.description,
                style: ModernTextStyles.bodyLarge.copyWith(
                  color: ModernColors.textSecondary,
                  height: 1.6,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildIngredientsSection() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ingredients & Nutrition',
                style: ModernTextStyles.titleMedium,
              ),
              const SizedBox(height: ModernSpacing.md),
              GlassCard(
                padding: const EdgeInsets.all(ModernSpacing.lg),
                child: Column(
                  children: [
                    // Ingredients
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ingredients',
                                style: ModernTextStyles.titleSmall,
                              ),
                              const SizedBox(height: ModernSpacing.sm),
                              ..._foodPack.ingredients.map((ingredient) => Padding(
                                padding: const EdgeInsets.only(bottom: ModernSpacing.xs),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 4,
                                      height: 4,
                                      decoration: BoxDecoration(
                                        color: ModernColors.electricBlue,
                                        borderRadius: BorderRadius.circular(ModernBorderRadius.full),
                                      ),
                                    ),
                                    const SizedBox(width: ModernSpacing.sm),
                                    Text(
                                      ingredient,
                                      style: ModernTextStyles.bodyMedium,
                                    ),
                                  ],
                                ),
                              )).toList(),
                            ],
                          ),
                        ),
                        const SizedBox(width: ModernSpacing.lg),
                        // Nutrition info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Nutrition (per serving)',
                                style: ModernTextStyles.titleSmall,
                              ),
                              const SizedBox(height: ModernSpacing.sm),
                              ..._foodPack.nutritionalInfo.entries.map((entry) => Padding(
                                padding: const EdgeInsets.only(bottom: ModernSpacing.xs),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      entry.key.toUpperCase(),
                                      style: ModernTextStyles.bodySmall.copyWith(
                                        color: ModernColors.textSecondary,
                                      ),
                                    ),
                                    Text(
                                      '${entry.value}g',
                                      style: ModernTextStyles.bodyMedium,
                                    ),
                                  ],
                                ),
                              )).toList(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDietarySection() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dietary Information',
                style: ModernTextStyles.titleMedium,
              ),
              const SizedBox(height: ModernSpacing.md),
              Wrap(
                spacing: ModernSpacing.sm,
                runSpacing: ModernSpacing.sm,
                children: [
                  _buildDietaryChip('Vegetarian', _foodPack.isVegetarian, ModernColors.success),
                  _buildDietaryChip('Vegan', _foodPack.isVegan, ModernColors.mintGreen),
                  _buildDietaryChip('Gluten-Free', _foodPack.isGlutenFree, ModernColors.neonPurple),
                ],
              ),
              if (_foodPack.allergens.isNotEmpty) ...[
                const SizedBox(height: ModernSpacing.md),
                Text(
                  'Allergens',
                  style: ModernTextStyles.titleSmall,
                ),
                const SizedBox(height: ModernSpacing.sm),
                Wrap(
                  spacing: ModernSpacing.sm,
                  runSpacing: ModernSpacing.sm,
                  children: _foodPack.allergens.map((allergen) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: ModernSpacing.md,
                      vertical: ModernSpacing.sm,
                    ),
                    decoration: BoxDecoration(
                      color: ModernColors.error.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(ModernBorderRadius.lg),
                      border: Border.all(
                        color: ModernColors.error.withOpacity(0.5),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      allergen,
                      style: ModernTextStyles.labelMedium.copyWith(
                        color: ModernColors.error,
                      ),
                    ),
                  )).toList(),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildDietaryChip(String label, bool isTrue, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: ModernSpacing.md,
        vertical: ModernSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: isTrue ? color.withOpacity(0.2) : ModernColors.darkGray,
        borderRadius: BorderRadius.circular(ModernBorderRadius.lg),
        border: Border.all(
          color: isTrue ? color : ModernColors.textTertiary,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isTrue ? Icons.check_circle : Icons.cancel,
            color: isTrue ? color : ModernColors.textTertiary,
            size: 16,
          ),
          const SizedBox(width: ModernSpacing.xs),
          Text(
            label,
            style: ModernTextStyles.labelMedium.copyWith(
              color: isTrue ? color : ModernColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsSection() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Reviews',
                    style: ModernTextStyles.titleMedium,
                  ),
                  const Spacer(),
                  ModernTextButton(
                    text: 'View All',
                    onPressed: () {
                      // TODO: Navigate to reviews page
                    },
                    textColor: ModernColors.electricBlue,
                  ),
                ],
              ),
              const SizedBox(height: ModernSpacing.md),
              GlassCard(
                padding: const EdgeInsets.all(ModernSpacing.lg),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: ModernColors.warning,
                          size: 24,
                        ),
                        const SizedBox(width: ModernSpacing.sm),
                        Text(
                          _foodPack.rating.toString(),
                          style: ModernTextStyles.headlineSmall,
                        ),
                        const SizedBox(width: ModernSpacing.sm),
                        Text(
                          'out of 5',
                          style: ModernTextStyles.bodyMedium.copyWith(
                            color: ModernColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: ModernSpacing.md),
                    Text(
                      'Based on ${_foodPack.reviewCount} reviews',
                      style: ModernTextStyles.bodyMedium.copyWith(
                        color: ModernColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomActionBar() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: GlassCard(
            margin: EdgeInsets.zero,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(ModernBorderRadius.lg),
              topRight: Radius.circular(ModernBorderRadius.lg),
            ),
            child: Padding(
              padding: const EdgeInsets.all(ModernSpacing.lg),
              child: Row(
                children: [
                  // Quantity selector
                  Container(
                    decoration: BoxDecoration(
                      color: ModernColors.darkGray,
                      borderRadius: BorderRadius.circular(ModernBorderRadius.lg),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: _selectedQuantity > 1
                              ? () => _onQuantityChanged(_selectedQuantity - 1)
                              : null,
                        ),
                        Text(
                          '$_selectedQuantity',
                          style: ModernTextStyles.titleMedium,
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: _selectedQuantity < _foodPack.quantity
                              ? () => _onQuantityChanged(_selectedQuantity + 1)
                              : null,
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(width: ModernSpacing.md),
                  
                  // Price
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total',
                          style: ModernTextStyles.bodyMedium.copyWith(
                            color: ModernColors.textSecondary,
                          ),
                        ),
                        Text(
                          '\$${(_foodPack.price * _selectedQuantity).toStringAsFixed(2)}',
                          style: ModernTextStyles.headlineMedium.copyWith(
                            color: ModernColors.electricBlue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Book now button
                  Expanded(
                    child: ModernGradientButton(
                      text: 'Book Now',
                      gradient: ModernGradients.primaryGradient,
                      onPressed: _onBookNow,
                      icon: Icons.shopping_cart,
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

  Widget _buildBookingConfirmation() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: ModernColors.darkBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(ModernBorderRadius.lg),
          topRight: Radius.circular(ModernBorderRadius.lg),
        ),
      ),
      child: Column(
        children: [
          // Handle
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(top: ModernSpacing.md),
            decoration: BoxDecoration(
              color: ModernColors.textTertiary,
              borderRadius: BorderRadius.circular(ModernBorderRadius.full),
            ),
          ),
          
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(ModernSpacing.lg),
              child: Column(
                children: [
                  // Success icon
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: ModernColors.success.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(ModernBorderRadius.full),
                    ),
                    child: const Icon(
                      Icons.check_circle,
                      color: ModernColors.success,
                      size: 48,
                    ),
                  ),
                  
                  const SizedBox(height: ModernSpacing.lg),
                  
                  Text(
                    'Booking Confirmed!',
                    style: ModernTextStyles.headlineMedium,
                  ),
                  
                  const SizedBox(height: ModernSpacing.md),
                  
                  Text(
                    'Your order has been successfully placed. Show this QR code to the vendor for pickup.',
                    style: ModernTextStyles.bodyMedium.copyWith(
                      color: ModernColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: ModernSpacing.xl),
                  
                  // QR Code
                  GlassCard(
                    padding: const EdgeInsets.all(ModernSpacing.lg),
                    child: Column(
                      children: [
                        QrImageView(
                          data: 'PLATEFUL_ORDER_${widget.packId}_${DateTime.now().millisecondsSinceEpoch}',
                          version: QrVersions.auto,
                          size: 200,
                          backgroundColor: Colors.white,
                        ),
                        const SizedBox(height: ModernSpacing.lg),
                        Text(
                          'Order #${widget.packId}',
                          style: ModernTextStyles.titleMedium,
                        ),
                        Text(
                          'Pickup by ${_foodPack.pickupEndTime.hour}:${_foodPack.pickupEndTime.minute.toString().padLeft(2, '0')}',
                          style: ModernTextStyles.bodyMedium.copyWith(
                            color: ModernColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: ModernSpacing.xl),
                  
                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: ModernOutlinedButton(
                          text: 'View Orders',
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, AppRoutes.orders);
                          },
                          icon: Icons.shopping_bag,
                        ),
                      ),
                      const SizedBox(width: ModernSpacing.md),
                      Expanded(
                        child: ModernGradientButton(
                          text: 'Done',
                          gradient: ModernGradients.primaryGradient,
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
} 