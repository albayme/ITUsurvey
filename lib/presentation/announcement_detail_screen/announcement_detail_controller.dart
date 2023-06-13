import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:itu_geo/core/constant/constants.dart';
import 'package:itu_geo/core/firebase/firestore.dart';
import 'package:itu_geo/core/utils/progress_dialog_utils.dart';
import 'package:itu_geo/models/announcement_model.dart';
import 'package:itu_geo/presentation/student_panel_screem/studen_panel_controller.dart';

class AnnouncementDetailController extends GetxController {
  RxDouble rating = 5.0.obs;
  RxString commentErrorMessage = "".obs;
  TextEditingController commentController = TextEditingController();
  AnnouncementData data = initialAnnouncementData;
  RxList<AnnouncementComment> comments = [initialAnnouncementComment].obs;
  var box = Hive.box(HiveKey.accountData);
  @override
  Future<void> onInit() async {
    super.onInit();
    data = Get.arguments;
    comments.value = await FireStore().getCommentsByAnnouncementID(data.id);
  }

  @override
  void onReady() {
    super.onReady();
  }

  _validate() {
    if (commentController.text.toString() == "") {
      commentErrorMessage.value = "You cannot send empty message!!";
      return false;
    } else {
      commentErrorMessage.value = "";
    }
    return true;
  }

  addComment() async {
    if (_validate()) {
      ProgressDialogUtils.showProgressDialog();
      AnnouncementComment c = initialAnnouncementComment;
      var name = box.get(HiveKey.name);
      var userID = box.get(HiveKey.userID);
      c.announcementID = data.id;
      c.comment = commentController.text.toString();
      c.senderID = userID;
      c.senderName = name;
      await FireStore().sendAnnouncementComment(c);
      comments.value = await FireStore().getCommentsByAnnouncementID(data.id);
      ProgressDialogUtils.hideProgressDialog();
    }
  }

  @override
  void onClose() {
    super.onClose();
    commentController.dispose();
  }
}
