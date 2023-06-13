import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itu_geo/core/utils/color_constant.dart';
import 'package:itu_geo/core/utils/size_utils.dart';
import 'package:itu_geo/models/user_model.dart';
import 'package:itu_geo/presentation/admin_panel_screen/widget/list_favorite_worddata.dart';

import 'waiting_students_controller.dart';

class WaitingStudentScreen extends GetWidget<WaitingStudentController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              leadingWidth: 50,
              leading: InkWell(
                  onTap: () => Get.back(),
                  child: Padding(
                    padding: getPadding(left: 8, right: 8),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  )),
              title: const Center(
                  child: Text(
                "Student List",
                style: TextStyle(color: Colors.black),
              )),
              backgroundColor: Colors.white,
            ),
            backgroundColor: ColorConstant.whiteA700,
            body: Column(
              children: [
                Obx(() => _buildPendingUserWidget()),
              ],
            )));
  }

  _buildPendingUserWidget() {
    return Padding(
      padding: getPadding(top: 12
          // right: 10,
          ),
      child: RefreshIndicator(
        onRefresh: () => controller.refleshData(),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: controller.data.length,
          itemBuilder: (context, index) {
            UserData model = controller.data.value[index];
            return controller.isWaiting.value
                ? model.isPending
                    ? ListUserDataWidget(model, () async {
                        await controller.updateData(model.id);
                      })
                    : Container()
                : ListUserDataWidget(model, () async {
                    await controller.updateData(model.id);
                  });
          },
        ),
      ),
    );
  }
}
