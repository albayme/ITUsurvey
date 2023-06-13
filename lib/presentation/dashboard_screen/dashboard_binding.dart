import 'package:get/get.dart';
import 'package:itu_geo/presentation/admin_panel_screen/admin_panel_controller.dart';
import 'package:itu_geo/presentation/profile_settings_screen/controller/profile_settings_controller.dart';
import 'package:itu_geo/presentation/student_panel_screem/studen_panel_controller.dart';
import 'package:itu_geo/presentation/teacher_panel_screen/teacher_panel_controller.dart';
import 'package:itu_geo/presentation/test_screen/test_controller.dart';

import 'dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<TestController>(() => TestController());
    Get.lazyPut<AdminPanelController>(() => AdminPanelController());
    Get.lazyPut<TeacherPanelController>(() => TeacherPanelController());
    Get.lazyPut<StudentPanelController>(() => StudentPanelController());
    Get.lazyPut<ProfileSettingsController>(() => ProfileSettingsController());
  }
}
