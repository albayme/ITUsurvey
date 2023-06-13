import 'package:get/get.dart';
import 'package:itu_geo/presentation/admin_panel_screen/admin_panel_controller.dart';

class AdminPanelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdminPanelController());
  }
}
