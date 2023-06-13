import 'package:get/get.dart';
import 'package:itu_geo/presentation/announcement_list_screen/announcement_list_controller.dart';
import 'package:itu_geo/presentation/student_panel_screem/studen_panel_controller.dart';
import 'package:itu_geo/presentation/teacher_panel_screen/teacher_panel_controller.dart';

class AnnouncementListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AnnouncementListController());
    Get.lazyPut(() => TeacherPanelController());
    Get.lazyPut(() => StudentPanelController());

  }
}
