import 'package:get/get.dart';
import 'package:itu_geo/presentation/teacher_panel_screen/teacher_panel_controller.dart';

import 'waiting_students_controller.dart';

class WaitingStudentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WaitingStudentController());
    Get.lazyPut(() => TeacherPanelController());
  }
}
