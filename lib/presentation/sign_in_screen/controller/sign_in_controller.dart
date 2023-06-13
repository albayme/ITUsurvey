import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart' as h;
import 'package:itu_geo/core/constant/constants.dart';
import 'package:itu_geo/core/firebase/firestore.dart';
import 'package:itu_geo/core/hive/hive_data.dart';
import 'package:itu_geo/models/user_model.dart';

class SignInController extends GetxController {
  TextEditingController statusDefaultController = TextEditingController();

  TextEditingController statusDefaultOneController = TextEditingController();

  Rx<String> passwordErrorMessage = "".obs;
  Rx<String> emailErrorMessage = "".obs;
  Rx<UserData> userData = initialUserData.obs;
  RxBool checkbox = false.obs;
  RxBool isAuthanticated = false.obs;
  Rx<bool> isShowPassword = false.obs;

  @override
  void onInit() {
    super.onInit();
    final box = h.Hive.box(HiveKey.accountData);
    String userID = box.get(HiveKey.userID) ?? "";
    String userEmail = box.get(HiveKey.userEmail) ?? "";
    if (userID != "" && userEmail != "") {
      isAuthanticated.value = true;
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    statusDefaultController.dispose();
    statusDefaultOneController.dispose();
  }

  setUser(String email) async {
    var data = await FireStore().getUserByEmail(email);
    HiveData().setUserAuthData(data);
  }
}
