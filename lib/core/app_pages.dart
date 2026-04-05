import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../features/auth/bindings/auth_binding.dart';
import '../features/auth/views/delivery_type_view.dart';
import '../features/auth/views/login_view.dart';
import '../features/auth/views/splash_view.dart';
import '../features/bottom_nav/view/widget/bottom_nav_view.dart';
import '../features/home/bindings/home_bindings.dart';
import '../features/profile/view/personal_details_view.dart';
import 'constants/app_routes.dart';

class AppPages {
  AppPages._();

  static final pages = [
    GetPage(name: AppRoutes.splash, page: () => const SplashView()),
    GetPage(name: AppRoutes.deliveryType, page: () => const DeliveryTypeView()),
    GetPage(
        name: AppRoutes.login,
        page: () => const LoginView(),
        binding: AuthBinding()),
    GetPage(
        name: AppRoutes.bottomNav,
        page: () => const BottomNavView(),
        binding: HomeBinding()),
    GetPage(
        name: AppRoutes.personalDetails,
        page: () => const PersonalDetailsView()),
    GetPage(
        name: AppRoutes.orderDetail,
        page: () => const _Placeholder('Order Detail')),
    GetPage(
        name: AppRoutes.activeDelivery,
        page: () => const _Placeholder('Active Delivery')),
  ];
}

class _Placeholder extends StatelessWidget {
  final String name;
  const _Placeholder(this.name);
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(name)),
        body: Center(child: Text('$name — coming soon')),
      );
}
