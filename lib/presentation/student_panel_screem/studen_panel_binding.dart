import 'package:get/get.dart';

import 'studen_panel_controller.dart';

class StudentPanelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StudentPanelController());
  }
}
