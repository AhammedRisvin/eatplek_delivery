class EarningsSummaryModel {
  final double totalEarnings;
  final double totalPaidByAdmin;
  final double pendingPayout;
  final int completedDeliveries;
  const EarningsSummaryModel(
      {required this.totalEarnings,
      required this.totalPaidByAdmin,
      required this.pendingPayout,
      required this.completedDeliveries});
}

class PayoutModel {
  final String referenceId;
  final double amount;
  final String status;
  final DateTime date;
  const PayoutModel(
      {required this.referenceId,
      required this.amount,
      required this.status,
      required this.date});
  bool get isPaid => status == 'Paid';
}

class EarningsDummyData {
  EarningsDummyData._();
  static const summary = EarningsSummaryModel(
      totalEarnings: 4000,
      totalPaidByAdmin: 3000,
      pendingPayout: 1000,
      completedDeliveries: 200);
  static final payouts = [
    PayoutModel(
        referenceId: '12345',
        amount: 1000,
        status: 'Paid',
        date: DateTime(2025, 10, 28)),
    PayoutModel(
        referenceId: '12346',
        amount: 800,
        status: 'Paid',
        date: DateTime(2025, 10, 25)),
    PayoutModel(
        referenceId: '12347',
        amount: 600,
        status: 'Paid',
        date: DateTime(2025, 10, 20)),
    PayoutModel(
        referenceId: '12348',
        amount: 500,
        status: 'Pending',
        date: DateTime(2025, 10, 15)),
    PayoutModel(
        referenceId: '12349',
        amount: 400,
        status: 'Pending',
        date: DateTime(2025, 10, 10)),
  ];
}
