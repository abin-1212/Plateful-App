// Enums for better type safety
enum FoodPackStatus {
  available,
  reserved,
  expired,
  pickedUp,
  cancelled;

  String get displayName {
    switch (this) {
      case FoodPackStatus.available:
        return 'Available';
      case FoodPackStatus.reserved:
        return 'Reserved';
      case FoodPackStatus.expired:
        return 'Expired';
      case FoodPackStatus.pickedUp:
        return 'Picked Up';
      case FoodPackStatus.cancelled:
        return 'Cancelled';
    }
  }
}

enum FoodCategory {
  bakery,
  cafe,
  restaurant,
  fastFood,
  grocery,
  convenience,
  other;

  String get displayName {
    switch (this) {
      case FoodCategory.bakery:
        return 'Bakery';
      case FoodCategory.cafe:
        return 'Café';
      case FoodCategory.restaurant:
        return 'Restaurant';
      case FoodCategory.fastFood:
        return 'Fast Food';
      case FoodCategory.grocery:
        return 'Grocery';
      case FoodCategory.convenience:
        return 'Convenience Store';
      case FoodCategory.other:
        return 'Other';
    }
  }
}

class FoodPack {
  final String id;
  final String vendorId;
  final String vendorName;
  final String title;
  final String description;
  final List<String> images;
  final String category;
  final double price;
  final double originalPrice;
  final int quantity;
  final int reservedQuantity;
  final DateTime expiryTime;
  final DateTime pickupStartTime;
  final DateTime pickupEndTime;
  final Map<String, dynamic> location;
  final double distance;
  final double rating;
  final int reviewCount;
  final List<String> ingredients;
  final Map<String, dynamic> nutritionalInfo;
  final bool isHygieneCertified;
  final double hygieneScore;
  final List<String> allergens;
  final bool isVegetarian;
  final bool isVegan;
  final bool isGlutenFree;
  final String status; // 'available', 'reserved', 'expired', 'picked_up'
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String> tags;
  final Map<String, dynamic>? aiRecommendations;
  final bool isFavorite;
  final bool isUrgent;

  FoodPack({
    required this.id,
    required this.vendorId,
    required this.vendorName,
    required this.title,
    required this.description,
    required this.images,
    required this.category,
    required this.price,
    required this.originalPrice,
    required this.quantity,
    required this.reservedQuantity,
    required this.expiryTime,
    required this.pickupStartTime,
    required this.pickupEndTime,
    required this.location,
    required this.distance,
    required this.rating,
    required this.reviewCount,
    required this.ingredients,
    required this.nutritionalInfo,
    required this.isHygieneCertified,
    required this.hygieneScore,
    required this.allergens,
    required this.isVegetarian,
    required this.isVegan,
    required this.isGlutenFree,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.tags,
    this.aiRecommendations,
    this.isFavorite = false,
    this.isUrgent = false,
  });

