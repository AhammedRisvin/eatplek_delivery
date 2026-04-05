import '../../order_detail/models/delivery_order_model.dart';

class DummyData {
  DummyData._();

  static const String partnerName = 'Aswin Syam';
  static const String partnerSub = 'Aswin Syam';

  static final HomeStats stats = HomeStats(
    totalOrdersToday: 6,
    completed: 374,
    pending: 354,
    earningsToday: 200.0,
  );

  static final List<HomeOrderModel> assignedOrders = [
    HomeOrderModel(
        id: '1',
        orderId: '#ORD-1204',
        customerName: 'Rahul Sharma',
        restaurantName: 'Al Mandi Hub',
        pickupLocation: 'Manjeri Town',
        deliveryLocation: 'Pandikkad Junction',
        distanceKm: 3.2,
        estimatedEarning: 40.0,
        itemCount: 8,
        status: OrderStatus.assigned),
    HomeOrderModel(
        id: '2',
        orderId: '#ORD-1205',
        customerName: 'Priya Nair',
        restaurantName: 'Biryani House',
        pickupLocation: 'Calicut Road',
        deliveryLocation: 'Medical College',
        distanceKm: 2.1,
        estimatedEarning: 30.0,
        itemCount: 3,
        status: OrderStatus.assigned),
    HomeOrderModel(
        id: '5',
        orderId: '#ORD-1207',
        customerName: 'Arun Kumar',
        restaurantName: 'Spice Garden',
        pickupLocation: 'Town Center',
        deliveryLocation: 'Railway Station',
        distanceKm: 1.8,
        estimatedEarning: 25.0,
        itemCount: 5,
        status: OrderStatus.assigned),
    HomeOrderModel(
        id: '6',
        orderId: '#ORD-1208',
        customerName: 'Meera Krishnan',
        restaurantName: 'Kerala Kitchen',
        pickupLocation: 'Bus Stand',
        deliveryLocation: 'Hill View Colony',
        distanceKm: 4.5,
        estimatedEarning: 55.0,
        itemCount: 2,
        status: OrderStatus.assigned),
    HomeOrderModel(
        id: '7',
        orderId: '#ORD-1209',
        customerName: 'Sanjay Mehta',
        restaurantName: 'Pizza Point',
        pickupLocation: 'City Mall',
        deliveryLocation: 'Green Park',
        distanceKm: 2.8,
        estimatedEarning: 35.0,
        itemCount: 4,
        status: OrderStatus.assigned),
    HomeOrderModel(
        id: '8',
        orderId: '#ORD-1210',
        customerName: 'Lakshmi Devi',
        restaurantName: 'Dosa Corner',
        pickupLocation: 'Market Road',
        deliveryLocation: 'Westhill',
        distanceKm: 3.6,
        estimatedEarning: 45.0,
        itemCount: 6,
        status: OrderStatus.assigned),
  ];

  static final List<HomeOrderModel> acceptedOrders = [
    HomeOrderModel(
        id: '3',
        orderId: '#ORD-1204',
        customerName: 'Rahul Sharma',
        restaurantName: 'Al Mandi Hub',
        pickupLocation: 'Manjeri Town',
        deliveryLocation: 'Pandikkad Junction',
        distanceKm: 3.2,
        estimatedEarning: 40.0,
        itemCount: 8,
        status: OrderStatus.pending),
    HomeOrderModel(
        id: '4',
        orderId: '#ORD-1206',
        customerName: 'Rahul Sharma',
        restaurantName: 'Spice Garden',
        pickupLocation: 'Town Center',
        deliveryLocation: 'Railway Station',
        distanceKm: 1.8,
        estimatedEarning: 25.0,
        itemCount: 5,
        status: OrderStatus.pending),
    HomeOrderModel(
        id: '9',
        orderId: '#ORD-1211',
        customerName: 'Fathima Beevi',
        restaurantName: 'Malabar Cafe',
        pickupLocation: 'Old Bus Stand',
        deliveryLocation: 'Medical College Rd',
        distanceKm: 2.4,
        estimatedEarning: 30.0,
        itemCount: 3,
        status: OrderStatus.pending),
    HomeOrderModel(
        id: '10',
        orderId: '#ORD-1212',
        customerName: 'Rajan Pillai',
        restaurantName: 'Thalassery Hub',
        pickupLocation: 'Fort Road',
        deliveryLocation: 'Azhikode',
        distanceKm: 5.1,
        estimatedEarning: 60.0,
        itemCount: 7,
        status: OrderStatus.pending),
    HomeOrderModel(
        id: '11',
        orderId: '#ORD-1213',
        customerName: 'Divya Menon',
        restaurantName: 'Curry Leaf',
        pickupLocation: 'Thavakkara',
        deliveryLocation: 'Chirakkal',
        distanceKm: 3.9,
        estimatedEarning: 48.0,
        itemCount: 4,
        status: OrderStatus.pending),
  ];
}

class HomeStats {
  final int totalOrdersToday;
  final int completed;
  final int pending;
  final double earningsToday;
  HomeStats(
      {required this.totalOrdersToday,
      required this.completed,
      required this.pending,
      required this.earningsToday});
}
