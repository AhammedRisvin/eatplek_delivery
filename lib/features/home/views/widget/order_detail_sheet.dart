import 'package:flutter/material.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../order_detail/models/delivery_order_model.dart';

class OrderDetailSheet extends StatelessWidget {
  final HomeOrderModel order;
  const OrderDetailSheet({super.key, required this.order});

  static void show(BuildContext context, HomeOrderModel order) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => OrderDetailSheet(order: order),
    );
  }

  @override
  Widget build(BuildContext context) {
    final r = ResponsiveHelper(context);
    return Container(
      margin: EdgeInsets.fromLTRB(r.s16, 0, r.s16, r.s16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(r.r20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: r.s24,
            offset: Offset(0, -r.s4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // drag handle
          Container(
            margin: EdgeInsets.only(top: r.s12),
            width: r.s40,
            height: r.s4,
            decoration: BoxDecoration(
              color: const Color(0xFFDDDDDD),
              borderRadius: BorderRadius.circular(r.s2),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(r.s20, r.s16, r.s20, r.s24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order Details',
                  style: TextStyle(
                    fontSize: r.f18,
                    fontWeight: FontWeight.bold,
                    color: AppColor.black,
                  ),
                ),
                SizedBox(height: r.s16),
                _row(r, 'Order ID', order.orderId),
                _row(r, 'Restaurant', order.restaurantName),
                _row(r, 'Pickup Location', order.pickupLocation),
                _row(r, 'Delivery Location', order.deliveryLocation),
                _row(r, 'Distance', '${order.distanceKm} km'),
                _row(r, 'Estimated Earning',
                    '₹${order.estimatedEarning.toInt()} (Delivery Fee)',
                    isLast: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(ResponsiveHelper r, String label, String value,
      {bool isLast = false}) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: r.s12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: r.wp(38),
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: r.f13,
                    color: const Color(0xFF888888),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  value,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: r.f13,
                    fontWeight: FontWeight.w600,
                    color: AppColor.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (!isLast)
          const Divider(color: Color(0xFFF0F0F0), height: 1, thickness: 1),
      ],
    );
  }
}
