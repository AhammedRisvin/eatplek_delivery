// ignore_for_file: deprecated_member_use, unused_local_variable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eatplek_delivery/core/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../core/utils/responsive_helper.dart';
import '../controller/order_details_controller.dart';
import '../model/order_details_dummy_model.dart';

class OrderDetailView extends StatelessWidget {
  const OrderDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(OrderDetailController());
    final r = ResponsiveHelper(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 198, 222, 251),
              Color.fromARGB(255, 232, 241, 253)
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // ── App bar ─────────────────────────────────────────────
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: r.s16, vertical: r.s12),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: Get.back,
                      child: Container(
                        width: r.s36,
                        height: r.s36,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(r.r8),
                            border: Border.all(
                                color: AppColor.black.withOpacity(0.06))),
                        child: Icon(Icons.arrow_back_ios_new_rounded,
                            size: r.i16, color: const Color(0xFF042E60)),
                      ),
                    ),
                    Expanded(
                      child: Text('Order Details',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: r.f18,
                              fontWeight: FontWeight.bold,
                              color: AppColor.black)),
                    ),
                    SizedBox(width: r.s36),
                  ],
                ),
              ),

              // ── Scrollable body ─────────────────────────────────────
              Expanded(
                child: GetBuilder<OrderDetailController>(
                  id: 'order_detail',
                  builder: (c) => SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(r.s16, r.s4, r.s16, r.s24),
                    child: Column(
                      children: [
                        // ── Status chips ───────────────────────────
                        _card(r, child: _StatusChips(c: c, r: r)),
                        SizedBox(height: r.s12),

                        // ── State-specific sections ────────────────
                        if (c.isOutOfDelivery) ...[
                          _AmountCard(c: c, r: r),
                          SizedBox(height: r.s12),
                          _OtpCard(c: c, r: r),
                          SizedBox(height: r.s12),
                        ],

                        if (c.isDelivered) ...[
                          _DeliveredCard(r: r),
                          SizedBox(height: r.s12),
                        ],

                        // ── Customer info ──────────────────────────
                        _CustomerCard(c: c, r: r),
                        SizedBox(height: r.s12),

                        // ── Vendor info ────────────────────────────
                        _VendorCard(c: c, r: r),
                        SizedBox(height: r.s12),

                        // ── Items ──────────────────────────────────
                        _ItemsCard(c: c, r: r),
                        SizedBox(height: r.s12),

                        // ── Order summary (Picked Up only) ─────────
                        if (c.isPickedUp) _OrderSummaryCard(c: c, r: r),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Card wrapper ──────────────────────────────────────────────────────────────
Widget _card(ResponsiveHelper r, {required Widget child, Color? bg}) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(r.s16),
    decoration: BoxDecoration(
      color: bg ?? Colors.white,
      borderRadius: BorderRadius.circular(r.r20),
      border: Border.all(color: AppColor.black.withOpacity(0.06)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.04),
          blurRadius: r.s8,
          offset: Offset(0, r.s2),
        ),
      ],
    ),
    child: child,
  );
}

// ── Section title ─────────────────────────────────────────────────────────────
Widget _sectionTitle(String title, ResponsiveHelper r, {Widget? trailing}) {
  return Row(
    children: [
      Text(title,
          style: TextStyle(
              fontSize: r.f16,
              fontWeight: FontWeight.bold,
              color: AppColor.black)),
      if (trailing != null) ...[const Spacer(), trailing],
    ],
  );
}

// ── Info row ──────────────────────────────────────────────────────────────────
Widget _infoRow(ResponsiveHelper r, String label, Widget valueWidget,
    {bool isLast = false}) {
  return Column(
    children: [
      Padding(
        padding: isLast
            ? EdgeInsets.only(top: r.s10)
            : EdgeInsets.symmetric(vertical: r.s10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: r.wp(38),
              child: Text(label,
                  style: TextStyle(
                      fontSize: r.f13, color: const Color(0xff262626))),
            ),
            Expanded(child: valueWidget),
          ],
        ),
      ),
    ],
  );
}

