import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../themes/modern_theme.dart';
import '../../widgets/modern/glass_card.dart';
import '../../widgets/modern/modern_button.dart';
import '../../models/food_pack_model.dart';
import '../../constants/app_constants.dart';

class VendorDashboard extends StatefulWidget {
  const VendorDashboard({super.key});

  @override
  State<VendorDashboard> createState() => _VendorDashboardState();
}

class _VendorDashboardState extends State<VendorDashboard>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  
  int _selectedTabIndex = 0;
  String _selectedTimeRange = '7d';
  
  // Mock data
  final List<FoodPack> _foodPacks = _generateMockVendorFoodPacks();
  final List<ChartData> _salesData = _generateMockSalesData();
  final List<ChartData> _demandData = _generateMockDemandData();

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
    super.dispose();
  }

  void _onTabChanged(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  void _onTimeRangeChanged(String range) {
    setState(() {
      _selectedTimeRange = range;
    });
  }

  void _onAddFoodPack() {
    Navigator.pushNamed(context, AppRoutes.addPack);
  }

  void _onEditFoodPack(FoodPack foodPack) {
    Navigator.pushNamed(context, AppRoutes.editPack, arguments: foodPack);
  }

  void _onViewOrders() {
    Navigator.pushNamed(context, AppRoutes.vendorOrders);
  }

  void _onViewAnalytics() {
    Navigator.pushNamed(context, AppRoutes.analytics);
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
              // Header
              _buildHeader(),
              
              // Tab navigation
              _buildTabNavigation(),
              
              // Main content
              Expanded(
                child: IndexedStack(
                  index: _selectedTabIndex,
                  children: [
                    _buildOverviewTab(),
                    _buildFoodPacksTab(),
                    _buildAnalyticsTab(),
                    _buildOrdersTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // Floating action button
      floatingActionButton: _buildFloatingActionButton(),
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
                  // Vendor avatar
                  GlassCard(
                    width: 60,
                    height: 60,
                    borderRadius: BorderRadius.circular(ModernBorderRadius.full),
                    child: Container(
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
                  ),
                  
                  const SizedBox(width: ModernSpacing.md),
                  
                  // Vendor info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tasty Bites Restaurant',
                          style: ModernTextStyles.headlineSmall,
                        ),
                        Text(
                          'Premium Vendor • 4.8 ★',
                          style: ModernTextStyles.bodyMedium.copyWith(
                            color: ModernColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Settings
                  GlassCard(
                    width: 50,
                    height: 50,
                    borderRadius: BorderRadius.circular(ModernBorderRadius.full),
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.vendorProfile);
                    },
                    child: const Icon(
                      Icons.settings,
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

  Widget _buildTabNavigation() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: ModernSpacing.lg),
            child: GlassCard(
              padding: const EdgeInsets.all(ModernSpacing.sm),
              child: Row(
                children: [
                  _buildTabButton('Overview', Icons.dashboard, 0),
                  _buildTabButton('Food Packs', Icons.restaurant_menu, 1),
                  _buildTabButton('Analytics', Icons.analytics, 2),
                  _buildTabButton('Orders', Icons.shopping_bag, 3),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTabButton(String title, IconData icon, int index) {
    final isSelected = _selectedTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => _onTabChanged(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(
            vertical: ModernSpacing.md,
            horizontal: ModernSpacing.sm,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ModernBorderRadius.lg),
            gradient: isSelected ? LinearGradient(
              colors: [ModernColors.neonPurple, ModernColors.neonPurple.withOpacity(0.7)],
            ) : null,
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected ? ModernColors.textPrimary : ModernColors.textSecondary,
                size: 20,
              ),
              const SizedBox(height: ModernSpacing.xs),
              Text(
                title,
                style: ModernTextStyles.labelSmall.copyWith(
                  color: isSelected ? ModernColors.textPrimary : ModernColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOverviewTab() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _slideAnimation.value),
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(ModernSpacing.lg),
              child: Column(
                children: [
                  // Stats cards
                  _buildStatsCards(),
                  
                  const SizedBox(height: ModernSpacing.xl),
                  
                  // Quick actions
                  _buildQuickActions(),
                  
                  const SizedBox(height: ModernSpacing.xl),
                  
                  // Recent activity
                  _buildRecentActivity(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatsCards() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: ModernSpacing.md,
      mainAxisSpacing: ModernSpacing.md,
      childAspectRatio: 1.5,
      children: [
        _buildStatCard(
          'Total Sales',
          '\$2,450',
          '+12.5%',
          ModernColors.success,
          Icons.trending_up,
        ),
        _buildStatCard(
          'Orders Today',
          '24',
          '+8.3%',
          ModernColors.electricBlue,
          Icons.shopping_bag,
        ),
        _buildStatCard(
          'Active Packs',
          '8',
          '-2.1%',
          ModernColors.warning,
          Icons.restaurant_menu,
        ),
        _buildStatCard(
          'Avg Rating',
          '4.8',
          '+0.2',
          ModernColors.neonPink,
          Icons.star,
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, String change, Color color, IconData icon) {
    final isPositive = change.startsWith('+');
    return GlassCard(
      padding: const EdgeInsets.all(ModernSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: ModernSpacing.sm,
                  vertical: ModernSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: (isPositive ? ModernColors.success : ModernColors.error).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(ModernBorderRadius.sm),
                ),
                child: Text(
                  change,
                  style: ModernTextStyles.labelSmall.copyWith(
                    color: isPositive ? ModernColors.success : ModernColors.error,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: ModernSpacing.md),
          Text(
            value,
            style: ModernTextStyles.headlineMedium.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            title,
            style: ModernTextStyles.bodyMedium.copyWith(
              color: ModernColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: ModernTextStyles.headlineMedium,
        ),
        const SizedBox(height: ModernSpacing.lg),
        Row(
          children: [
            Expanded(
              child: ModernGradientButton(
                text: 'Add Food Pack',
                gradient: ModernGradients.primaryGradient,
                onPressed: _onAddFoodPack,
                icon: Icons.add,
              ),
            ),
            const SizedBox(width: ModernSpacing.md),
            Expanded(
              child: ModernOutlinedButton(
                text: 'View Orders',
                onPressed: _onViewOrders,
                icon: Icons.shopping_bag,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Activity',
          style: ModernTextStyles.headlineMedium,
        ),
        const SizedBox(height: ModernSpacing.lg),
        GlassCard(
          child: Column(
            children: [
              _buildActivityItem(
                'New order received',
                'Pasta Carbonara - Order #1234',
                '2 minutes ago',
                ModernColors.success,
                Icons.shopping_cart,
              ),
              _buildActivityItem(
                'Food pack updated',
                'Salad Bowl - Price reduced',
                '15 minutes ago',
                ModernColors.info,
                Icons.edit,
              ),
              _buildActivityItem(
                'Review received',
                '5-star rating for Pizza Margherita',
                '1 hour ago',
                ModernColors.warning,
                Icons.star,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActivityItem(String title, String subtitle, String time, Color color, IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(ModernSpacing.md),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(ModernBorderRadius.full),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          const SizedBox(width: ModernSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: ModernTextStyles.titleMedium,
                ),
                Text(
                  subtitle,
                  style: ModernTextStyles.bodyMedium.copyWith(
                    color: ModernColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: ModernTextStyles.bodySmall.copyWith(
              color: ModernColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodPacksTab() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(ModernSpacing.lg),
            child: Column(
              children: [
                // Food packs list
                ..._foodPacks.map((foodPack) => _buildFoodPackItem(foodPack)).toList(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFoodPackItem(FoodPack foodPack) {
    return GlassCard(
      margin: const EdgeInsets.only(bottom: ModernSpacing.md),
      child: Padding(
        padding: const EdgeInsets.all(ModernSpacing.lg),
        child: Row(
          children: [
            // Image
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(ModernBorderRadius.lg),
                color: ModernColors.darkGray,
              ),
              child: foodPack.images.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(ModernBorderRadius.lg),
                      child: Image.network(
                        foodPack.images.first,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Icon(
                          Icons.restaurant,
                          color: ModernColors.textSecondary,
                        ),
                      ),
                    )
                  : const Icon(
                      Icons.restaurant,
                      color: ModernColors.textSecondary,
                    ),
            ),
            
            const SizedBox(width: ModernSpacing.md),
            
            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    foodPack.title,
                    style: ModernTextStyles.titleMedium,
                  ),
                  Text(
                    foodPack.vendorName,
                    style: ModernTextStyles.bodyMedium.copyWith(
                      color: ModernColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: ModernSpacing.sm),
                  Row(
                    children: [
                      Text(
                        '\$${foodPack.price.toStringAsFixed(2)}',
                        style: ModernTextStyles.titleMedium.copyWith(
                          color: ModernColors.electricBlue,
                        ),
                      ),
                      const SizedBox(width: ModernSpacing.md),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: ModernSpacing.sm,
                          vertical: ModernSpacing.xs,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(foodPack.status).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(ModernBorderRadius.sm),
                        ),
                        child: Text(
                          foodPack.status.toUpperCase(),
                          style: ModernTextStyles.labelSmall.copyWith(
                            color: _getStatusColor(foodPack.status),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Actions
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _onEditFoodPack(foodPack),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    // TODO: Implement delete
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(ModernSpacing.lg),
            child: Column(
              children: [
                // Time range selector
                _buildTimeRangeSelector(),
                
                const SizedBox(height: ModernSpacing.xl),
                
                // Sales chart
                _buildSalesChart(),
                
                const SizedBox(height: ModernSpacing.xl),
                
                // Demand prediction
                _buildDemandChart(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTimeRangeSelector() {
    return GlassCard(
      padding: const EdgeInsets.all(ModernSpacing.md),
      child: Row(
        children: [
          _buildTimeRangeButton('7d', '7 Days'),
          const SizedBox(width: ModernSpacing.sm),
          _buildTimeRangeButton('30d', '30 Days'),
          const SizedBox(width: ModernSpacing.sm),
          _buildTimeRangeButton('90d', '90 Days'),
        ],
      ),
    );
  }

  Widget _buildTimeRangeButton(String value, String label) {
    final isSelected = _selectedTimeRange == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => _onTimeRangeChanged(value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(vertical: ModernSpacing.sm),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ModernBorderRadius.lg),
            color: isSelected ? ModernColors.electricBlue.withOpacity(0.2) : Colors.transparent,
          ),
          child: Text(
            label,
            style: ModernTextStyles.labelMedium.copyWith(
              color: isSelected ? ModernColors.electricBlue : ModernColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildSalesChart() {
    return GlassCard(
      padding: const EdgeInsets.all(ModernSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sales Overview',
            style: ModernTextStyles.headlineMedium,
          ),
          const SizedBox(height: ModernSpacing.lg),
          SizedBox(
            height: 300,
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(
                majorGridLines: const MajorGridLines(width: 0),
                labelStyle: TextStyle(color: ModernColors.textSecondary),
              ),
              primaryYAxis: NumericAxis(
                majorGridLines: MajorGridLines(
                  width: 1,
                  color: ModernColors.textTertiary.withOpacity(0.3),
                ),
                labelStyle: TextStyle(color: ModernColors.textSecondary),
              ),
              series: <CartesianSeries>[
                LineSeries<ChartData, String>(
                  dataSource: _salesData,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  color: ModernColors.electricBlue,
                  width: 3,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDemandChart() {
    return GlassCard(
      padding: const EdgeInsets.all(ModernSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'AI Demand Prediction',
            style: ModernTextStyles.headlineMedium,
          ),
          const SizedBox(height: ModernSpacing.lg),
          SizedBox(
            height: 300,
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(
                majorGridLines: const MajorGridLines(width: 0),
                labelStyle: TextStyle(color: ModernColors.textSecondary),
              ),
              primaryYAxis: NumericAxis(
                majorGridLines: MajorGridLines(
                  width: 1,
                  color: ModernColors.textTertiary.withOpacity(0.3),
                ),
                labelStyle: TextStyle(color: ModernColors.textSecondary),
              ),
              series: <CartesianSeries>[
                ColumnSeries<ChartData, String>(
                  dataSource: _demandData,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  color: ModernColors.mintGreen,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersTab() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_bag,
                  size: 64,
                  color: ModernColors.textSecondary,
                ),
                const SizedBox(height: ModernSpacing.lg),
                Text(
                  'Orders Management',
                  style: ModernTextStyles.headlineMedium,
                ),
                const SizedBox(height: ModernSpacing.md),
                Text(
                  'View and manage all your orders here',
                  style: ModernTextStyles.bodyMedium.copyWith(
                    color: ModernColors.textSecondary,
                  ),
                ),
                const SizedBox(height: ModernSpacing.xl),
                ModernGradientButton(
                  text: 'View Orders',
                  gradient: ModernGradients.primaryGradient,
                  onPressed: _onViewOrders,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton.extended(
      onPressed: _onAddFoodPack,
      backgroundColor: ModernColors.electricBlue,
      icon: const Icon(Icons.add),
      label: const Text('Add Pack'),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'available':
        return ModernColors.success;
      case 'reserved':
        return ModernColors.warning;
      case 'expired':
        return ModernColors.error;
      default:
        return ModernColors.textSecondary;
    }
  }
}

// Chart data model
class ChartData {
  final String x;
  final double y;

  ChartData(this.x, this.y);
}

// Mock data generators
List<FoodPack> _generateMockVendorFoodPacks() {
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

List<ChartData> _generateMockSalesData() {
  return [
    ChartData('Mon', 120),
    ChartData('Tue', 180),
    ChartData('Wed', 150),
    ChartData('Thu', 220),
    ChartData('Fri', 280),
    ChartData('Sat', 320),
    ChartData('Sun', 200),
  ];
}

List<ChartData> _generateMockDemandData() {
  return [
    ChartData('Pizza', 45),
    ChartData('Pasta', 32),
    ChartData('Salad', 28),
    ChartData('Burgers', 38),
    ChartData('Sushi', 25),
  ];
} 