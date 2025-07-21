import 'package:flutter/material.dart';
import '../../themes/modern_theme.dart';
import '../../widgets/modern/glass_card.dart';
import '../../constants/app_constants.dart';

class NotificationCenter extends StatefulWidget {
  const NotificationCenter({super.key});

  @override
  State<NotificationCenter> createState() => _NotificationCenterState();
}

class _NotificationCenterState extends State<NotificationCenter>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  
  final List<NotificationItem> _notifications = _generateMockNotifications();
  bool _showUnreadOnly = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
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

  void _toggleUnreadOnly() {
    setState(() {
      _showUnreadOnly = !_showUnreadOnly;
    });
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in _notifications) {
        notification.isRead = true;
      }
    });
  }

  void _onNotificationTap(NotificationItem notification) {
    setState(() {
      notification.isRead = true;
    });
    
    // TODO: Navigate based on notification type
    switch (notification.type) {
      case NotificationTypes.orderConfirmation:
        // Navigate to order detail
        break;
      case NotificationTypes.newPackAvailable:
        // Navigate to food packs
        break;
      case NotificationTypes.hygieneAlert:
        // Show hygiene details
        break;
      default:
        break;
    }
  }

  List<NotificationItem> get _filteredNotifications {
    if (_showUnreadOnly) {
      return _notifications.where((n) => !n.isRead).toList();
    }
    return _notifications;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              _showUnreadOnly ? Icons.filter_list : Icons.filter_list_outlined,
              color: _showUnreadOnly ? ModernColors.electricBlue : ModernColors.textSecondary,
            ),
            onPressed: _toggleUnreadOnly,
          ),
          IconButton(
            icon: const Icon(Icons.done_all),
            onPressed: _markAllAsRead,
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: ModernGradients.darkGradient,
        ),
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _slideAnimation.value),
              child: Opacity(
                opacity: _fadeAnimation.value,
                child: _filteredNotifications.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                        padding: const EdgeInsets.all(ModernSpacing.lg),
                        itemCount: _filteredNotifications.length,
                        itemBuilder: (context, index) {
                          return _buildNotificationItem(_filteredNotifications[index]);
                        },
                      ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_none,
            size: 64,
            color: ModernColors.textSecondary,
          ),
          const SizedBox(height: ModernSpacing.lg),
          Text(
            'No notifications',
            style: ModernTextStyles.headlineMedium,
          ),
          const SizedBox(height: ModernSpacing.md),
          Text(
            _showUnreadOnly 
                ? 'You\'re all caught up!'
                : 'You\'ll see important updates here',
            style: ModernTextStyles.bodyMedium.copyWith(
              color: ModernColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(NotificationItem notification) {
    return GlassCard(
      margin: const EdgeInsets.only(bottom: ModernSpacing.md),
      borderColor: notification.isRead 
          ? Colors.transparent 
          : _getNotificationColor(notification.type).withOpacity(0.5),
      borderWidth: notification.isRead ? 0 : 2.0,
      onTap: () => _onNotificationTap(notification),
      child: Padding(
        padding: const EdgeInsets.all(ModernSpacing.lg),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Notification icon
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: _getNotificationColor(notification.type).withOpacity(0.2),
                borderRadius: BorderRadius.circular(ModernBorderRadius.full),
              ),
              child: Icon(
                _getNotificationIcon(notification.type),
                color: _getNotificationColor(notification.type),
                size: 24,
              ),
            ),
            
            const SizedBox(width: ModernSpacing.md),
            
            // Notification content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notification.title,
                          style: ModernTextStyles.titleMedium.copyWith(
                            fontWeight: notification.isRead ? FontWeight.normal : FontWeight.w600,
                          ),
                        ),
                      ),
                      if (!notification.isRead)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _getNotificationColor(notification.type),
                            borderRadius: BorderRadius.circular(ModernBorderRadius.full),
                          ),
                        ),
                    ],
                  ),
                  
                  const SizedBox(height: ModernSpacing.xs),
                  
                  Text(
                    notification.message,
                    style: ModernTextStyles.bodyMedium.copyWith(
                      color: ModernColors.textSecondary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: ModernSpacing.sm),
                  
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 14,
                        color: ModernColors.textTertiary,
                      ),
                      const SizedBox(width: ModernSpacing.xs),
                      Text(
                        _formatTimeAgo(notification.timestamp),
                        style: ModernTextStyles.bodySmall.copyWith(
                          color: ModernColors.textTertiary,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: ModernSpacing.sm,
                          vertical: ModernSpacing.xs,
                        ),
                        decoration: BoxDecoration(
                          color: _getNotificationColor(notification.type).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(ModernBorderRadius.sm),
                        ),
                        child: Text(
                          NotificationTypes.typeLabels[notification.type] ?? notification.type,
                          style: ModernTextStyles.labelSmall.copyWith(
                            color: _getNotificationColor(notification.type),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getNotificationColor(String type) {
    switch (type) {
      case NotificationTypes.orderConfirmation:
        return ModernColors.success;
      case NotificationTypes.orderUpdate:
        return ModernColors.info;
      case NotificationTypes.orderCancelled:
        return ModernColors.error;
      case NotificationTypes.newPackAvailable:
        return ModernColors.electricBlue;
      case NotificationTypes.packExpiring:
        return ModernColors.warning;
      case NotificationTypes.hygieneAlert:
        return ModernColors.error;
      case NotificationTypes.systemUpdate:
        return ModernColors.neonPurple;
      case NotificationTypes.promotional:
        return ModernColors.neonPink;
      default:
        return ModernColors.textSecondary;
    }
  }

  IconData _getNotificationIcon(String type) {
    switch (type) {
      case NotificationTypes.orderConfirmation:
        return Icons.check_circle;
      case NotificationTypes.orderUpdate:
        return Icons.update;
      case NotificationTypes.orderCancelled:
        return Icons.cancel;
      case NotificationTypes.newPackAvailable:
        return Icons.restaurant_menu;
      case NotificationTypes.packExpiring:
        return Icons.access_time;
      case NotificationTypes.hygieneAlert:
        return Icons.health_and_safety;
      case NotificationTypes.systemUpdate:
        return Icons.system_update;
      case NotificationTypes.promotional:
        return Icons.local_offer;
      default:
        return Icons.notifications;
    }
  }

  String _formatTimeAgo(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);
    
    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }
}

class NotificationItem {
  final String id;
  final String title;
  final String message;
  final String type;
  final DateTime timestamp;
  bool isRead;

  NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.timestamp,
    this.isRead = false,
  });
}

