import 'package:get/get.dart';

import 'course_create_success_controller.dart';

class CourseCreateSuccessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CourseCreateSuccessController());
  }
}
