import 'package:get/get.dart';

import 'teacher_panel_controller.dart';

class TeacherPanelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TeacherPanelController());
  }
}
