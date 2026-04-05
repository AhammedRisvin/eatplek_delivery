// ignore_for_file: unused_element

import 'package:eatplek_delivery/core/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../core/utils/assets.dart';
import '../../../core/utils/responsive_helper.dart';
import '../../order_detail/models/delivery_order_model.dart';
import '../controllers/home_controller.dart';
import 'widget/order_detail_sheet.dart';
import 'widget/orders_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    final r = ResponsiveHelper(context);

    return Scaffold(
      backgroundColor: const Color(0xFFB4D6FF),
      extendBody: true,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: r.hp(30),
            child: _buildTopSection(r),
          ),
          Positioned(
            top: r.hp(30) - 20,
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildBottomCard(r),
          ),
        ],
      ),
    );
  }

  Widget _buildTopSection(ResponsiveHelper r) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFB4D6FF), Color(0xFFDDECFF)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      padding: EdgeInsets.only(
        top: r.topPadding + r.s12,
        left: r.s16,
        right: r.s16,
        bottom: r.s20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GetBuilder<HomeController>(
            id: 'home_header',
            builder: (c) => Row(
              children: [
                CircleAvatar(
                  radius: r.s22,
                  backgroundImage: const AssetImage('assets/images/avatar.png'),
                  onBackgroundImageError: (_, __) {},
                  backgroundColor: const Color(0xFFCCDDEE),
                  child: Icon(Icons.person,
                      color: const Color(0xFF042E60), size: r.i22),
                ),
                SizedBox(width: r.s10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(c.partnerName,
                          style: TextStyle(
                              fontSize: r.f15,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF1A1A1A))),
                      Text(c.partnerName,
                          style: TextStyle(
                              fontSize: r.f12, color: const Color(0xFF666666))),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: c.toggleOnline,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: r.s48,
                    height: r.s28,
                    decoration: BoxDecoration(
                      color: c.isOnline
                          ? const Color(0xFF10B981)
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(r.s14),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: r.s3),
                    child: Row(
                      mainAxisAlignment: c.isOnline
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
                        Container(
                          width: r.s22,
                          height: r.s22,
                          decoration: const BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: Center(
                            child: Text(
                              c.isOnline ? 'ON' : 'OFF',
                              style: TextStyle(
                                fontSize: r.f6,
                                fontWeight: FontWeight.bold,
                                color: c.isOnline
                                    ? const Color(0xFF2ECC71)
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: r.s10),
                Stack(
                  children: [
                    Container(
                        width: r.s38,
                        height: r.s38,
                        decoration: BoxDecoration(
                          color: AppColor.primary.withOpacity(0.1),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: r.s6)
                          ],
                        ),
                        padding: EdgeInsets.all(r.s10),
                        child: SvgPicture.asset(
                          AppAssets.bell,
                        )),
                    Positioned(
                      right: r.s8,
                      top: r.s8,
                      child: Container(
                        width: r.s8,
                        height: r.s8,
                        decoration: const BoxDecoration(
                            color: Colors.red, shape: BoxShape.circle),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: r.s38),
          Text(
            'Drive Your Success with Every\nDelivery',
            style: TextStyle(
              fontSize: r.f22,
              fontWeight: FontWeight.w900,
              color: AppColor.black,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomCard(ResponsiveHelper r) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(r.r24),
          topRight: Radius.circular(r.r24),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(r.r24),
          topRight: Radius.circular(r.r24),
        ),
        child: GetBuilder<HomeController>(
          id: 'home_tabs',
          builder: (c) => CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(r.s16, r.s20, r.s16, 0),
                  child: _StatsGrid(r: r, c: c),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: r.s16)),
              SliverPersistentHeader(
                  pinned: true, delegate: _TabDelegate(r: r)),
              if (c.selectedTab == 0)
                _buildAssignedSliver(c.assignedOrders, r)
              else
                _buildAcceptedSliver(c.acceptedOrders, r),
              SliverToBoxAdapter(child: SizedBox(height: r.hp(14))),
            ],
          ),
        ),
      ),
    );
  }

  SliverList _buildAssignedSliver(
      List<HomeOrderModel> orders, ResponsiveHelper r) {
    if (orders.isEmpty) {
      return SliverList(
        delegate: SliverChildListDelegate([
          SizedBox(
              height: r.hp(30),
              child: const Center(
                  child: Text('No assigned orders',
                      style: TextStyle(color: Colors.grey)))),
        ]),
      );
    }
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (ctx, i) {
          final rr = ResponsiveHelper(ctx);
          return Padding(
            padding: EdgeInsets.fromLTRB(
                rr.s16, i == 0 ? rr.s12 : 0, rr.s16, rr.s12),
            child: _AssignedCard(order: orders[i]),
          );
        },
        childCount: orders.length,
      ),
    );
  }

  SliverList _buildAcceptedSliver(
      List<HomeOrderModel> orders, ResponsiveHelper r) {
    if (orders.isEmpty) {
      return SliverList(
        delegate: SliverChildListDelegate([
          SizedBox(
              height: r.hp(30),
              child: const Center(
                  child: Text('No accepted orders',
                      style: TextStyle(color: Colors.grey)))),
        ]),
      );
    }
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (ctx, i) {
          final rr = ResponsiveHelper(ctx);
          final order = orders[i];
          return Padding(
            padding: EdgeInsets.fromLTRB(
                rr.s16, i == 0 ? rr.s12 : 0, rr.s16, rr.s12),
            // ── Reusing shared OrderListCard ─────────────────────────
            child: OrderListCard(
              orderId: order.orderId,
              customerName: order.customerName,
              itemCount: order.itemCount,
              status: order.status == 'pending' ? 'Pending' : order.status,
              statusColor: const Color(0xFFF39C12),
              onArrowTap: () {
                // TODO: Get.toNamed(AppRoutes.orderDetail, arguments: order)
              },
            ),
          );
        },
        childCount: orders.length,
      ),
    );
  }
}

