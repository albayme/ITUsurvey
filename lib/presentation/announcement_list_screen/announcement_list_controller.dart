import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itu_geo/models/course_model.dart';
import 'package:itu_geo/presentation/student_panel_screem/studen_panel_controller.dart';
import 'package:itu_geo/presentation/teacher_panel_screen/teacher_panel_controller.dart';

class AnnouncementListController extends GetxController {
  RxDouble rating = 5.0.obs;
  RxBool showMessageArea = false.obs;
  TextEditingController ratingMessageController = TextEditingController();
  final studentPanelController = Get.find<StudentPanelController>();
  final teacherPanelController = Get.find<TeacherPanelController>();
  RxBool isTeacher = false.obs;

  @override
  void onInit() {
    super.onInit();
    isTeacher.value = Get.arguments ?? false;
    var courseData = teacherPanelController.coursesData.value;

  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    ratingMessageController.dispose();
    // studentPanelController.dispose();
    // teacherPanelController.dispose();
  }
}
