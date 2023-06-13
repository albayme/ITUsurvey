import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:itu_geo/core/constant/constants.dart';
import 'package:itu_geo/core/firebase/firestore.dart';
import 'package:itu_geo/models/announcement_model.dart';
import 'package:itu_geo/models/course_model.dart';
import 'package:itu_geo/models/user_model.dart';

class StudentPanelController extends GetxController {
  RxInt activeCurrentStep = 0.obs;

  Rx<String> groupNameErrorMessage = "".obs;
  Rx<CourseData> courseData = initialCourseData.obs;
  Rx<UserData> userData = initialUserData.obs;
  RxList<StudentData> studentActivities = [initialStudenData].obs;
  RxList<AnnouncementData> announcementData = [initialAnnouncementData].obs;

  var box = Hive.box(HiveKey.accountData);
  String studentEmail = "";
  List<StudentData> currentStudentData = [];
  Rx<int> totalCurrentStudentPins = 0.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    var userID = box.get(HiveKey.userID);
    userData.value = await FireStore().getUserById(userID);
    if (!userData.value.isTeacher) {
      courseData.value =
          await FireStore().getCourseDataById(userData.value.courseID);
    }
    announcementData.value =
        await FireStore().getAnnoucementsByCourseID(courseData.value.id);
    studentActivities.value =
        await FireStore().getStudentDataByCourseID(courseData.value.id);
    studentEmail = box.get(HiveKey.userEmail);
    currentStudentData =
        studentActivities.where((p0) => p0.email == studentEmail).toList();
    await calculateTotalPins();
  }

  calculateTotalPins() {
    currentStudentData =
        studentActivities.where((p0) => p0.email == studentEmail).toList();
    int sum = 0;
    for (var i = 0; i < currentStudentData.length; i++) {
      for (var j = 0; j < currentStudentData[i].coordinates.length; j++) {
        sum += 1;
      }
    }
    totalCurrentStudentPins.value = sum;
  }

  @override
  void onReady() {
    super.onReady();
  }

  updateStudentActivity() async {
    studentActivities.value =
        await FireStore().getStudentDataByCourseID(courseData.value.id);
    await calculateTotalPins();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
