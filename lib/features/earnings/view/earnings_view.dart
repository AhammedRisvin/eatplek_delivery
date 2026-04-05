import 'package:eatplek_delivery/core/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/assets.dart';
import '../../../core/utils/responsive_helper.dart';
import '../controller/earnings_controller.dart';
import '../model/earnings_dummy_model.dart';

class EarningsView extends StatelessWidget {
  const EarningsView({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<EarningsController>();
    final r = ResponsiveHelper(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        slivers: [
          // ── Collapsible header + stats ─────────────────────────────
          SliverAppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            expandedHeight: r.hp(30),
            floating: false,
            pinned: false,
            snap: false,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Padding(
                padding:
                    EdgeInsets.fromLTRB(r.s16, r.topPadding + r.s12, r.s16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Earnings',
                        style: TextStyle(
                            fontSize: r.f22,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1A1A1A))),
                    SizedBox(height: r.s16),
                    _StatsGrid(summary: c.summary, r: r),
                  ],
                ),
              ),
            ),
          ),

          // ── Recent Payouts header ──────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(r.s16, r.s20, r.s16, r.s12),
              child: Text('Recent Payouts',
                  style: TextStyle(
                      fontSize: r.f18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1A1A1A))),
            ),
          ),

          // ── Payout list ───────────────────────────────────────────
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (ctx, i) {
                final rr = ResponsiveHelper(ctx);
                return Padding(
                  padding: EdgeInsets.fromLTRB(rr.s16, 0, rr.s16, rr.s12),
                  child: _PayoutCard(payout: c.payouts[i], r: rr),
                );
              },
              childCount: c.payouts.length,
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: r.hp(14))),
        ],
      ),
    );
  }
}

// ── 4 individual cards in 2x2 grid ───────────────────────────────────────────
class _StatsGrid extends StatelessWidget {
  final EarningsSummaryModel summary;
  final ResponsiveHelper r;
  const _StatsGrid({required this.summary, required this.r});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _StatCard(
                label: 'Total Earnings',
                value: 'Rs.${summary.totalEarnings.toInt()}',
                r: r,
              ),
            ),
            SizedBox(width: r.s12),
            Expanded(
              child: _StatCard(
                label: 'Total Paid by Admin',
                value: 'Rs.${summary.totalPaidByAdmin.toInt()}',
                r: r,
              ),
            ),
          ],
        ),
        SizedBox(height: r.s12),
        Row(
          children: [
            Expanded(
              child: _StatCard(
                label: 'Pending Payout',
                value: 'Rs.${summary.pendingPayout.toInt()}',
                r: r,
              ),
            ),
            SizedBox(width: r.s12),
            Expanded(
              child: _StatCard(
                label: 'Completed Deliveries',
                value: summary.completedDeliveries.toString(),
                r: r,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final ResponsiveHelper r;
  const _StatCard({required this.label, required this.value, required this.r});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(r.s16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(r.r12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: r.s8,
            offset: Offset(0, r.s2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: r.f11, color: Colors.grey)),
          SizedBox(height: r.s6),
          Text(value,
              style: TextStyle(
                  fontSize: r.f20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1A1A1A))),
        ],
      ),
    );
  }
}

// ── Payout card ───────────────────────────────────────────────────────────────
class _PayoutCard extends StatelessWidget {
  final PayoutModel payout;
  final ResponsiveHelper r;
  const _PayoutCard({required this.payout, required this.r});

  @override
  Widget build(BuildContext context) {
    final dateStr = DateFormat('dd MMM yyyy').format(payout.date);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(r.r12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: r.s8,
            offset: Offset(0, r.s2),
          ),
        ],
      ),
      padding: EdgeInsets.all(r.s14),
      child: Row(
        children: [
          // Rupee icon in light blue circle
          Container(
              width: r.s40,
              height: r.s40,
              decoration: const BoxDecoration(
                color: Color(0xFFE8F0FE),
                shape: BoxShape.circle,
              ),
              padding: EdgeInsets.all(r.s10),
              child: SvgPicture.asset(
                AppAssets.earningsCard,
              )),
          SizedBox(width: r.s12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Reference ID : ${payout.referenceId}',
                    style: TextStyle(
                        fontSize: r.f13,
                        fontWeight: FontWeight.w600,
                        color: AppColor.black)),
                SizedBox(height: r.s3),
                Text('Amount : ${payout.amount.toInt()}',
                    style: TextStyle(fontSize: r.f12, color: Colors.grey)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Text('Status : ',
                      style: TextStyle(fontSize: r.f12, color: Colors.grey)),
                  Text(payout.status,
                      style: TextStyle(
                          fontSize: r.f12,
                          fontWeight: FontWeight.w600,
                          color: payout.isPaid
                              ? const Color(0xFF2ECC71)
                              : const Color(0xFFF39C12))),
                ],
              ),
              SizedBox(height: r.s3),
              Text('Date : $dateStr',
                  style: TextStyle(
                      fontSize: r.f11,
                      fontWeight: FontWeight.w500,
                      color: AppColor.black)),
            ],
          ),
        ],
      ),
    );
  }
}

extension _EarningsExtras on ResponsiveHelper {
  double get s3 => 3 * screenWidth / 390;
}
