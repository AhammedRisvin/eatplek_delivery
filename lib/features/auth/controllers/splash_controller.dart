import 'package:get/get.dart';

import '../../../core/constants/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 2));
    Get.offAllNamed(AppRoutes.bottomNav);
  }
}
