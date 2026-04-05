class OrderStatus {
  static const String assigned = 'assigned';
  static const String pending = 'pending';
  static const String accepted = 'accepted';
  static const String delivered = 'delivered';
}

class HomeOrderModel {
  final String id;
  final String orderId;
  final String customerName;
  final String restaurantName;
  final String pickupLocation;
  final String deliveryLocation;
  final double distanceKm;
  final double estimatedEarning;
  final int itemCount;
  final String status;

  HomeOrderModel({
    required this.id,
    required this.orderId,
    required this.customerName,
    required this.restaurantName,
    required this.pickupLocation,
    required this.deliveryLocation,
    required this.distanceKm,
    required this.estimatedEarning,
    required this.itemCount,
    required this.status,
  });

  HomeOrderModel copyWith({String? status}) => HomeOrderModel(
        id: id,
        orderId: orderId,
        customerName: customerName,
        restaurantName: restaurantName,
        pickupLocation: pickupLocation,
        deliveryLocation: deliveryLocation,
        distanceKm: distanceKm,
        estimatedEarning: estimatedEarning,
        itemCount: itemCount,
        status: status ?? this.status,
      );
}