// Mock data generator
List<NotificationItem> _generateMockNotifications() {
  return [
    NotificationItem(
      id: '1',
      title: 'Order Confirmed',
      message: 'Your order #1234 has been confirmed and is ready for pickup.',
      type: NotificationTypes.orderConfirmation,
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      isRead: false,
    ),
    NotificationItem(
      id: '2',
      title: 'New Food Pack Available',
      message: 'Fresh pasta carbonara is now available at Tasty Bites!',
      type: NotificationTypes.newPackAvailable,
      timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
      isRead: false,
    ),
    NotificationItem(
      id: '3',
      title: 'Hygiene Alert',
      message: 'Vendor "QuickBites" has a hygiene score below 7.0.',
      type: NotificationTypes.hygieneAlert,
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      isRead: true,
    ),
    NotificationItem(
      id: '4',
      title: 'Order Update',
      message: 'Your order #1235 pickup time has been updated.',
      type: NotificationTypes.orderUpdate,
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      isRead: true,
    ),
    NotificationItem(
      id: '5',
      title: 'Special Offer',
      message: 'Get 20% off on all Italian food packs this weekend!',
      type: NotificationTypes.promotional,
      timestamp: DateTime.now().subtract(const Duration(hours: 3)),
      isRead: true,
    ),
    NotificationItem(
      id: '6',
      title: 'System Maintenance',
      message: 'Scheduled maintenance will occur tonight at 2 AM.',
      type: NotificationTypes.systemUpdate,
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      isRead: true,
    ),
  ];
} 