// ── Stats grid ────────────────────────────────────────────────────────────────
class _StatsGrid extends StatelessWidget {
  final ResponsiveHelper r;
  final HomeController c;
  const _StatsGrid({required this.r, required this.c});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: _StatCard(
                    label: 'Total Orders Today',
                    value: c.stats.totalOrdersToday.toString().padLeft(2, '0'),
                    bg: const Color(0xffFAFAFA),
                    r: r)),
            SizedBox(width: r.s12),
            Expanded(
                child: _StatCard(
                    label: 'Completed',
                    value: c.stats.completed.toString(),
                    bg: const Color(0xFFFAE7F0),
                    r: r)),
          ],
        ),
        SizedBox(height: r.s12),
        Row(
          children: [
            Expanded(
                child: _StatCard(
                    label: 'Pending',
                    value: c.stats.pending.toString(),
                    bg: const Color(0xFFECEBFE),
                    r: r)),
            SizedBox(width: r.s12),
            Expanded(
                child: _StatCard(
                    label: 'Earnings Today',
                    value: 'RS.${c.stats.earningsToday.toInt()}',
                    bg: const Color(0xffFAFAFA),
                    r: r)),
          ],
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final Color bg;
  final ResponsiveHelper r;
  const _StatCard(
      {required this.label,
      required this.value,
      required this.bg,
      required this.r});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: r.s14, vertical: r.s14),
      decoration:
          BoxDecoration(color: bg, borderRadius: BorderRadius.circular(r.r16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style:
                  TextStyle(fontSize: r.f11, color: const Color(0xFFAAAAAA))),
          SizedBox(height: r.s6),
          Text(value,
              style: TextStyle(
                  fontSize: r.f22,
                  fontWeight: FontWeight.bold,
                  color: AppColor.black)),
        ],
      ),
    );
  }
}

