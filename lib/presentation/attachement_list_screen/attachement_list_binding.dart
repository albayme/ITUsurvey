import 'package:get/get.dart';
import 'package:itu_geo/presentation/attachement_list_screen/attachement_list_controller.dart';
import 'package:itu_geo/presentation/student_panel_screem/studen_panel_controller.dart';
import 'package:itu_geo/presentation/teacher_panel_screen/teacher_panel_controller.dart';

class AttachementListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AttachementListController());
    Get.lazyPut(() => TeacherPanelController());
    Get.lazyPut(() => StudentPanelController());
  }
}
