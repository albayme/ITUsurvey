import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itu_geo/models/course_model.dart';
import 'package:itu_geo/models/user_model.dart';
import 'package:itu_geo/presentation/student_panel_screem/studen_panel_controller.dart';
import 'package:itu_geo/presentation/teacher_panel_screen/teacher_panel_controller.dart';

class ViewActivityController extends GetxController {
  RxDouble rating = 5.0.obs;
  RxBool showMessageArea = false.obs;
  TextEditingController ratingMessageController = TextEditingController();
  Rx<StudentData> data = initialStudenData.obs;
  RxBool isDeletable = false.obs;
  RxBool isTeacher = false.obs;
  Rx<CourseData> courseData = initialCourseData.obs;

  StudentPanelController studentPanelController = Get.find<StudentPanelController>();
  TeacherPanelController teacherPanelController = Get.find<TeacherPanelController>();


  @override
  void onInit() {
    super.onInit();
    data.value = Get.arguments[0];
    isDeletable.value = Get.arguments[1];
    isTeacher.value = Get.arguments[2];
    courseData.value = Get.arguments[3];
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
