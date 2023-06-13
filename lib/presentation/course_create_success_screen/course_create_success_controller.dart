import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CourseCreateSuccessController extends GetxController {
  RxDouble rating = 5.0.obs;
  RxBool showMessageArea = false.obs;
  TextEditingController ratingMessageController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
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
}
