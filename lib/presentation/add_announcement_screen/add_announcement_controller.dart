import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itu_geo/core/firebase/firestore.dart';
import 'package:itu_geo/core/utils/progress_dialog_utils.dart';
import 'package:itu_geo/models/announcement_model.dart';
import 'package:itu_geo/presentation/teacher_panel_screen/teacher_panel_controller.dart';

class AddAnnouncementController extends GetxController {
  RxString announcementErrorMessage = "".obs;
  RxList attachments = [].obs;
  RxList selectedCourse = [].obs;

  TextEditingController announcementController = TextEditingController();
  final teacherController = Get.find<TeacherPanelController>();

  @override
  void onInit() {
    super.onInit();
  }

  String generateCode() {
    var r = Random();
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
    return List.generate(6, (index) => chars[r.nextInt(chars.length)]).join();
  }

  uploadAttachements() async {
    var result = [];
    var attachment = attachments.value;
    for (var i = 0; i < attachment.length; i++) {
      var path = attachment[i];
      int start = attachment[i]!.lastIndexOf("/");
      String name = attachment[i].substring(start + 1);
      // Create a storage reference from our app
      final storageRef = FirebaseStorage.instance.ref();

      var uniqueID = generateCode();
// Create a reference to "mountains.jpg"
      final mountainsRef = storageRef.child("${name}_$uniqueID");

// Create a reference to 'images/mountains.jpg'
      final mountainImagesRef = storageRef.child("itugeo/${name}_$uniqueID");

// While the file names are the same, the references point to different files
      assert(mountainsRef.name == mountainImagesRef.name);
      assert(mountainsRef.fullPath != mountainImagesRef.fullPath);

      File file = File(path);

      try {
        var metaData = await mountainsRef.putFile(file);
        result.add(metaData.ref.fullPath);
      } catch (e) {
        print(e);
        // ...
      }
    }
    return result;
  }

  createAnn() async {
    ProgressDialogUtils.showProgressDialog();
    var documentRef = await uploadAttachements();
    var data = initialAnnouncementData;
    data.description = announcementController.text.toString();
    data.documentRef = documentRef;
    data.isActive = true;

    for (var i = 0; i < selectedCourse.length; i++) {
      data.courseID = selectedCourse.value[i];
      await FireStore().createAnnouncement(data);
    }
    await teacherController.getAnnocument();
    ProgressDialogUtils.hideProgressDialog();
    Get.back();
  }

  setAttachmentPath(List<String?> data) {
    var temp = attachments.value;
    for (var i = 0; i < data.length; i++) {
      temp.add(data[i]);
    }
    attachments.value = temp.toSet().toList();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    announcementController.dispose();
  }
}
