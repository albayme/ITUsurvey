import 'package:get/get.dart';
import 'package:itu_geo/presentation/teacher_panel_screen/teacher_panel_controller.dart';

import 'add_announcement_controller.dart';

class AddAnnouncementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddAnnouncementController());
    Get.lazyPut(() => TeacherPanelController());
  }
}
