import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itu_geo/core/firebase/firestore.dart';
import 'package:itu_geo/models/course_model.dart';
import 'package:itu_geo/models/user_model.dart';
import 'package:itu_geo/presentation/teacher_panel_screen/teacher_panel_controller.dart';

class WaitingStudentController extends GetxController {
  RxList<UserData> data = <UserData>[].obs;
  final teacherController = Get.find<TeacherPanelController>();
  CourseData selectedCourse = initialCourseData;
  RxBool isWaiting = false.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    selectedCourse = teacherController.selectedCourseData.value;
    isWaiting.value = Get.arguments;
    await prepareUserData();
  }

  prepareUserData() async {
    List<UserData> users = [];
    for (var i = 0; i < selectedCourse.students.length; i++) {
      var user = await FireStore().getUserById(selectedCourse.students[i]);
      users.add(user);
    }
    data.value = users;
  }

  updateData(String studentId) async {
    selectedCourse.waitingStudents.remove(studentId);
    await teacherController.updateCourseEntity(selectedCourse);
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> refleshData() async {}
  @override
  void onClose() {
    super.onClose();
  }
}