// ── Status chips ──────────────────────────────────────────────────────────────
class _StatusChips extends StatelessWidget {
  final OrderDetailController c;
  final ResponsiveHelper r;
  const _StatusChips({required this.c, required this.r});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Status updates',
            style: TextStyle(
                fontSize: r.f16,
                fontWeight: FontWeight.bold,
                color: AppColor.black)),
        SizedBox(height: r.s12),
        Row(
          children: [
            _Chip(
              label: 'Picked Up',
              active: c.isPickedUp || c.isOutOfDelivery || c.isDelivered,
              onTap: () => c.onChipTap(DeliveryStatus.pickedUp),
              r: r,
            ),
            SizedBox(width: r.s8),
            _Chip(
              label: 'Out of Delivery',
              active: c.isOutOfDelivery || c.isDelivered,
              onTap: () => c.onChipTap(DeliveryStatus.outOfDelivery),
              r: r,
            ),
            SizedBox(width: r.s8),
            _Chip(
              label: 'Delivered',
              active: c.isDelivered,
              onTap: () => c.onChipTap(DeliveryStatus.delivered),
              r: r,
            ),
          ],
        ),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;
  final ResponsiveHelper r;
  const _Chip(
      {required this.label,
      required this.active,
      required this.onTap,
      required this.r});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: r.s12, vertical: r.s6),
        decoration: BoxDecoration(
          color: active
              ? const Color(0xFF00C986)
              : const Color(0xFF042E60).withOpacity(0.1),
          borderRadius: BorderRadius.circular(r.r20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: r.f12,
            fontWeight: FontWeight.w600,
            color: active ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}

// ── Amount to collect card ────────────────────────────────────────────────────
class _AmountCard extends StatelessWidget {
  final OrderDetailController c;
  final ResponsiveHelper r;
  const _AmountCard({required this.c, required this.r});

  @override
  Widget build(BuildContext context) {
    final isCod = c.order.paymentMode == 'COD';
    return _card(r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Amount to Collect',
                    style: TextStyle(
                        fontSize: r.f15,
                        fontWeight: FontWeight.bold,
                        color: AppColor.black)),
                Text(
                  isCod ? '₹${c.order.amountToCollect.toInt()}' : '₹0',
                  style: TextStyle(
                      fontSize: r.f15,
                      fontWeight: FontWeight.bold,
                      color: AppColor.black),
                ),
              ],
            ),
            SizedBox(height: r.s8),
            Text(
              isCod
                  ? 'Please collect the full amount from the customer before entering the OTP for delivery confirmation.'
                  : 'This order is prepaid. No amount to collect from the customer.',
              style: TextStyle(
                  fontSize: r.f12,
                  color: Colors.black.withOpacity(0.6),
                  height: 1.4),
            ),
          ],
        ));
  }
}

// ── OTP card ──────────────────────────────────────────────────────────────────
class _OtpCard extends StatelessWidget {
  final OrderDetailController c;
  final ResponsiveHelper r;
  const _OtpCard({required this.c, required this.r});

  @override
  Widget build(BuildContext context) {
    final defaultTheme = PinTheme(
      width: r.s52,
      height: r.s80,
      textStyle: TextStyle(
          fontSize: r.f18, fontWeight: FontWeight.bold, color: AppColor.black),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(r.r8),
        border: Border.all(color: AppColor.black.withOpacity(0.2)),
      ),
    );

    final focusedTheme = defaultTheme.copyDecorationWith(
      borderRadius: BorderRadius.circular(r.r8),
      border: Border.all(color: AppColor.black.withOpacity(0.2)),
    );

