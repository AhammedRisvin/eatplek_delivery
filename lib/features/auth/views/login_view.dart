import 'package:eatplek_delivery/core/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/assets.dart';
import '../../../core/utils/responsive_helper.dart';
import '../../../shared/widgets/common_widgets.dart';
import '../controllers/auth_controller.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final r = ResponsiveHelper(context);
    final args = Get.arguments as Map<String, dynamic>?;
    final partnerType = args?['type'] as String? ?? 'vendor';
    final isVendor = partnerType == 'vendor';

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          _buildHeader(r, isVendor),
          Expanded(
            child: Transform.translate(
              offset: const Offset(0, -20),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(r.r20),
                    topRight: Radius.circular(r.r20),
                  ),
                ),
                child: GetBuilder<AuthController>(
                  id: 'auth',
                  builder: (c) => Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          padding:
                              EdgeInsets.fromLTRB(r.s24, r.s28, r.s24, r.s16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              text(
                                'Enter Your Registered Email ID',
                                fontSize: r.f14,
                                fontWeight: FontWeight.w600,
                                color: AppColor.black,
                              ),
                              SizedBox(height: r.s8),
                              buildCommonTextFormField(
                                controller: c.emailController,
                                hintText: 'demo@gmail.com',
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                borderRadius: r.r8,
                              ),
                              SizedBox(height: r.s20),
                              text(
                                'Enter Your Password',
                                fontSize: r.f14,
                                fontWeight: FontWeight.w600,
                                color: AppColor.black,
                              ),
                              SizedBox(height: r.s8),
                              GetBuilder<AuthController>(
                                id: 'auth_password',
                                builder: (c) => buildCommonTextFormField(
                                  controller: c.passwordController,
                                  hintText: '••••••••••••••',
                                  obscureText: c.obscurePassword,
                                  textInputAction: TextInputAction.done,
                                  onSubmitted: (_) => c.login(partnerType),
                                  borderRadius: r.r8,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      c.obscurePassword
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                      color: Colors.grey,
                                      size: r.i20,
                                    ),
                                    onPressed: c.toggleObscurePassword,
                                  ),
                                ),
                              ),
                              if (c.errorMessage.isNotEmpty) ...[
                                SizedBox(height: r.s8),
                                text(
                                  c.errorMessage,
                                  fontSize: r.f13,
                                  color: const Color(0xFFD32F2F),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                      GetBuilder<AuthController>(
                        id: 'auth',
                        builder: (c) => Padding(
                          padding: EdgeInsets.fromLTRB(
                            r.s24,
                            r.s8,
                            r.s24,
                            r.bottomPadding + r.s24,
                          ),
                          child: button(
                            label: 'Login',
                            onTap: () => c.login(partnerType),
                            isLoading: c.isLoading,
                            fontSize: r.f16,
                            height: r.h52,
                            borderRadius: r.r8,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(ResponsiveHelper r, bool isVendor) {
    return SizedBox(
      height: r.hp(30) + 10,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // ── bg image at 20% opacity ──────────────────────────────────
          Image.asset(
            AppAssets.authBg,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.05),
                    Colors.white.withOpacity(0.0),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),

          // ── Content over image ───────────────────────────────────────
          Padding(
            padding: EdgeInsets.only(
              top: r.topPadding + r.s24,
              left: r.s24,
              right: r.s24,
              bottom: r.s20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on, color: Colors.white, size: r.i22),
                    SizedBox(width: r.s6),
                    Text(
                      'EATPLEK',
                      style: TextStyle(
                        fontSize: r.f20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: r.s2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: r.s16),
                Text(
                  isVendor ? 'Welcome Back, Vendor!' : 'Welcome Back, Admin!',
                  style: TextStyle(
                    fontSize: r.f22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: r.s8),
                Text(
                  isVendor
                      ? 'Access your restaurant dashboard and manage your\norders, menu, and earnings from one place.'
                      : 'Access your admin dashboard and manage all\ndelivery partners and orders from one place.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: r.f13,
                    color: Colors.white70,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