// ── Tab delegate ──────────────────────────────────────────────────────────────
class _TabDelegate extends SliverPersistentHeaderDelegate {
  final ResponsiveHelper r;
  const _TabDelegate({required this.r});
  @override
  double get minExtent => 48;
  @override
  double get maxExtent => 48;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return GetBuilder<HomeController>(
      id: 'home_tabs',
      builder: (c) => Container(
        color: AppColor.white,
        padding: EdgeInsets.symmetric(horizontal: r.s16),
        child: Row(
          children: [
            _Tab(
                label: 'Assigned Orders',
                selected: c.selectedTab == 0,
                onTap: () => c.selectTab(0),
                r: r),
            SizedBox(width: r.s24),
            _Tab(
                label: 'Accepted Order',
                selected: c.selectedTab == 1,
                onTap: () => c.selectTab(1),
                r: r),
          ],
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate _) => true;
}

class _Tab extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final ResponsiveHelper r;
  const _Tab(
      {required this.label,
      required this.selected,
      required this.onTap,
      required this.r});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: r.f13,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.normal,
                  color: selected ? const Color(0xFF042E60) : Colors.grey)),
          SizedBox(height: r.s4),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 1.1,
            width: selected ? label.length * r.f13 * 0.3 : 0,
            decoration: BoxDecoration(
              color: const Color(0xFF042E60),
              borderRadius: BorderRadius.circular(r.s2),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Assigned card (eye icon + Accept button — unique to this screen) ──────────
class _AssignedCard extends StatelessWidget {
  final HomeOrderModel order;
  const _AssignedCard({required this.order});

  @override
  Widget build(BuildContext context) {
    final r = ResponsiveHelper(context);
    final c = Get.find<HomeController>();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(r.r14),
        border: Border.all(color: Colors.black.withOpacity(0.06)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: r.s8,
              offset: Offset(0, r.s2))
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
                      borderRadius: BorderRadius.circular(100)),
                  padding: EdgeInsets.all(r.s10),
                  child: SvgPicture.asset(
                    AppAssets.assignedOrderCardIcon,
                  )),
              SizedBox(width: r.s10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Order ID: ${order.orderId}',
                        style: TextStyle(
                            fontSize: r.f13,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1A1A1A))),
                    SizedBox(height: r.s3),
                    Text('Customer Name: ${order.customerName}',
                        style: TextStyle(fontSize: r.f12, color: Colors.grey)),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => OrderDetailSheet.show(context, order),
                child: Container(
                    width: r.s36,
                    height: r.s36,
                    decoration: const BoxDecoration(
                        color: Color(0xFF042E60), shape: BoxShape.circle),
                    padding: EdgeInsets.all(r.s10),
                    child: SvgPicture.asset(
                      AppAssets.eye,
                    )),
              ),
            ],
          ),
          SizedBox(height: r.s12),
          SizedBox(
            width: double.infinity,
            height: r.h40,
            child: ElevatedButton(
              onPressed: () => c.acceptOrder(order),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2ECC71),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(r.r8)),
              ),
              child: Text('Accept',
                  style:
                      TextStyle(fontSize: r.f14, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }
}

extension _HomeExtras on ResponsiveHelper {
  double get s2 => 2 * screenWidth / 390;
  double get s3 => 3 * screenWidth / 390;
  double get s6 => 6 * screenWidth / 390;
  double get s8 => 8 * screenWidth / 390;
  double get s10 => 10 * screenWidth / 390;
  double get s14 => 14 * screenWidth / 390;
  double get s22 => 22 * screenWidth / 390;
  double get s28 => 28 * screenWidth / 390;
  double get s36 => 36 * screenWidth / 390;
  double get s38 => 38 * screenWidth / 390;
  double get s42 => 42 * screenWidth / 390;
  double get h40 => 40 * screenHeight / 844;
  double get r10 => 10 * screenWidth / 390;
  double get r14 => 14 * screenWidth / 390;
  double get f6 => 6 * screenWidth / 390;
  double get f11 => 11 * screenWidth / 390;
  double get f22 => 22 * screenWidth / 390;
}
