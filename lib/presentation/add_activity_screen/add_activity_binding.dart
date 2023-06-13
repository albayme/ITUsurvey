import 'package:get/get.dart';
import 'package:itu_geo/presentation/student_panel_screem/studen_panel_controller.dart';

import 'add_activity_controller.dart';

class AddActivityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddActivityController());
    Get.lazyPut(() => StudentPanelController());
  }
}
