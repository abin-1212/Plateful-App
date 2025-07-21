class Order {
  final String id;
  final String userId;
  final String foodPackId;
  final String vendorId;
  final String status; // 'pending', 'confirmed', 'picked_up', 'cancelled', 'expired'
  final int quantity;
  final double totalPrice;
  final DateTime orderTime;
  final DateTime? pickupTime;
  final DateTime? completedTime;
  final DateTime? cancelledTime;
  final String? cancellationReason;
  final String? qrCode;
  final Map<String, dynamic>? userFeedback;
  final double? userRating;
  final String? userReview;
  final bool isPaid;
  final String paymentMethod;
  final String? paymentId;
  final Map<String, dynamic>? location;
  final String? specialInstructions;
  final bool isUrgent;
  final DateTime createdAt;
  final DateTime updatedAt;

  Order({
    required this.id,
    required this.userId,
    required this.foodPackId,
    required this.vendorId,
    required this.status,
    required this.quantity,
    required this.totalPrice,
    required this.orderTime,
    this.pickupTime,
    this.completedTime,
    this.cancelledTime,
    this.cancellationReason,
    this.qrCode,
    this.userFeedback,
    this.userRating,
    this.userReview,
    required this.isPaid,
    required this.paymentMethod,
    this.paymentId,
    this.location,
    this.specialInstructions,
    required this.isUrgent,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      foodPackId: json['foodPackId'] ?? '',
      vendorId: json['vendorId'] ?? '',
      status: json['status'] ?? 'pending',
      quantity: json['quantity'] ?? 0,
      totalPrice: (json['totalPrice'] ?? 0.0).toDouble(),
      orderTime: DateTime.parse(json['orderTime'] ?? DateTime.now().toIso8601String()),
      pickupTime: json['pickupTime'] != null ? DateTime.parse(json['pickupTime']) : null,
      completedTime: json['completedTime'] != null ? DateTime.parse(json['completedTime']) : null,
      cancelledTime: json['cancelledTime'] != null ? DateTime.parse(json['cancelledTime']) : null,
      cancellationReason: json['cancellationReason'],
      qrCode: json['qrCode'],
      userFeedback: json['userFeedback'] != null ? Map<String, dynamic>.from(json['userFeedback']) : null,
      userRating: json['userRating'] != null ? (json['userRating'] as num).toDouble() : null,
      userReview: json['userReview'],
      isPaid: json['isPaid'] ?? false,
      paymentMethod: json['paymentMethod'] ?? 'cash',
      paymentId: json['paymentId'],
      location: json['location'] != null ? Map<String, dynamic>.from(json['location']) : null,
      specialInstructions: json['specialInstructions'],
      isUrgent: json['isUrgent'] ?? false,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'foodPackId': foodPackId,
      'vendorId': vendorId,
      'status': status,
      'quantity': quantity,
      'totalPrice': totalPrice,
      'orderTime': orderTime.toIso8601String(),
      'pickupTime': pickupTime?.toIso8601String(),
      'completedTime': completedTime?.toIso8601String(),
      'cancelledTime': cancelledTime?.toIso8601String(),
      'cancellationReason': cancellationReason,
      'qrCode': qrCode,
      'userFeedback': userFeedback,
      'userRating': userRating,
      'userReview': userReview,
      'isPaid': isPaid,
      'paymentMethod': paymentMethod,
      'paymentId': paymentId,
      'location': location,
      'specialInstructions': specialInstructions,
      'isUrgent': isUrgent,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  bool get isActive => status == 'pending' || status == 'confirmed';
  bool get isCompleted => status == 'picked_up';
  bool get isCancelled => status == 'cancelled';
  bool get isExpired => status == 'expired';
  bool get canBeCancelled => status == 'pending' || status == 'confirmed';

  Order copyWith({
    String? id,
    String? userId,
    String? foodPackId,
    String? vendorId,
    String? status,
    int? quantity,
    double? totalPrice,
    DateTime? orderTime,
    DateTime? pickupTime,
    DateTime? completedTime,
    DateTime? cancelledTime,
    String? cancellationReason,
    String? qrCode,
    Map<String, dynamic>? userFeedback,
    double? userRating,
    String? userReview,
    bool? isPaid,
    String? paymentMethod,
    String? paymentId,
    Map<String, dynamic>? location,
    String? specialInstructions,
    bool? isUrgent,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Order(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      foodPackId: foodPackId ?? this.foodPackId,
      vendorId: vendorId ?? this.vendorId,
      status: status ?? this.status,
      quantity: quantity ?? this.quantity,
      totalPrice: totalPrice ?? this.totalPrice,
      orderTime: orderTime ?? this.orderTime,
      pickupTime: pickupTime ?? this.pickupTime,
      completedTime: completedTime ?? this.completedTime,
      cancelledTime: cancelledTime ?? this.cancelledTime,
      cancellationReason: cancellationReason ?? this.cancellationReason,
      qrCode: qrCode ?? this.qrCode,
      userFeedback: userFeedback ?? this.userFeedback,
      userRating: userRating ?? this.userRating,
      userReview: userReview ?? this.userReview,
      isPaid: isPaid ?? this.isPaid,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentId: paymentId ?? this.paymentId,
      location: location ?? this.location,
      specialInstructions: specialInstructions ?? this.specialInstructions,
      isUrgent: isUrgent ?? this.isUrgent,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
} 