    return _card(r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Enter Customer OTP to Confirm Delivery.',
                style: TextStyle(
                    fontSize: r.f15,
                    fontWeight: FontWeight.bold,
                    color: AppColor.black)),
            SizedBox(height: r.s20),
            Center(
              child: Pinput(
                length: 6,
                defaultPinTheme: defaultTheme,
                focusedPinTheme: focusedTheme,
                keyboardType: TextInputType.number,
                onCompleted: (otp) => c.onOtpCompleted(otp),
              ),
            ),
            SizedBox(height: r.s8),
          ],
        ));
  }
}

// ── Delivered success card ────────────────────────────────────────────────────
class _DeliveredCard extends StatelessWidget {
  final ResponsiveHelper r;
  const _DeliveredCard({required this.r});

  @override
  Widget build(BuildContext context) {
    return _card(r,
        child: Column(
          children: [
            SizedBox(height: r.s8),
            Container(
              width: r.s56,
              height: r.s56,
              decoration: BoxDecoration(
                color: const Color(0xFF2ECC71).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.check_circle_rounded,
                  color: const Color(0xFF2ECC71), size: r.i32),
            ),
            SizedBox(height: r.s16),
            Text('Delivery Completed Successfully',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: r.f16,
                    fontWeight: FontWeight.bold,
                    color: AppColor.black)),
            SizedBox(height: r.s8),
            Text(
              "You've successfully delivered the order. Thanks for your effort and timely service!",
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontSize: r.f13, color: Colors.grey, height: 1.4),
            ),
            SizedBox(height: r.s8),
          ],
        ));
  }
}

// ── Customer info card ────────────────────────────────────────────────────────
class _CustomerCard extends StatelessWidget {
  final OrderDetailController c;
  final ResponsiveHelper r;
  const _CustomerCard({required this.c, required this.r});

  @override
  Widget build(BuildContext context) {
    final order = c.order;
    return _card(r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('Customer Information', r),
            SizedBox(height: r.s4),
            _infoRow(
                r,
                'Customer Name',
                Text(order.customerName,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: r.f13,
                        fontWeight: FontWeight.w500,
                        color: AppColor.black))),
            _infoRow(
                r,
                'Contact',
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () => c.callPhone(order.customerPhone),
                      child: Text(order.customerPhone,
                          style: TextStyle(
                              fontSize: r.f13,
                              color: const Color(0xFF042E60),
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColor.primary)),
                    ),
                    SizedBox(width: r.s6),
                    GestureDetector(
                      onTap: () => c.callPhone(order.customerPhone),
                      child: Container(
                        width: r.s24,
                        height: r.s24,
                        decoration: const BoxDecoration(
                            color: Color(0xFF042E60), shape: BoxShape.circle),
                        child:
                            Icon(Icons.phone, color: Colors.white, size: r.s12),
                      ),
                    ),
                  ],
                )),
            _infoRow(
                r,
                'Payment Mode',
                Text(order.paymentMode,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: r.f13,
                        fontWeight: FontWeight.w500,
                        color: AppColor.black))),
            _infoRow(
                r,
                'Delivery Address',
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(order.deliveryAddress,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontSize: r.f13,
                            fontWeight: FontWeight.w500,
                            color: AppColor.black)),
                    if (order.deliveryLat != null && order.deliveryLng != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: GestureDetector(
                          onTap: () =>
                              c.openMap(order.deliveryLat!, order.deliveryLng!),
                          child: Text('View on Map',
                              style: TextStyle(
                                  fontSize: r.f12,
                                  color: const Color(0xFF2ECC71),
                                  fontWeight: FontWeight.w600)),
                        ),
                      ),
                  ],
                ),
                isLast: true),
          ],
        ));
  }
}

// ── Vendor info card ──────────────────────────────────────────────────────────
class _VendorCard extends StatelessWidget {
  final OrderDetailController c;
  final ResponsiveHelper r;
  const _VendorCard({required this.c, required this.r});

