class HistoryOrderModel {
  final String id;
  final String orderId;
  final String customerName;
  final int itemCount;
  final String status;
  const HistoryOrderModel(
      {required this.id,
      required this.orderId,
      required this.customerName,
      required this.itemCount,
      required this.status});
}

class HistoryDummyData {
  HistoryDummyData._();
  static const orders = [
    HistoryOrderModel(
        id: '1',
        orderId: '#ORD-1204',
        customerName: 'Rahul Sharma',
        itemCount: 8,
        status: 'Completed'),
    HistoryOrderModel(
        id: '2',
        orderId: '#ORD-1203',
        customerName: 'Priya Nair',
        itemCount: 3,
        status: 'Completed'),
    HistoryOrderModel(
        id: '3',
        orderId: '#ORD-1202',
        customerName: 'Arun Kumar',
        itemCount: 5,
        status: 'Completed'),
    HistoryOrderModel(
        id: '4',
        orderId: '#ORD-1201',
        customerName: 'Meera Krishnan',
        itemCount: 2,
        status: 'Completed'),
    HistoryOrderModel(
        id: '5',
        orderId: '#ORD-1200',
        customerName: 'Sanjay Mehta',
        itemCount: 4,
        status: 'Completed'),
    HistoryOrderModel(
        id: '6',
        orderId: '#ORD-1199',
        customerName: 'Lakshmi Devi',
        itemCount: 6,
        status: 'Completed'),
    HistoryOrderModel(
        id: '7',
        orderId: '#ORD-1198',
        customerName: 'Fathima Beevi',
        itemCount: 1,
        status: 'Completed'),
  ];
}
