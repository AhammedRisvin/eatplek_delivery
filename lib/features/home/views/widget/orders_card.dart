import 'package:eatplek_delivery/core/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/responsive_helper.dart';

/// Reusable order card used in both History and Accepted Orders tabs.
class OrderListCard extends StatelessWidget {
  final String orderId;
  final String customerName;
  final int itemCount;
  final String status;
  final Color statusColor;
  final VoidCallback? onArrowTap;

  const OrderListCard({
    super.key,
    required this.orderId,
    required this.customerName,
    required this.itemCount,
    required this.status,
    this.statusColor = const Color(0xFF2ECC71),
    this.onArrowTap,
  });

  @override
  Widget build(BuildContext context) {
    final r = ResponsiveHelper(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(r.r14),
        border: Border.all(color: Colors.black.withOpacity(0.06)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: r.s8,
            offset: Offset(0, r.s2),
          ),
        ],
      ),
      padding: EdgeInsets.all(r.s14),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  width: r.s42,
                  height: r.s42,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEF2FF),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  padding: EdgeInsets.all(r.s10),
                  child: SvgPicture.asset(
                    AppAssets.assignedOrderCardIcon,
                  )),
              SizedBox(width: r.s10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Order ID: $orderId',
                        style: TextStyle(
                            fontSize: r.f13,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1A1A1A))),
                    SizedBox(height: r.s3),
                    Text('Customer Name: $customerName',
                        style: TextStyle(fontSize: r.f12, color: Colors.grey)),
                  ],
                ),
              ),
              GestureDetector(
                onTap: onArrowTap,
                child: Container(
                  width: r.s36,
                  height: r.s36,
                  decoration: const BoxDecoration(
                      color: Color(0xFF042E60), shape: BoxShape.circle),
                  child: Icon(Icons.arrow_outward_rounded,
                      color: Colors.white, size: r.i18),
                ),
              ),
            ],
          ),
          SizedBox(height: r.s10),
          Row(
            children: [
              Text('Items: $itemCount',
                  style: TextStyle(fontSize: r.f12, color: Colors.grey)),
              const Spacer(),
              Text('Status: ',
                  style: TextStyle(fontSize: r.f12, color: Colors.grey)),
              Text(status,
                  style: TextStyle(
                      fontSize: r.f12,
                      fontWeight: FontWeight.w600,
                      color: statusColor)),
            ],
          ),
        ],
      ),
    );
  }
}

extension _CardExtras on ResponsiveHelper {
  double get s3 => 3 * screenWidth / 390;
  double get s42 => 42 * screenWidth / 390;
}
