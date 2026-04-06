class DeliveryStatus {
  static const String pickedUp = 'picked_up';
  static const String outOfDelivery = 'out_of_delivery';
  static const String delivered = 'delivered';
}

class OrderDetailModel {
  final String orderId;
  final String customerName;
  final String customerPhone;
  final String paymentMode; // 'Online (Paid)' or 'COD'
  final double amountToCollect; // only for COD
  final String deliveryAddress;
  final double? deliveryLat;
  final double? deliveryLng;
  final VendorDetailModel vendor;
  final List<OrderItemModel> items;
  final double totalAmount;
  String status;

  OrderDetailModel({
    required this.orderId,
    required this.customerName,
    required this.customerPhone,
    required this.paymentMode,
    required this.amountToCollect,
    required this.deliveryAddress,
    this.deliveryLat,
    this.deliveryLng,
    required this.vendor,
    required this.items,
    required this.totalAmount,
    this.status = DeliveryStatus.pickedUp,
  });
}

class VendorDetailModel {
  final String name;
  final String address;
  final String? imageUrl;
  final double? lat;
  final double? lng;

  const VendorDetailModel({
    required this.name,
    required this.address,
    this.imageUrl,
    this.lat,
    this.lng,
  });
}

class OrderItemModel {
  final String name;
  final String? imageUrl;
  final int quantity;
  final double price;

  const OrderItemModel({
    required this.name,
    this.imageUrl,
    required this.quantity,
    required this.price,
  });
}

class OrderDetailDummyData {
  OrderDetailDummyData._();

  static OrderDetailModel onlineOrder() => OrderDetailModel(
        orderId: '#EAT1054',
        customerName: 'Rahul Sharma',
        customerPhone: '+91 98765 43210',
        paymentMode: 'Online (Paid)',
        amountToCollect: 0,
        deliveryAddress: '45, Rose Villa, MG Road, Kochi',
        deliveryLat: 9.9312,
        deliveryLng: 76.2673,
        vendor: const VendorDetailModel(
          name: 'Nibraz Resturant',
          address: 'KSRTC Complex, Puzhathi Housing Colony, Kannur, Kerala',
          lat: 11.8745,
          lng: 75.3704,
        ),
        items: const [
          OrderItemModel(
              name: 'Classic Chicken Burger', quantity: 1, price: 180),
          OrderItemModel(name: 'Extra Cheese', quantity: 1, price: 40),
          OrderItemModel(name: 'Double Patty', quantity: 1, price: 340),
        ],
        totalAmount: 560,
      );

  static OrderDetailModel codOrder() => OrderDetailModel(
        orderId: '#EAT1055',
        customerName: 'Rahul Sharma',
        customerPhone: '+91 98765 43210',
        paymentMode: 'COD',
        amountToCollect: 401,
        deliveryAddress: '45, Rose Villa, MG Road, Kochi',
        deliveryLat: 9.9312,
        deliveryLng: 76.2673,
        vendor: const VendorDetailModel(
          name: 'Nibraz Resturant',
          address: 'KSRTC Complex, Puzhathi Housing Colony, Kannur, Kerala',
          lat: 11.8745,
          lng: 75.3704,
        ),
        items: const [
          OrderItemModel(
              name: 'Classic Chicken Burger', quantity: 1, price: 180),
          OrderItemModel(name: 'Extra Cheese', quantity: 1, price: 40),
          OrderItemModel(name: 'Double Patty', quantity: 1, price: 340),
        ],
        totalAmount: 401,
      );
}
