import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:itu_geo/core/constant/constants.dart';
import 'package:itu_geo/core/firebase/firestore.dart';
import 'package:itu_geo/models/announcement_model.dart';
import 'package:itu_geo/models/course_model.dart';
import 'package:itu_geo/models/user_model.dart';
import 'package:itu_geo/routes/app_routes.dart';

class TeacherPanelController extends GetxController {
  Rx<ValueNotifier<bool>> dialOpen = ValueNotifier<bool>(false).obs;
  RxBool rmicons = false.obs;
  RxBool isPending = false.obs;
  RxBool toogle = false.obs;
  RxList<AnnouncementData> announcementData = [initialAnnouncementData].obs;
  RxList<StudentData> studentActivities = [initialStudenData].obs;

  String studentEmail = "";
  String teacherId = "";
  final box = Hive.box(HiveKey.accountData);
  RxList coursesData = [].obs;
  Rx<int> totalCurrentStudentPins = 0.obs;

  Rx<CourseData> selectedCourseData = initialCourseData.obs;
  RxBool showLoading = false.obs;
  RxList<PopupMenuItem> dropdownData = <PopupMenuItem>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    showLoading(true);
    studentEmail = box.get(HiveKey.userEmail);
    isPending.value = box.get(HiveKey.isPending);
    teacherId = box.get(HiveKey.userID);

    coursesData.value = await FireStore().getCoursesData(teacherId);
    dropdownData.value = await prepareDropdownData();
    selectedCourseData.value =
        coursesData.isNotEmpty ? coursesData[0] : initialCourseData;
    studentActivities.value =
        await FireStore().getStudentDataByCourseID(selectedCourseData.value.id);

    await getAnnocument();
    if (coursesData.isEmpty && !isPending.value && box.get(HiveKey.isTeacher)) {
      Get.toNamed(AppRoutes.addCourseScreen);
    }
    await calculateTotalPins();
    showLoading(false);
  }

  getAnnocument() async {
    announcementData.value = await FireStore()
        .getAnnoucementsByCourseID(selectedCourseData.value.id);
  }

  updateCourseData() async {
    coursesData.value = await FireStore().getCoursesData(teacherId);
    await calculateTotalPins();
  }

  calculateTotalPins() {

    int sum = 0;
    for (var i = 0; i < studentActivities.length; i++) {
      for (var j = 0; j < studentActivities[i].coordinates.length; j++) {
        sum += 1;
      }
    }
    totalCurrentStudentPins.value = sum;
  }

  updateCourseEntity(CourseData data) async {
    await FireStore().updateCourse(data.id, data);
    await updateCourseData();
  }

  changeSelectedCourse(String id) async {
    var data = coursesData;
    selectedCourseData.value = data.where((element) => element.id == id).first;
    studentActivities.value =
        await FireStore().getStudentDataByCourseID(selectedCourseData.value.id);
    await calculateTotalPins();
  }

  updateStudentActivities() async {
    studentActivities.value =
        await FireStore().getStudentDataByCourseID(selectedCourseData.value.id);
    await calculateTotalPins();
  }

  List<PopupMenuItem> prepareDropdownData() {
    List<PopupMenuItem> result = [];
    var data = coursesData.value as List<CourseData>;
    for (var i = 0; i < data.length; i++) {
      result.add(PopupMenuItem<String>(
        value: data[i].id,
        child: Text("${data[i].name} ${data[i].lessonCode}"),
      ));
    }

    return result;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
