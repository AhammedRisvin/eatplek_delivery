import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/utils/responsive_helper.dart';
import '../../home/views/widget/orders_card.dart';
import '../controller/history_controller.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<HistoryController>();
    final r = ResponsiveHelper(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  r.s16, r.topPadding + r.s16, r.s16, r.s20),
              child: Text('History',
                  style: TextStyle(
                      fontSize: r.f22,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1A1A1A))),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (ctx, i) {
                final rr = ResponsiveHelper(ctx);
                final order = c.orders[i];
                return Padding(
                  padding: EdgeInsets.fromLTRB(rr.s16, 0, rr.s16, rr.s12),
                  child: OrderListCard(
                    orderId: order.orderId,
                    customerName: order.customerName,
                    itemCount: order.itemCount,
                    status: order.status,
                    statusColor: const Color(0xFF2ECC71),
                    onArrowTap: () {
                      Get.toNamed(AppRoutes.orderDetail); //, arguments: order
                    },
                  ),
                );
              },
              childCount: c.orders.length,
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: r.hp(14))),
        ],
      ),
    );
  }
}
