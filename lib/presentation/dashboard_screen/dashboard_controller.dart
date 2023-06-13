import 'dart:async';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:itu_geo/core/constant/constants.dart';
import 'package:itu_geo/core/firebase/firestore.dart';

class DashboardController extends GetxController {
  var tabIndex = 0;
  RxBool isPremium = false.obs;
  RxBool loading = false.obs;
  RxBool isTeacher = false.obs;
  RxBool isAdmin = false.obs;
  RxBool isPending = false.obs;
  RxString nameSurname = "".obs;
  RxString email = "".obs;

  @override
  void onInit() async {
    super.onInit();
    loading(true);
    final box = Hive.box(HiveKey.accountData);

    var x = await FireStore().getUserByEmail(box.get(HiveKey.userEmail));
    isTeacher.value = x.isTeacher;
    isAdmin.value = x.isAdmin;
    box.put(HiveKey.isPending, x.isPending);
    nameSurname.value =
        box.get(HiveKey.name) ?? "" + " " + box.get(HiveKey.surname) ?? "";
    email.value = box.get(HiveKey.userEmail);
    loading(false);
  }

  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }
}