  @override
  Widget build(BuildContext context) {
    final v = c.order.vendor;
    return _card(r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('Vendor Information', r,
                trailing: v.lat != null && v.lng != null
                    ? GestureDetector(
                        onTap: () => c.openMap(v.lat!, v.lng!),
                        child: Text('View on Map',
                            style: TextStyle(
                                fontSize: r.f12,
                                color: const Color(0xFF2ECC71),
                                fontWeight: FontWeight.w600)),
                      )
                    : null),
            SizedBox(height: r.s12),
            Row(
              children: [
                // Vendor image
                ClipRRect(
                  borderRadius: BorderRadius.circular(r.r8),
                  child: v.imageUrl != null
                      ? CachedNetworkImage(
                          imageUrl: v.imageUrl!,
                          width: r.s64,
                          height: r.s64,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          width: r.s64,
                          height: r.s64,
                          color: const Color(0xFFEEF2FF),
                          child: Icon(Icons.restaurant,
                              color: const Color(0xFF042E60), size: r.i24),
                        ),
                ),
                SizedBox(width: r.s12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(v.name,
                          style: TextStyle(
                              fontSize: r.f14,
                              fontWeight: FontWeight.bold,
                              color: AppColor.black)),
                      SizedBox(height: r.s4),
                      Text(v.address,
                          style: TextStyle(
                              fontSize: r.f12,
                              color: AppColor.black.withOpacity(0.6),
                              height: 1.3)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}

// ── Items card ────────────────────────────────────────────────────────────────
class _ItemsCard extends StatelessWidget {
  final OrderDetailController c;
  final ResponsiveHelper r;
  const _ItemsCard({required this.c, required this.r});

  @override
  Widget build(BuildContext context) {
    return _card(r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Items',
                style: TextStyle(
                    fontSize: r.f15,
                    fontWeight: FontWeight.bold,
                    color: AppColor.black)),
            SizedBox(height: r.s12),
            ...c.order.items.map((item) => Padding(
                  padding: EdgeInsets.only(bottom: r.s10),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(r.r8),
                        child: item.imageUrl != null
                            ? CachedNetworkImage(
                                imageUrl: item.imageUrl!,
                                width: r.s48,
                                height: r.s48,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                width: r.s48,
                                height: r.s48,
                                color: const Color(0xFFEEF2FF),
                                child: Icon(Icons.fastfood_rounded,
                                    color: const Color(0xFF042E60),
                                    size: r.i20),
                              ),
                      ),
                      SizedBox(width: r.s12),
                      Expanded(
                        child: Text(item.name,
                            style: TextStyle(
                              fontSize: r.f13,
                              color: AppColor.black.withOpacity(0.8),
                            )),
                      ),
                      Text('X${item.quantity}',
                          style: TextStyle(
                              fontSize: r.f13,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey)),
                    ],
                  ),
                )),
          ],
        ));
  }
}

// ── Order summary card (Picked Up only) ──────────────────────────────────────
class _OrderSummaryCard extends StatelessWidget {
  final OrderDetailController c;
  final ResponsiveHelper r;
  const _OrderSummaryCard({required this.c, required this.r});

  @override
  Widget build(BuildContext context) {
    return _card(r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order Summary',
                style: TextStyle(
                    fontSize: r.f15,
                    fontWeight: FontWeight.bold,
                    color: AppColor.black)),
            SizedBox(height: r.s12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Amount',
                    style: TextStyle(
                        fontSize: r.f13, color: const Color(0xff262626))),
                Text('RS. ${c.order.totalAmount.toInt()}',
                    style: TextStyle(
                        fontSize: r.f13,
                        fontWeight: FontWeight.w600,
                        color: AppColor.black)),
              ],
            ),
          ],
        ));
  }
}

extension _OrderDetailExtras on ResponsiveHelper {
  double get s52 => 52 * screenWidth / 390;
  double get s80 => 80 * screenWidth / 390;
}
