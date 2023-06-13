import 'package:get/get.dart';
import 'package:itu_geo/presentation/student_panel_screem/studen_panel_controller.dart';
import 'package:itu_geo/presentation/teacher_panel_screen/teacher_panel_controller.dart';
import 'package:itu_geo/presentation/view_activity_screen/view_activity_controller.dart';


class ViewActivityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ViewActivityController());
    Get.lazyPut(() => StudentPanelController());
    Get.lazyPut(() => TeacherPanelController());

  }
}
