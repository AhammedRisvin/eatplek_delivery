import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/utils/assets.dart';
import '../../../core/utils/responsive_helper.dart';

class DeliveryTypeView extends StatelessWidget {
  const DeliveryTypeView({super.key});

  @override
  Widget build(BuildContext context) {
    final r = ResponsiveHelper(context);

    return Scaffold(
      backgroundColor: const Color(0xFF042E60),
      body: Stack(
        children: [
          // ── Full screen image ────────────────────────────────────────
          Positioned.fill(
            child: Image.asset(
              AppAssets.onBoardingPng,
              fit: BoxFit.contain,
              alignment: Alignment.topCenter,
              errorBuilder: (_, __, ___) => Container(
                color: const Color(0xFF0A4A8F),
                child: Icon(Icons.delivery_dining_rounded,
                    color: Colors.white24, size: r.i32 * 2),
              ),
            ),
          ),

          // ── Gradient fade ────────────────────────────────────────────
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.45, 0.62, 1.0],
                  colors: [
                    Colors.transparent,
                    const Color(0xFF042E60).withOpacity(0.85),
                    const Color(0xFF042E60),
                  ],
                ),
              ),
            ),
          ),

          // ── Bottom content ───────────────────────────────────────────
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                r.s24,
                0,
                r.s24,
                r.bottomPadding + r.s32,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Select Your Delivery Type',
                    style: TextStyle(
                      fontSize: r.f22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: r.s8),
                  Text(
                    'Choose your delivery type to set up your account.',
                    style: TextStyle(
                      fontSize: r.f13,
                      color: Colors.white60,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: r.s24),
                  _outlinedBtn(
                    r: r,
                    label: 'Vendor Delivery Partner',
                    onTap: () => Get.toNamed(
                      AppRoutes.login,
                      arguments: {'type': 'vendor'},
                    ),
                  ),
                  SizedBox(height: r.s12),
                  _filledBtn(
                    r: r,
                    label: 'Admin Delivery Partner',
                    onTap: () => Get.toNamed(
                      AppRoutes.login,
                      arguments: {'type': 'admin'},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _outlinedBtn({
    required ResponsiveHelper r,
    required String label,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: r.h52,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          side: const BorderSide(color: Colors.white54, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(r.r8),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: r.f15,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _filledBtn({
    required ResponsiveHelper r,
    required String label,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: r.h52,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF042E60),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(r.r8),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: r.f15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
