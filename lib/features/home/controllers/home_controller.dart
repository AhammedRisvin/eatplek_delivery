import 'package:get/get.dart';

import '../../order_detail/models/delivery_order_model.dart';
import '../model/home_dummy_data.dart';

class HomeController extends GetxController {
  bool isOnline = false;
  int selectedTab = 0;

  List<HomeOrderModel> assignedOrders = List.from(DummyData.assignedOrders);
  List<HomeOrderModel> acceptedOrders = List.from(DummyData.acceptedOrders);

  HomeStats get stats => DummyData.stats;
  String get partnerName => DummyData.partnerName;

  void toggleOnline() {
    isOnline = !isOnline;
    update(['home_header']);
  }

  void selectTab(int index) {
    selectedTab = index;
    update(['home_tabs']);
  }

  void acceptOrder(HomeOrderModel order) {
    assignedOrders.removeWhere((o) => o.id == order.id);
    acceptedOrders.insert(0, order.copyWith(status: OrderStatus.pending));
    update(['home_tabs']);
  }
}
