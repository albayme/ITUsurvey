import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itu_geo/core/utils/color_constant.dart';
import 'package:itu_geo/core/utils/size_utils.dart';
import 'package:itu_geo/models/user_model.dart';
import 'package:itu_geo/routes/app_routes.dart';
import 'package:itu_geo/theme/app_decoration.dart';
import 'package:itu_geo/widgets/app_bar/appbar_title.dart';
import 'package:itu_geo/widgets/app_bar/custom_app_bar.dart';

import 'studen_panel_controller.dart';

class StudentPanelScreen extends GetWidget<StudentPanelController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: CustomAppBar(
        leadingWidth: 50,
        leading: InkWell(
            onTap: () => Scaffold.of(context).openDrawer(),
            child: Padding(
              padding: getPadding(left: 8, right: 8),
              child: const Icon(
                Icons.menu_open,
                color: Colors.black,
              ),
            )),
        height: getVerticalSize(
          56.00,
        ),
        title: AppbarTitle(
          text: "Student Panel".tr,
          margin: getMargin(
              // left: 16,
              ),
        ),
      ),
      backgroundColor: ColorConstant.whiteA700,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(() => Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            width: double.maxFinite,
                            decoration: AppDecoration.fillGray50,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  "Course name: ${controller.courseData.value.name}"),
                            ),
                          )),
                      Expanded(
                          flex: 1,
                          child: Container(
                            width: double.maxFinite,
                            decoration: AppDecoration.fillGray50,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  "Course Code: ${controller.courseData.value.lessonCode}"),
                            ),
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 8,
                          child: GestureDetector(
                            onTap: () => controller
                                    .announcementData.value.isEmpty
                                ? {}
                                : Get.toNamed(AppRoutes.listAnnouncementScreen,
                                    arguments: false),
                            child: Container(
                              decoration: AppDecoration.fillGray100,
                              child: Column(
                                children: [
                                  const Text(
                                    "Annoucement",
                                    style: TextStyle(
                                        fontFamily: 'urbanist',
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    decoration: AppDecoration
                                        .gradientOrangeA400OrangeA200
                                        .copyWith(
                                            shape: BoxShape.circle,
                                            borderRadius: null),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        controller.announcementData.value.length
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 24,
                                            fontFamily: 'urbanist',
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                      const Expanded(flex: 1, child: SizedBox()),
                      Expanded(
                          flex: 8,
                          child: GestureDetector(
                            onTap: () => controller
                                    .courseData.value.documentRef.isEmpty
                                ? {}
                                : Get.toNamed(AppRoutes.listAttachementScreen,
                                    arguments: false),
                            child: Container(
                              decoration: AppDecoration.fillGray100,
                              child: Column(
                                children: [
                                  const Text(
                                    "Attachements",
                                    style: TextStyle(
                                        fontFamily: 'urbanist',
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    decoration: AppDecoration
                                        .gradientOrangeA400OrangeA200
                                        .copyWith(
                                            shape: BoxShape.circle,
                                            borderRadius: null),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        controller
                                            .courseData.value.documentRef.length
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 24,
                                            fontFamily: 'urbanist',
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ],
                  ),
                  Padding(
                    padding: getPadding(top: 12),
                    child: GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.mapViewScreen,
                          arguments: [
                            controller.courseData.value,
                            controller.currentStudentData
                          ]),
                      child: Container(
                        width: double.maxFinite,
                        decoration: AppDecoration.fillGray100,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Map Pins",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'urbanist',
                                    fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding:
                                    getPadding(left: 18, top: 8, bottom: 8),
                                child: Container(
                                  decoration: AppDecoration.fillGray50.copyWith(
                                      shape: BoxShape.circle,
                                      borderRadius: null),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Obx(
                                      () => Text(
                                        (controller.courseData.value.coordinates
                                                    .length +
                                                controller
                                                    .totalCurrentStudentPins
                                                    .value)
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'urbanist',
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Divider(),
                  ),
                  Padding(
                    padding: getPadding(bottom: 12),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 5,
                            child: GestureDetector(
                              onTap: () => Get.toNamed(
                                  AppRoutes.addActivityScreen,
                                  arguments: [controller.courseData.value,false]),
                              child: Padding(
                                padding: getPadding(left: 8),
                                child: Text(
                                  "(+) Add Activity".tr,
                                  style: TextStyle(
                                      fontSize: isDeviceTablet() ? 24 : 16,
                                      color: ColorConstant.redA700,
                                      fontFamily: 'urbanist',
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            )),
                        const Expanded(
                          flex: 4,
                          child: Divider(),
                        ),
                      ],
                    ),
                  ),
                  _buildActivitiesWidget()
                ],
              )),
        ),
      ),
    ));
  }

  Widget _buildActivitiesWidget() {
    return Obx(() => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: AppDecoration.fillGray50,
            child: Column(children: [
              SizedBox(
                height: 400,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: controller.studentActivities.value.length,
                  itemBuilder: (context, index) {
                    StudentData model =
                        controller.studentActivities.value[index];
                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        decoration: AppDecoration.gradientOrangeA400OrangeA200
                            .copyWith(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(4))),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () => Get.toNamed(
                                  AppRoutes.viewActivityScreen,
                                  arguments: [
                                    model,
                                    model.email == controller.studentEmail,
                                    false,
                                    controller.courseData.value
                                  ]),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: 100,
                                      child: Text(
                                        "  ${model.name}  ${model.surname}",
                                        style: const TextStyle(
                                            fontFamily: 'urbanist'),
                                        softWrap: true,
                                        overflow: TextOverflow.fade,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    DateFormat('dd/MM/yyyy, HH:mm')
                                        .format(model.created.toDate()),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(
                                    width: 90,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Column(
                                          children: [
                                            Padding(
                                              padding: getPadding(
                                                  top: 4, left: 2, right: 2),
                                              child: Icon(
                                                Icons.pin_drop,
                                                size: 25,
                                                color: Colors.red,
                                              ),
                                            ),
                                            Padding(
                                              padding: getPadding(
                                                  bottom: 4, left: 2, right: 2),
                                              child: Text(
                                                "${model.specialNames.length}",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Padding(
                                              padding: getPadding(
                                                  top: 4, left: 2, right: 2),
                                              child: Icon(
                                                Icons.file_download,
                                                size: 25,
                                                color: Colors.greenAccent,
                                              ),
                                            ),
                                            Padding(
                                              padding: getPadding(
                                                  bottom: 4, left: 2, right: 2),
                                              child: Text(
                                                "${model.documentRef.length}",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ]),
          ),
        ));
  }

  List<Step> stepList() => [
        Step(
          isActive: controller.activeCurrentStep.value == 0 ? true : false,
          title: const Text(''),
          content: Container(),
        ),
      ];
}
