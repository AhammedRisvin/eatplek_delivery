import 'package:get/get.dart';

import '../../earnings/controller/earnings_controller.dart';
import '../../history/controller/history_controller.dart';
import '../../profile/controller/profile_controller.dart';
import '../controllers/home_controller.dart';

/// HomeBinding registers controllers for ALL bottom nav tabs.
/// lazyPut = only initialised when the tab is first accessed.
/// fenix: true = controller is recreated if disposed (e.g. after logout).
class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<EarningsController>(() => EarningsController(), fenix: true);
    Get.lazyPut<HistoryController>(() => HistoryController(), fenix: true);
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
  }
}
