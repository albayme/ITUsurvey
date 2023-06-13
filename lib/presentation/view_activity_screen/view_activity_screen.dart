import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itu_geo/core/firebase/firestore.dart';
import 'package:itu_geo/core/utils/color_constant.dart';
import 'package:itu_geo/core/utils/file_upload_helper.dart';
import 'package:itu_geo/core/utils/size_utils.dart';
import 'package:itu_geo/routes/app_routes.dart';
import 'package:itu_geo/theme/app_decoration.dart';
import 'package:itu_geo/widgets/custom_button.dart';

import 'view_activity_controller.dart';

class ViewActivityScreen extends GetWidget<ViewActivityController> {
  FileManager manager = FileManager();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            bottomNavigationBar: Container(
                padding: getPadding(all: 24),
                decoration: AppDecoration.outlineBluegray1000f,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Obx(
                      //   () => controller.isDeletable.value
                      //       ? Padding(
                      //           padding: getPadding(bottom: 12),
                      //           child: CustomButton(
                      //               variant: ButtonVariant.GradientYellow,
                      //               width: double.maxFinite,
                      //               text: "Edit".tr,
                      //               shape: ButtonShape.RoundedBorder10,
                      //               padding: ButtonPadding.PaddingAll16,
                      //               fontStyle: ButtonFontStyle
                      //                   .ManropeBold16WhiteA700_1,
                      //               onTap: () async => {
                      //                     Get.toNamed(
                      //                         AppRoutes.addActivityScreen,
                      //                         arguments: [
                      //                           controller.courseData.value,
                      //                           true
                      //                         ])
                      //                   }),
                      //         )
                      //       : Container(),
                      // ),
                      Obx(
                        () => controller.isDeletable.value
                            ? CustomButton(
                                variant: ButtonVariant.GradientRed,
                                width: double.maxFinite,
                                text: "Delete".tr,
                                shape: ButtonShape.RoundedBorder10,
                                padding: ButtonPadding.PaddingAll16,
                                fontStyle:
                                    ButtonFontStyle.ManropeBold16WhiteA700_1,
                                onTap: () async => {
                                      Get.defaultDialog(
                                          actions: [
                                            GestureDetector(
                                              onTap: () async => {
                                                await FireStore()
                                                    .deleteActivity(controller
                                                        .data.value.id),
                                                Get.back(),
                                                if (controller.isTeacher.value)
                                                  {
                                                    await controller
                                                        .teacherPanelController
                                                        .updateStudentActivities()
                                                  }
                                                else
                                                  {
                                                    await controller
                                                        .studentPanelController
                                                        .updateStudentActivity()
                                                  },
                                                Get.back(),
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: CustomButton(
                                                  fontStyle: ButtonFontStyle
                                                      .UrbanistRomanBold16,
                                                  text: "lbl_yes".tr,
                                                  width: getHorizontalSize(75),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () => Get.back(),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: CustomButton(
                                                  fontStyle: ButtonFontStyle
                                                      .UrbanistRomanBold16,
                                                  text: "lbl_no".tr,
                                                  width: getHorizontalSize(75),
                                                ),
                                              ),
                                            ),
                                          ],
                                          title: "",
                                          middleText:
                                              "Are you sure delete this activity?"
                                                  .tr,
                                          backgroundColor:
                                              ColorConstant.whiteA700,
                                          titleStyle: TextStyle(
                                              color: ColorConstant.black900),
                                          middleTextStyle: TextStyle(
                                              color: ColorConstant.black900),
                                          radius: 30)
                                    })
                            : Container(),
                      )
                    ])),
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
                "View Activity",
                style: TextStyle(color: Colors.black),
              )),
              backgroundColor: Colors.white,
            ),
            backgroundColor: ColorConstant.whiteA700,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      decoration: AppDecoration.fillGrayCircle,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text("name : " + controller.data.value.name),
                            Text("surname : " + controller.data.value.surname),
                            Text("email : " + controller.data.value.email),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => controller.isTeacher.value
                        ? SizedBox(
                            height: 200,
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:
                                  controller.data.value.documentRef.length,
                              itemBuilder: (context, index) {
                                // ignore: avoid_print
                                var model =
                                    controller.data.value.documentRef[index];
                                return Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: GestureDetector(
                                    onTap: () async {
                                      final storageRef =
                                          FirebaseStorage.instance.ref();
                                      var islandRef = storageRef.child(model);
                                      var url = await islandRef
                                          .getDownloadURL()
                                          .then((value) async => {
                                                await manager.downloadFile(
                                                    value, model)
                                              });
                                    },
                                    child: Container(
                                      decoration: AppDecoration.fillGray50,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Text(
                                              "${index + 1}. $model",
                                              overflow: TextOverflow.fade,
                                              style: const TextStyle(
                                                  fontFamily: 'urbanist',
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : Container(),
                  ),
                  SizedBox(
                    height: 500,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.data.value.specialNames.length,
                      itemBuilder: (context, index) {
                        // ignore: avoid_print
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            decoration: AppDecoration.roundedBlack,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                      "Lat: ${controller.data.value.coordinates[index].latitude}"),
                                  Text(
                                      "Lat: ${controller.data.value.coordinates[index].longitude}"),

                                  // Text("Long: ${model[1]}"),
                                  Text(
                                      "Special Name: ${controller.data.value.specialNames[index]}"),
                                  Text(
                                      "Activitiy: ${controller.data.value.studentActivity[index]}"),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            )));
  }
}
