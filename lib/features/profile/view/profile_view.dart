import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/utils/assets.dart';
import '../../../core/utils/responsive_helper.dart';
import '../controller/profile_controller.dart';
import 'widget/logout_sheet.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ProfileController>();
    final r = ResponsiveHelper(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding:
            EdgeInsets.fromLTRB(r.s16, r.topPadding + r.s16, r.s16, r.hp(14)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Profile',
                style: TextStyle(
                    fontSize: r.f22,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1A1A1A))),
            SizedBox(height: r.s16),

            // ── User card ──────────────────────────────────────────────
            _buildUserCard(c, r),
            SizedBox(height: r.s24),

            // ── More Options ───────────────────────────────────────────
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(r.r16),
              ),
              padding: EdgeInsets.all(r.s20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('More Options',
                      style: TextStyle(
                          fontSize: r.f15,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1A1A1A))),
                  SizedBox(height: r.s12),
                  _OptionTile(
                    svgAsset: AppAssets.profileTapped,
                    label: 'Personal Details',
                    onTap: () => Get.toNamed(AppRoutes.personalDetails),
                    r: r,
                  ),
                  _divider(),
                  _OptionTile(
                    svgAsset: AppAssets.terms,
                    label: 'Terms & condition',
                    onTap: () {},
                    r: r,
                  ),
                  _divider(),
                  _OptionTile(
                    svgAsset: AppAssets.policy,
                    label: 'Privacy Policy',
                    onTap: () {},
                    r: r,
                  ),
                  _divider(),
                  _OptionTile(
                    svgAsset: AppAssets.helpCentre,
                    label: 'Help Center',
                    onTap: () {},
                    r: r,
                  ),
                ],
              ),
            ),
            SizedBox(height: r.s16),

            // ── Logout ─────────────────────────────────────────────────
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(r.r16),
              ),
              padding: EdgeInsets.symmetric(horizontal: r.s20),
              child: _OptionTile(
                svgAsset: AppAssets.logout,
                label: 'Logout',
                iconColor: Colors.red.shade400,
                iconBgColor: Colors.red.shade50,
                onTap: () => LogoutSheet.show(context, onConfirm: c.logout),
                r: r,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserCard(ProfileController c, ResponsiveHelper r) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(r.r16),
        border: Border.all(color: const Color(0xFF042E60).withOpacity(0.2)),
      ),
      padding: EdgeInsets.all(r.s16),
      child: Row(
        children: [
          CircleAvatar(
            radius: r.s24,
            backgroundColor: const Color(0xFFCCDDEE),
            child:
                Icon(Icons.person, color: const Color(0xFF042E60), size: r.i24),
          ),
          SizedBox(width: r.s12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(c.profile.name,
                  style: TextStyle(
                      fontSize: r.f16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1A1A1A))),
              SizedBox(height: r.s4),
              Text(c.profile.email,
                  style: TextStyle(fontSize: r.f12, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _divider() =>
      const Divider(height: 1, indent: 56, color: Color(0xFFF0F0F0));
}

// ── Option tile — accepts SVG asset path ──────────────────────────────────────
class _OptionTile extends StatelessWidget {
  final String svgAsset;
  final String label;
  final VoidCallback onTap;
  final ResponsiveHelper r;
  final Color? iconColor;
  final Color? iconBgColor;

  const _OptionTile({
    required this.svgAsset,
    required this.label,
    required this.onTap,
    required this.r,
    this.iconColor,
    this.iconBgColor,
  });

  @override
  Widget build(BuildContext context) {
    final fgColor = iconColor ?? const Color(0xFF042E60);
    final bgColor = iconBgColor ?? const Color(0xFFEEF2FF);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(r.r16),
      child: Padding(
        padding: label == 'Help Center'
            ? EdgeInsets.only(top: r.s14)
            : EdgeInsets.symmetric(vertical: r.s14),
        child: Row(
          children: [
            // SVG icon container
            Container(
              width: r.s36,
              height: r.s36,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(r.r8),
              ),
              child: Center(
                child: SvgPicture.asset(
                  svgAsset,
                  width: r.i20,
                  height: r.i20,
                  colorFilter: ColorFilter.mode(fgColor, BlendMode.srcIn),
                ),
              ),
            ),
            SizedBox(width: r.s12),
            Expanded(
              child: Text(label,
                  style: TextStyle(
                      fontSize: r.f14, color: const Color(0xFF1A1A1A))),
            ),
            Icon(Icons.chevron_right_rounded,
                color: Colors.grey.shade400, size: r.i20),
          ],
        ),
      ),
    );
  }
}
