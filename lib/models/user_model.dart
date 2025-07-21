class User {
  final String id;
  final String email;
  final String name;
  final String phone;
  final String? profileImage;
  final String role; // 'user', 'vendor', 'admin'
  final DateTime createdAt;
  final DateTime lastActive;
  final bool isVerified;
  final double rating;
  final int totalOrders;
  final List<String> preferences;
  final Map<String, dynamic> location;
  final bool isActive;
  final List<String> favoriteVendors;
  final Map<String, dynamic>? settings;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    this.profileImage,
    required this.role,
    required this.createdAt,
    required this.lastActive,
    required this.isVerified,
    required this.rating,
    required this.totalOrders,
    required this.preferences,
    required this.location,
    required this.isActive,
    required this.favoriteVendors,
    this.settings,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      profileImage: json['profileImage'],
      role: json['role'] ?? 'user',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      lastActive: DateTime.parse(json['lastActive'] ?? DateTime.now().toIso8601String()),
      isVerified: json['isVerified'] ?? false,
      rating: (json['rating'] ?? 0.0).toDouble(),
      totalOrders: json['totalOrders'] ?? 0,
      preferences: List<String>.from(json['preferences'] ?? []),
      location: Map<String, dynamic>.from(json['location'] ?? {}),
      isActive: json['isActive'] ?? true,
      favoriteVendors: List<String>.from(json['favoriteVendors'] ?? []),
      settings: json['settings'] != null ? Map<String, dynamic>.from(json['settings']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'profileImage': profileImage,
      'role': role,
      'createdAt': createdAt.toIso8601String(),
      'lastActive': lastActive.toIso8601String(),
      'isVerified': isVerified,
      'rating': rating,
      'totalOrders': totalOrders,
      'preferences': preferences,
      'location': location,
      'isActive': isActive,
      'favoriteVendors': favoriteVendors,
      'settings': settings,
    };
  }

  User copyWith({
    String? id,
    String? email,
    String? name,
    String? phone,
    String? profileImage,
    String? role,
    DateTime? createdAt,
    DateTime? lastActive,
    bool? isVerified,
    double? rating,
    int? totalOrders,
    List<String>? preferences,
    Map<String, dynamic>? location,
    bool? isActive,
    List<String>? favoriteVendors,
    Map<String, dynamic>? settings,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      profileImage: profileImage ?? this.profileImage,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      lastActive: lastActive ?? this.lastActive,
      isVerified: isVerified ?? this.isVerified,
      rating: rating ?? this.rating,
      totalOrders: totalOrders ?? this.totalOrders,
      preferences: preferences ?? this.preferences,
      location: location ?? this.location,
      isActive: isActive ?? this.isActive,
      favoriteVendors: favoriteVendors ?? this.favoriteVendors,
      settings: settings ?? this.settings,
    );
  }
} 