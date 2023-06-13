import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  TextEditingController statusDefaultController = TextEditingController();

  TextEditingController statusDefaultOneController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController lessonCodeController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  RxBool checkbox = false.obs;
  RxBool isTeacher = false.obs;

  Rx<String> passwordErrorMessage = "".obs;
  Rx<String> confirmPasswordErrorMessage = "".obs;
  Rx<String> lessonCodeErrorMessage = "".obs;

  Rx<String> emailErrorMessage = "".obs;
  Rx<bool> isShowPassword = false.obs;
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    statusDefaultController.dispose();
    statusDefaultOneController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    surnameController.dispose();
    lessonCodeController.dispose();
  }
}
