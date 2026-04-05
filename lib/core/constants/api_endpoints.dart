// TODO: wire up real endpoints when backend is ready
class ApiEndpoints {
  ApiEndpoints._();

  static const String baseUrl = 'https://eatplek-server-dev.onrender.com';

  static const String vendorLogin = '/api/delivery/auth/vendor/login';
  static const String adminLogin = '/api/delivery/auth/admin/login';
  static const String refreshToken = '/api/delivery/auth/refresh-token';
  static const String logout = '/api/delivery/auth/logout';

  static const String profile = '/api/delivery/profile';
  static const String updateProfile = '/api/delivery/profile/update';
  static const String updateFcmToken = '/api/delivery/profile/fcm-token';
  static const String toggleOnlineStatus = '/api/delivery/profile/status';

  static const String availableOrders = '/api/delivery/orders/available';
  static const String myOrders = '/api/delivery/orders/my';
  static const String orderDetail = '/api/delivery/orders';
  static const String acceptOrder = '/api/delivery/orders/accept';
  static const String rejectOrder = '/api/delivery/orders/reject';
  static const String updateOrderStatus = '/api/delivery/orders/status';
  static const String orderHistory = '/api/delivery/orders/history';

  static const String earningsSummary = '/api/delivery/earnings/summary';
  static const String earningsHistory = '/api/delivery/earnings/history';

  static const String updateLocation = '/api/delivery/location/update';
}
