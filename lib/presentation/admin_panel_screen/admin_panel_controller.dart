import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itu_geo/core/firebase/firestore.dart';
import 'package:itu_geo/models/course_model.dart';
import 'package:itu_geo/models/user_model.dart';

class AdminPanelController extends GetxController {
  RxBool showLoading = false.obs;
  RxList<UserData> data = <UserData>[].obs;
  RxList<CourseData> courseData = <CourseData>[].obs;

  RxList<UserData> allData = <UserData>[].obs;
  RxList<CourseData> allcourseData = <CourseData>[].obs;

  TextEditingController ratingMessageController = TextEditingController();

  @override
  Future<void> onInit() async {
    super.onInit();
    showLoading(true);
    data.value = await FireStore().getUsers();
    courseData.value = await FireStore().getCourses();

    // ignore: invalid_use_of_protected_member
    allData.value = data.value;
    showLoading(false);
  }

  Future<void> refleshData() async {
    data.value = await FireStore().getUsers();
    courseData.value = await FireStore().getCourses();

    allData.value = data.value;
  }

  applyFilter(String rule) {
    switch (rule) {
      case "all":
        data.value = allData.value;
        break;
      case "teacher":
        data.value = allData.value
            .where((element) => element.isTeacher == true)
            .toList();
        break;
      case "student":
        data.value = allData.value
            .where((element) => element.isTeacher == false)
            .toList();

        break;
      case "pending":
        data.value = allData.value
            .where((element) => element.isPending == true)
            .toList();

        break;
      default:
        data.value = allData.value;
        break;
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    ratingMessageController.dispose();
  }

  approveUser(UserData data) async {
    await FireStore().updateUserData(data);
    await refleshData();
  }
}
