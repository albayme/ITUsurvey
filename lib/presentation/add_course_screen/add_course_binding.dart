import 'package:get/get.dart';
import 'package:itu_geo/presentation/student_panel_screem/studen_panel_controller.dart';

import 'add_course_controller.dart';

class AddCourseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddCourseController());



  }
}
