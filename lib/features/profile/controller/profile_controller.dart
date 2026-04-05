import 'package:get/get.dart';

import '../../../core/constants/app_routes.dart';
import '../models/delivery_partner_model.dart';

class ProfileController extends GetxController {
  final profile = ProfileDummyData.profile;

  bool _isLoggingOut = false;
  bool get isLoggingOut => _isLoggingOut;

  Future<void> logout() async {
    _isLoggingOut = true;
    update(['profile_logout']);
    // Dummy — simulate API call
    await Future.delayed(const Duration(seconds: 1));
    _isLoggingOut = false;
    update(['profile_logout']);
    Get.offAllNamed(AppRoutes.deliveryType);
  }
}
