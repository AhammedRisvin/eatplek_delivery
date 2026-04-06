import 'package:eatplek_delivery/core/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/order_details_dummy_model.dart';

class OrderDetailController extends GetxController {
  late OrderDetailModel order;

  String _status = DeliveryStatus.pickedUp;
  String get status => _status;

  bool get isPickedUp => _status == DeliveryStatus.pickedUp;
  bool get isOutOfDelivery => _status == DeliveryStatus.outOfDelivery;
  bool get isDelivered => _status == DeliveryStatus.delivered;

  @override
  void onInit() {
    super.onInit();
    // Use passed order or fallback to dummy
    final args = Get.arguments;
    if (args is OrderDetailModel) {
      order = args;
    } else {
      order = OrderDetailDummyData.codOrder();
    }
    _status = order.status;
  }

  // ── Status chip taps ───────────────────────────────────────────────────────
  void onChipTap(String tappedStatus) {
    if (tappedStatus == DeliveryStatus.pickedUp) return; // already first

    if (tappedStatus == DeliveryStatus.outOfDelivery && isPickedUp) {
      _status = DeliveryStatus.outOfDelivery;
      order.status = _status;
      update(['order_detail']);
      return;
    }

    if (tappedStatus == DeliveryStatus.delivered) {
      // Show warning — OTP must be used to reach delivered
      Get.snackbar(
        'OTP Required',
        'Please ask the customer for the OTP to confirm delivery',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColor.primary,
        colorText: Colors.white,
        borderRadius: 12,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
        icon: const Icon(Icons.warning_amber_rounded, color: Colors.amber),
      );
    }
  }

  // ── OTP confirmed (called when 4 digits entered) ───────────────────────────
  void onOtpCompleted(String otp) {
    // Dummy: any 4-digit OTP works
    if (otp.length == 6) {
      _status = DeliveryStatus.delivered;
      order.status = _status;
      update(['order_detail']);
    }
  }

  // ── Open Google Maps ───────────────────────────────────────────────────────
  Future<void> openMap(double lat, double lng) async {
    final uri =
        Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lng');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  // ── Open dialler ──────────────────────────────────────────────────────────
  Future<void> callPhone(String phone) async {
    final uri = Uri(scheme: 'tel', path: phone.replaceAll(' ', ''));
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
