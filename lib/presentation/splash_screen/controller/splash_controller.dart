import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:itu_geo/core/constant/constants.dart';
import 'package:itu_geo/routes/app_routes.dart';

class SplashController extends GetxController {
  RxBool isAuthanticated = false.obs;
  @override
  void onInit() {
    super.onInit();
    final box = Hive.box(HiveKey.accountData);
    String userID = box.get(HiveKey.userID) ?? "";
    String userEmail = box.get(HiveKey.userEmail) ?? "";
    if (userID != "" && userEmail != "") {
      isAuthanticated.value = true;
    }
  }

  @override
  void onReady() {
    super.onReady();

    Future.delayed(const Duration(milliseconds: 3000), () {
      if (isAuthanticated.value) {
        Get.offAndToNamed(AppRoutes.dashboardScreen);
      } else {
        Get.offAndToNamed(AppRoutes.signInScreen);
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
  }
}
