import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../themes/modern_theme.dart';
import '../../widgets/modern/glass_card.dart';
import '../../models/food_pack_model.dart';
import '../../constants/app_constants.dart';

class FoodPackCard extends StatefulWidget {
  final FoodPack foodPack;
  final VoidCallback? onTap;
  final VoidCallback? onFavorite;
  final bool isFavorite;
  final bool showVendorInfo;
  final bool showDistance;
  final bool showRating;

  const FoodPackCard({
    super.key,
    required this.foodPack,
    this.onTap,
    this.onFavorite,
    this.isFavorite = false,
    this.showVendorInfo = true,
    this.showDistance = true,
    this.showRating = true,
  });

  @override
  State<FoodPackCard> createState() => _FoodPackCardState();
}

class _FoodPackCardState extends State<FoodPackCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
    if (isHovered) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: GlowingGlassCard(
              width: 320,
              height: 400,
              borderRadius: BorderRadius.circular(ModernBorderRadius.xl),
              glowColor: _getGlowColor(),
              glowIntensity: _isHovered ? 0.4 : 0.2,
              enablePulse: widget.foodPack.isUrgent,
              onTap: widget.onTap,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image section
                  _buildImageSection(),
                  
                  // Content section
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(ModernSpacing.lg),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title and favorite button
                          _buildTitleSection(),
                          
                          const SizedBox(height: ModernSpacing.sm),
                          
                          // Vendor info
                          if (widget.showVendorInfo) _buildVendorSection(),
                          
                          const SizedBox(height: ModernSpacing.md),
                          
                          // Price and discount
                          _buildPriceSection(),
                          
                          const SizedBox(height: ModernSpacing.md),
                          
                          // Tags and badges
                          _buildTagsSection(),
                          
                          const Spacer(),
                          
                          // Bottom section
                          _buildBottomSection(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildImageSection() {
    return Stack(
      children: [
        // Main image
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(ModernBorderRadius.xl),
              topRight: Radius.circular(ModernBorderRadius.xl),
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(ModernBorderRadius.xl),
              topRight: Radius.circular(ModernBorderRadius.xl),
            ),
            child: widget.foodPack.images.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: widget.foodPack.images.first,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: ModernColors.darkGray,
                      child: const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(ModernColors.electricBlue),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: ModernColors.darkGray,
                      child: const Icon(
                        Icons.restaurant,
                        color: ModernColors.textSecondary,
                        size: 50,
                      ),
                    ),
                  )
                : Container(
                    color: ModernColors.darkGray,
                    child: const Icon(
                      Icons.restaurant,
                      color: ModernColors.textSecondary,
                      size: 50,
                    ),
                  ),
          ),
        ),
        
        // Gradient overlay
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(ModernBorderRadius.xl),
                topRight: Radius.circular(ModernBorderRadius.xl),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.3),
                ],
              ),
            ),
          ),
        ),
        
        // Top badges
        Positioned(
          top: ModernSpacing.md,
          left: ModernSpacing.md,
          child: _buildHygieneBadge(),
        ),
        
        Positioned(
          top: ModernSpacing.md,
          right: ModernSpacing.md,
          child: _buildExpiryBadge(),
        ),
        
        // Favorite button
        Positioned(
          top: ModernSpacing.md,
          right: ModernSpacing.md,
          child: _buildFavoriteButton(),
        ),
      ],
    );
  }

  Widget _buildHygieneBadge() {
    final hygieneColor = widget.foodPack.hygieneScore >= 8.0
        ? ModernColors.success
        : widget.foodPack.hygieneScore >= 6.0
            ? ModernColors.warning
            : ModernColors.error;
    
    return GlassCard(
      padding: const EdgeInsets.symmetric(
        horizontal: ModernSpacing.sm,
        vertical: ModernSpacing.xs,
      ),
      borderColor: hygieneColor.withOpacity(0.5),
      borderWidth: 1.0,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.verified,
            color: hygieneColor,
            size: 16,
          ),
          const SizedBox(width: ModernSpacing.xs),
          Text(
            '${widget.foodPack.hygieneScore.toStringAsFixed(1)}',
            style: ModernTextStyles.labelSmall.copyWith(
              color: hygieneColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpiryBadge() {
    final timeUntilExpiry = widget.foodPack.expiryTime.difference(DateTime.now());
    final hoursLeft = timeUntilExpiry.inHours;
    
    Color badgeColor;
    String text;
    
    if (hoursLeft <= 1) {
      badgeColor = ModernColors.error;
      text = '${timeUntilExpiry.inMinutes}m';
    } else if (hoursLeft <= 3) {
      badgeColor = ModernColors.warning;
      text = '${hoursLeft}h';
    } else {
      badgeColor = ModernColors.success;
      text = '${hoursLeft}h';
    }
    
    return GlassCard(
      padding: const EdgeInsets.symmetric(
        horizontal: ModernSpacing.sm,
        vertical: ModernSpacing.xs,
      ),
      borderColor: badgeColor.withOpacity(0.5),
      borderWidth: 1.0,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.access_time,
            color: badgeColor,
            size: 16,
          ),
          const SizedBox(width: ModernSpacing.xs),
          Text(
            text,
            style: ModernTextStyles.labelSmall.copyWith(
              color: badgeColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteButton() {
    return GestureDetector(
      onTap: widget.onFavorite,
      child: GlassCard(
        width: 40,
        height: 40,
        borderRadius: BorderRadius.circular(ModernBorderRadius.full),
        borderColor: ModernColors.neonPink.withOpacity(0.5),
        borderWidth: 1.0,
        child: Icon(
          widget.isFavorite ? Icons.favorite : Icons.favorite_border,
          color: widget.isFavorite ? ModernColors.neonPink : ModernColors.textSecondary,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildTitleSection() {
    return Row(
      children: [
        Expanded(
          child: Text(
            widget.foodPack.title,
            style: ModernTextStyles.headlineSmall,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildVendorSection() {
    return Row(
      children: [
        Icon(
          Icons.store,
          color: ModernColors.textSecondary,
          size: 16,
        ),
        const SizedBox(width: ModernSpacing.xs),
        Expanded(
          child: Text(
            widget.foodPack.vendorName,
            style: ModernTextStyles.bodyMedium.copyWith(
              color: ModernColors.textSecondary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (widget.showDistance)
          Text(
            '${widget.foodPack.distance.toStringAsFixed(1)}km',
            style: ModernTextStyles.bodySmall.copyWith(
              color: ModernColors.textTertiary,
            ),
          ),
      ],
    );
  }

  Widget _buildPriceSection() {
    return Row(
      children: [
        Text(
          '\$${widget.foodPack.price.toStringAsFixed(2)}',
          style: ModernTextStyles.headlineMedium.copyWith(
            color: ModernColors.electricBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: ModernSpacing.sm),
        if (widget.foodPack.originalPrice > widget.foodPack.price)
          Text(
            '\$${widget.foodPack.originalPrice.toStringAsFixed(2)}',
            style: ModernTextStyles.bodyMedium.copyWith(
              color: ModernColors.textTertiary,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        const Spacer(),
        if (widget.foodPack.discountPercentage > 0)
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: ModernSpacing.sm,
              vertical: ModernSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: ModernColors.neonPink.withOpacity(0.2),
              borderRadius: BorderRadius.circular(ModernBorderRadius.sm),
            ),
            child: Text(
              '-${widget.foodPack.discountPercentage.round()}%',
              style: ModernTextStyles.labelSmall.copyWith(
                color: ModernColors.neonPink,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildTagsSection() {
    return Wrap(
      spacing: ModernSpacing.xs,
      runSpacing: ModernSpacing.xs,
      children: [
        if (widget.foodPack.isVegetarian)
          _buildTag('Vegetarian', ModernColors.mintGreen),
        if (widget.foodPack.isVegan)
          _buildTag('Vegan', ModernColors.mintGreen),
        if (widget.foodPack.isGlutenFree)
          _buildTag('Gluten-Free', ModernColors.neonOrange),
        if (widget.foodPack.category.isNotEmpty)
          _buildTag(widget.foodPack.category, ModernColors.neonPurple),
      ],
    );
  }

  Widget _buildTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: ModernSpacing.sm,
        vertical: ModernSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(ModernBorderRadius.sm),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Text(
        text,
        style: ModernTextStyles.labelSmall.copyWith(
          color: color,
        ),
      ),
    );
  }

  Widget _buildBottomSection() {
    return Row(
      children: [
        if (widget.showRating) ...[
          Icon(
            Icons.star,
            color: ModernColors.warning,
            size: 16,
          ),
          const SizedBox(width: ModernSpacing.xs),
          Text(
            widget.foodPack.rating.toStringAsFixed(1),
            style: ModernTextStyles.bodySmall.copyWith(
              color: ModernColors.textSecondary,
            ),
          ),
          const SizedBox(width: ModernSpacing.xs),
          Text(
            '(${widget.foodPack.reviewCount})',
            style: ModernTextStyles.bodySmall.copyWith(
              color: ModernColors.textTertiary,
            ),
          ),
        ],
        const Spacer(),
        Text(
          '${widget.foodPack.availableQuantity} left',
          style: ModernTextStyles.bodySmall.copyWith(
            color: widget.foodPack.availableQuantity <= 3 
                ? ModernColors.error 
                : ModernColors.textTertiary,
          ),
        ),
      ],
    );
  }

  Color _getGlowColor() {
    if (widget.foodPack.isUrgent) return ModernColors.error;
    if (widget.foodPack.hygieneScore >= 8.0) return ModernColors.success;
    if (widget.foodPack.discountPercentage > 30) return ModernColors.neonPink;
    return ModernColors.electricBlue;
  }
} 