  factory FoodPack.fromJson(Map<String, dynamic> json) {
    return FoodPack(
      id: json['id'] ?? '',
      vendorId: json['vendorId'] ?? '',
      vendorName: json['vendorName'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      category: json['category'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      originalPrice: (json['originalPrice'] ?? 0.0).toDouble(),
      quantity: json['quantity'] ?? 0,
      reservedQuantity: json['reservedQuantity'] ?? 0,
      expiryTime: DateTime.parse(json['expiryTime'] ?? DateTime.now().toIso8601String()),
      pickupStartTime: DateTime.parse(json['pickupStartTime'] ?? DateTime.now().toIso8601String()),
      pickupEndTime: DateTime.parse(json['pickupEndTime'] ?? DateTime.now().toIso8601String()),
      location: Map<String, dynamic>.from(json['location'] ?? {}),
      distance: (json['distance'] ?? 0.0).toDouble(),
      rating: (json['rating'] ?? 0.0).toDouble(),
      reviewCount: json['reviewCount'] ?? 0,
      ingredients: List<String>.from(json['ingredients'] ?? []),
      nutritionalInfo: Map<String, dynamic>.from(json['nutritionalInfo'] ?? {}),
      isHygieneCertified: json['isHygieneCertified'] ?? false,
      hygieneScore: (json['hygieneScore'] ?? 0.0).toDouble(),
      allergens: List<String>.from(json['allergens'] ?? []),
      isVegetarian: json['isVegetarian'] ?? false,
      isVegan: json['isVegan'] ?? false,
      isGlutenFree: json['isGlutenFree'] ?? false,
      status: json['status'] ?? 'available',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
      tags: List<String>.from(json['tags'] ?? []),
      aiRecommendations: json['aiRecommendations'] != null 
          ? Map<String, dynamic>.from(json['aiRecommendations']) 
          : null,
      isFavorite: json['isFavorite'] ?? false,
      isUrgent: json['isUrgent'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vendorId': vendorId,
      'vendorName': vendorName,
      'title': title,
      'description': description,
      'images': images,
      'category': category,
      'price': price,
      'originalPrice': originalPrice,
      'quantity': quantity,
      'reservedQuantity': reservedQuantity,
      'expiryTime': expiryTime.toIso8601String(),
      'pickupStartTime': pickupStartTime.toIso8601String(),
      'pickupEndTime': pickupEndTime.toIso8601String(),
      'location': location,
      'distance': distance,
      'rating': rating,
      'reviewCount': reviewCount,
      'ingredients': ingredients,
      'nutritionalInfo': nutritionalInfo,
      'isHygieneCertified': isHygieneCertified,
      'hygieneScore': hygieneScore,
      'allergens': allergens,
      'isVegetarian': isVegetarian,
      'isVegan': isVegan,
      'isGlutenFree': isGlutenFree,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'tags': tags,
      'aiRecommendations': aiRecommendations,
    };
  }

  // Computed properties
  bool get isAvailable => status == 'available' && quantity > reservedQuantity;
  bool get isExpired => DateTime.now().isAfter(expiryTime);
  double get discountPercentage => ((originalPrice - price) / originalPrice * 100).roundToDouble();
  int get availableQuantity => quantity - reservedQuantity;
  
  // New computed properties
  bool get hasDiscount => originalPrice > price;
  bool get isPickupTimeNow {
    final now = DateTime.now();
    return now.isAfter(pickupStartTime) && now.isBefore(pickupEndTime);
  }
  
  bool get isPickupTimeExpired => DateTime.now().isAfter(pickupEndTime);
  
  Duration get timeUntilExpiry => expiryTime.difference(DateTime.now());
  
  Duration get timeUntilPickupStart => pickupStartTime.difference(DateTime.now());
  
  Duration get timeUntilPickupEnd => pickupEndTime.difference(DateTime.now());
  
  String get formattedDistance {
    if (distance < 1) {
      return '${(distance * 1000).round()}m';
    } else {
      return '${distance.toStringAsFixed(1)}km';
    }
  }
  
  String get formattedPrice => '\$${price.toStringAsFixed(2)}';
  
  String get formattedOriginalPrice => '\$${originalPrice.toStringAsFixed(2)}';
  
  String get formattedDiscount => '${discountPercentage.toStringAsFixed(0)}% OFF';
  
  String get formattedExpiryTime {
    final now = DateTime.now();
    final difference = expiryTime.difference(now);
    
    if (difference.isNegative) {
      return 'Expired';
    }
    
    if (difference.inDays > 0) {
      return '${difference.inDays}d ${difference.inHours % 24}h';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ${difference.inMinutes % 60}m';
    } else {
      return '${difference.inMinutes}m';
    }
  }
  
  String get formattedPickupTime {
    final start = pickupStartTime;
    final end = pickupEndTime;
    
    if (start.day == end.day) {
      return '${start.hour.toString().padLeft(2, '0')}:${start.minute.toString().padLeft(2, '0')} - ${end.hour.toString().padLeft(2, '0')}:${end.minute.toString().padLeft(2, '0')}';
    } else {
      return '${start.day}/${start.month} ${start.hour}:${start.minute} - ${end.day}/${end.month} ${end.hour}:${end.minute}';
    }
  }
  
  List<String> get dietaryTags {
    final tags = <String>[];
    if (isVegetarian) tags.add('Vegetarian');
    if (isVegan) tags.add('Vegan');
    if (isGlutenFree) tags.add('Gluten-Free');
    return tags;
  }
  
  bool get hasAllergens => allergens.isNotEmpty;
  
  String get allergensDisplay {
    if (allergens.isEmpty) return 'No allergens';
    return allergens.join(', ');
  }
  
  double get calories => nutritionalInfo['calories']?.toDouble() ?? 0.0;
  double get protein => nutritionalInfo['protein']?.toDouble() ?? 0.0;
  double get carbs => nutritionalInfo['carbs']?.toDouble() ?? 0.0;
  double get fat => nutritionalInfo['fat']?.toDouble() ?? 0.0;
  double get fiber => nutritionalInfo['fiber']?.toDouble() ?? 0.0;
  double get sugar => nutritionalInfo['sugar']?.toDouble() ?? 0.0;
  double get sodium => nutritionalInfo['sodium']?.toDouble() ?? 0.0;

  FoodPack copyWith({
    String? id,
    String? vendorId,
    String? vendorName,
    String? title,
    String? description,
    List<String>? images,
    String? category,
    double? price,
    double? originalPrice,
    int? quantity,
    int? reservedQuantity,
    DateTime? expiryTime,
    DateTime? pickupStartTime,
    DateTime? pickupEndTime,
    Map<String, dynamic>? location,
    double? distance,
    double? rating,
    int? reviewCount,
    List<String>? ingredients,
    Map<String, dynamic>? nutritionalInfo,
    bool? isHygieneCertified,
    double? hygieneScore,
    List<String>? allergens,
    bool? isVegetarian,
    bool? isVegan,
    bool? isGlutenFree,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? tags,
    Map<String, dynamic>? aiRecommendations,
    bool? isFavorite,
    bool? isUrgent,
  }) {
    return FoodPack(
      id: id ?? this.id,
      vendorId: vendorId ?? this.vendorId,
      vendorName: vendorName ?? this.vendorName,
      title: title ?? this.title,
      description: description ?? this.description,
      images: images ?? this.images,
      category: category ?? this.category,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      quantity: quantity ?? this.quantity,
      reservedQuantity: reservedQuantity ?? this.reservedQuantity,
      expiryTime: expiryTime ?? this.expiryTime,
      pickupStartTime: pickupStartTime ?? this.pickupStartTime,
      pickupEndTime: pickupEndTime ?? this.pickupEndTime,
      location: location ?? this.location,
      distance: distance ?? this.distance,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      ingredients: ingredients ?? this.ingredients,
      nutritionalInfo: nutritionalInfo ?? this.nutritionalInfo,
      isHygieneCertified: isHygieneCertified ?? this.isHygieneCertified,
      hygieneScore: hygieneScore ?? this.hygieneScore,
      allergens: allergens ?? this.allergens,
      isVegetarian: isVegetarian ?? this.isVegetarian,
      isVegan: isVegan ?? this.isVegan,
      isGlutenFree: isGlutenFree ?? this.isGlutenFree,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      tags: tags ?? this.tags,
      aiRecommendations: aiRecommendations ?? this.aiRecommendations,
      isFavorite: isFavorite ?? this.isFavorite,
      isUrgent: isUrgent ?? this.isUrgent,
    );
  }

  // Utility methods
  bool matchesSearch(String query) {
    final lowercaseQuery = query.toLowerCase();
    return title.toLowerCase().contains(lowercaseQuery) ||
           description.toLowerCase().contains(lowercaseQuery) ||
           vendorName.toLowerCase().contains(lowercaseQuery) ||
           category.toLowerCase().contains(lowercaseQuery) ||
           ingredients.any((ingredient) => ingredient.toLowerCase().contains(lowercaseQuery)) ||
           tags.any((tag) => tag.toLowerCase().contains(lowercaseQuery));
  }
  
  bool matchesFilters({
    List<String>? categories,
    double? maxPrice,
    double? minPrice,
    double? maxDistance,
    bool? vegetarianOnly,
    bool? veganOnly,
    bool? glutenFreeOnly,
    List<String>? excludeAllergens,
    double? minRating,
    bool? hygieneCertifiedOnly,
  }) {
    if (categories != null && categories.isNotEmpty && !categories.contains(category)) {
      return false;
    }
    
    if (maxPrice != null && price > maxPrice) return false;
    if (minPrice != null && price < minPrice) return false;
    if (maxDistance != null && distance > maxDistance) return false;
    if (vegetarianOnly == true && !isVegetarian) return false;
    if (veganOnly == true && !isVegan) return false;
    if (glutenFreeOnly == true && !isGlutenFree) return false;
    if (excludeAllergens != null && excludeAllergens.isNotEmpty) {
      if (allergens.any((allergen) => excludeAllergens.contains(allergen))) {
        return false;
      }
    }
    if (minRating != null && rating < minRating) return false;
    if (hygieneCertifiedOnly == true && !isHygieneCertified) return false;
    
    return true;
  }
  
  double get urgencyScore {
    double score = 0.0;
    
    // Time-based urgency
    final timeUntilExpiry = this.timeUntilExpiry;
    if (timeUntilExpiry.inHours < 2) score += 5.0;
    else if (timeUntilExpiry.inHours < 6) score += 3.0;
    else if (timeUntilExpiry.inHours < 12) score += 1.0;
    
    // Quantity-based urgency
    final availabilityRatio = availableQuantity / quantity;
    if (availabilityRatio < 0.1) score += 3.0;
    else if (availabilityRatio < 0.3) score += 1.5;
    
    // Discount-based urgency
    if (hasDiscount) score += 1.0;
    
    // Rating-based urgency
    if (rating >= 4.5) score += 1.0;
    
    return score;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FoodPack && other.id == id;
  }
  
  @override
  int get hashCode => id.hashCode;
  
  @override
  String toString() {
    return 'FoodPack(id: $id, title: $title, vendor: $vendorName, price: $price)';
  }
}

// Helper class for food pack statistics
class FoodPackStats {
  final int totalPacks;
  final int availablePacks;
  final int reservedPacks;
  final int expiredPacks;
  final double averagePrice;
  final double averageDiscount;
  final double averageRating;
  final Map<String, int> categoryDistribution;
  final Map<String, int> dietaryDistribution;

  FoodPackStats({
    required this.totalPacks,
    required this.availablePacks,
    required this.reservedPacks,
    required this.expiredPacks,
    required this.averagePrice,
    required this.averageDiscount,
    required this.averageRating,
    required this.categoryDistribution,
    required this.dietaryDistribution,
  });

  factory FoodPackStats.fromFoodPacks(List<FoodPack> foodPacks) {
    if (foodPacks.isEmpty) {
      return FoodPackStats(
        totalPacks: 0,
        availablePacks: 0,
        reservedPacks: 0,
        expiredPacks: 0,
        averagePrice: 0.0,
        averageDiscount: 0.0,
        averageRating: 0.0,
        categoryDistribution: {},
        dietaryDistribution: {},
      );
    }

    final categoryCount = <String, int>{};
    final dietaryCount = <String, int>{};
    
    int available = 0, reserved = 0, expired = 0;
    double totalPrice = 0.0, totalDiscount = 0.0, totalRating = 0.0;
    int discountCount = 0;

    for (final pack in foodPacks) {
      // Status counting
      if (pack.isExpired) {
        expired++;
      } else if (pack.status == 'reserved') {
        reserved++;
      } else if (pack.isAvailable) {
        available++;
      }

      // Price and rating
      totalPrice += pack.price;
      totalRating += pack.rating;

      // Discount
      if (pack.hasDiscount) {
        totalDiscount += pack.discountPercentage;
        discountCount++;
      }

      // Category distribution
      categoryCount[pack.category] = (categoryCount[pack.category] ?? 0) + 1;

      // Dietary distribution
      if (pack.isVegetarian) dietaryCount['Vegetarian'] = (dietaryCount['Vegetarian'] ?? 0) + 1;
      if (pack.isVegan) dietaryCount['Vegan'] = (dietaryCount['Vegan'] ?? 0) + 1;
      if (pack.isGlutenFree) dietaryCount['Gluten-Free'] = (dietaryCount['Gluten-Free'] ?? 0) + 1;
    }

    return FoodPackStats(
      totalPacks: foodPacks.length,
      availablePacks: available,
      reservedPacks: reserved,
      expiredPacks: expired,
      averagePrice: totalPrice / foodPacks.length,
      averageDiscount: discountCount > 0 ? totalDiscount / discountCount : 0.0,
      averageRating: totalRating / foodPacks.length,
      categoryDistribution: categoryCount,
      dietaryDistribution: dietaryCount,
    );
  }
} 