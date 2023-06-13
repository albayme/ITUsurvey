import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itu_geo/core/utils/color_constant.dart';
import 'package:itu_geo/models/user_model.dart';
import 'package:itu_geo/routes/app_routes.dart';
import 'package:itu_geo/theme/app_decoration.dart';
import 'package:itu_geo/widgets/common_image_view.dart';
import 'dart:math' as math;

import '../../core/utils/size_utils.dart';
import 'teacher_panel_controller.dart';

class TeacherPanelScreen extends GetWidget<TeacherPanelController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            floatingActionButton: Obx(() => controller.isPending.value
                ? Container()
                : _buildLeadingList(context)),
            appBar: AppBar(
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
              title: const Center(
                  child: Text(
                "Tutor Panel",
                style: TextStyle(color: Colors.black),
              )),
              backgroundColor: Colors.white,
              actions: [
                Obx(() => controller.isPending.value
                    ? Container()
                    : PopupMenuButton(
                        icon: Transform.rotate(
                          angle: -math.pi / 1,
                          child: CommonImageView(
                            svgPath: "assets/images/img_arrowup.svg",
                          ),
                        ),
                        // add icon, by default "3 dot" icon
                        // icon: Icon(Icons.book)
                        itemBuilder: (context) {
                          // ignore: invalid_use_of_protected_member
                          return controller.dropdownData.value;
                        },
                        onSelected: (value) async {
                          await controller.changeSelectedCourse(value);
                          await controller.getAnnocument();
                        })),
              ],
            ),
            backgroundColor: ColorConstant.whiteA700,
            body: SingleChildScrollView(
              child: Obx(
                  () => (controller.toogle.value || !controller.toogle.value)
                      ? controller.isPending.value
                          ? Container(
                              child: const Center(
                                child: Text(
                                    "Your account's still under review process \n Please wait until approved by admin \n You can connect via info@itugeo.com"),
                              ),
                            )
                          : Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: _buildYourCourseWidget()),
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Obx(() => Row(
                                                      children: [
                                                        Expanded(
                                                            flex: 1,
                                                            child:
                                                                _buildStudentActivityWidget()),
                                                        Expanded(
                                                            flex: 1,
                                                            child:
                                                                _buildTotalStudentWidget()),
                                                      ],
                                                    )),
                                                Obx(
                                                  () => Row(
                                                    children: [
                                                      Expanded(
                                                          flex: 1,
                                                          child:
                                                              _buildNumberOfAnnouncumentWidget()),
                                                      Expanded(
                                                          flex: 1,
                                                          child:
                                                              _buildNumberOfAttachementWidget())
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ))
                                  ],
                                ),
                                Padding(
                                  padding: getPadding(top: 2),
                                  child: GestureDetector(
                                    onTap: () => Get.toNamed(
                                        AppRoutes.mapViewScreen,
                                        arguments: [
                                          controller.selectedCourseData.value,
                                          controller.studentActivities.value
                                        ]),
                                    child: Container(
                                      width: double.maxFinite,
                                      decoration: AppDecoration.fillGray100,
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              "Map Pins",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontFamily: 'urbanist',
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Padding(
                                              padding: getPadding(
                                                  left: 18, top: 8, bottom: 8),
                                              child: Container(
                                                decoration: AppDecoration
                                                    .fillGray50
                                                    .copyWith(
                                                        shape: BoxShape.circle,
                                                        borderRadius: null),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Obx(
                                                    () => Text(
                                                      (controller
                                                                  .selectedCourseData
                                                                  .value
                                                                  .coordinates
                                                                  .length +
                                                              controller
                                                                  .totalCurrentStudentPins
                                                                  .value)
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          fontFamily:
                                                              'urbanist',
                                                          fontWeight:
                                                              FontWeight.bold),
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
                                _buildActivitiesWidget2()
                              ],
                            )
                      : Container()),
            )));
  }

  Widget _buildActivitiesWidget2() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Obx(() => Padding(
            padding: const EdgeInsets.all(4.0),
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
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4))),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () => Get.toNamed(
                                    AppRoutes.viewActivityScreen,
                                    arguments: [
                                      model,
                                      true,
                                      true,
                                      controller.selectedCourseData.value
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
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: 90,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
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
                                                    bottom: 4,
                                                    left: 2,
                                                    right: 2),
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
                                                    bottom: 4,
                                                    left: 2,
                                                    right: 2),
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
          )),
    );
  }

  Widget _buildYourCourseWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            const Text(
              "\nNAME",
              style: TextStyle(
                  fontFamily: 'urbanist', fontWeight: FontWeight.bold),
            ),
            Text(controller.selectedCourseData.value.name),
            const Text(
              "\nLESSON CODE",
              style: TextStyle(
                  fontFamily: 'urbanist', fontWeight: FontWeight.bold),
            ),
            Text(controller.selectedCourseData.value.lessonCode),
            const Text(
              "\nINVITE CODE",
              style: TextStyle(
                  fontFamily: 'urbanist', fontWeight: FontWeight.bold),
            ),
            Text(controller.selectedCourseData.value.code),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentLastActivityWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.maxFinite,
        child: InkWell(
          onTap: () => {},
          child: Container(
            height: 400,
            decoration:
                AppDecoration.fillGray50.copyWith(shape: BoxShape.rectangle),
            child: Column(
              children: const [],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTotalStudentWidget() {
    return Container(
      width: double.maxFinite,
      child: InkWell(
        onTap: () =>
            {Get.toNamed(AppRoutes.waitingStudentsScreen, arguments: false)},
        child: Container(
          height: 80,
          decoration:
              AppDecoration.fillGray50.copyWith(shape: BoxShape.rectangle),
          child: Column(
            children: [
              const Text(
                " Total\nStudents",
                style: TextStyle(
                    fontFamily: 'urbanist', fontWeight: FontWeight.bold),
              ),
              Container(
                decoration: AppDecoration.gradientOrangeA400OrangeA200
                    .copyWith(shape: BoxShape.circle, borderRadius: null),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    controller.selectedCourseData.value.students.length
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
      ),
    );
  }

  Widget _buildNumberOfAnnouncumentWidget() {
    return SizedBox(
      width: double.maxFinite,
      child: InkWell(
        onTap: () =>
            {Get.toNamed(AppRoutes.listAnnouncementScreen, arguments: true)},
        child: Container(
          height: 80,
          decoration:
              AppDecoration.fillGray50.copyWith(shape: BoxShape.rectangle),
          child: Column(
            children: [
              const Text(
                "Total\nAnnouncument",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'urbanist',
                    fontWeight: FontWeight.bold),
              ),
              Container(
                decoration: AppDecoration.gradientOrangeA400OrangeA200
                    .copyWith(shape: BoxShape.circle, borderRadius: null),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    controller.announcementData.value.length.toString(),
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
      ),
    );
  }

  Widget _buildNumberOfAttachementWidget() {
    return SizedBox(
      width: double.maxFinite,
      child: InkWell(
        onTap: () =>
            {Get.toNamed(AppRoutes.listAttachementScreen, arguments: false)},
        child: Container(
          height: 80,
          decoration:
              AppDecoration.fillGray50.copyWith(shape: BoxShape.rectangle),
          child: Column(
            children: [
              const Text(
                "Total\nAttachement",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'urbanist',
                    fontWeight: FontWeight.bold),
              ),
              Container(
                decoration: AppDecoration.gradientOrangeA400OrangeA200
                    .copyWith(shape: BoxShape.circle, borderRadius: null),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    controller.selectedCourseData.value.documentRef.length
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
      ),
    );
  }

  Widget _buildStudentActivityWidget() {
    return Container(
      width: double.maxFinite,
      child: InkWell(
        onTap: () =>
            {Get.toNamed(AppRoutes.waitingStudentsScreen, arguments: true)},
        child: Container(
          height: 80,
          decoration:
              AppDecoration.fillGray50.copyWith(shape: BoxShape.rectangle),
          child: Column(
            children: [
              const Text(
                " Waiting\nStudents",
                style: TextStyle(
                    fontFamily: 'urbanist', fontWeight: FontWeight.bold),
              ),
              Container(
                decoration: AppDecoration.gradientOrangeA400OrangeA200
                    .copyWith(shape: BoxShape.circle, borderRadius: null),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    controller.selectedCourseData.value.waitingStudents.length
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
      ),
    );
  }

  Widget _buildLeadingList(BuildContext context) {
    bool isTablet = isDeviceTablet();
    return Padding(
      padding: getPadding(right: 12),
      child: Container(
        decoration: const BoxDecoration(
            shape: BoxShape.circle, color: Colors.amberAccent),
        height: isTablet ? 100 : 50,
        width: isTablet ? 100 : 50,
        child: SpeedDial(
          // buttonSize: const Size(2, 2),
          spaceBetweenChildren: 0,
          elevation: 0.0,
          // childMargin: const EdgeInsets.all(10),
          childrenButtonSize:
              isTablet ? const Size(80, 80) : const Size(42, 42),
          animationCurve: Curves.ease,
          isOpenOnStart: false,
          childPadding: const EdgeInsets.all(5),
          icon: Icons.add,
          activeIcon: Icons.close,
          backgroundColor: Colors.transparent,
          activeBackgroundColor: Colors.transparent,
          foregroundColor: ColorConstant.black900,
          overlayColor: Colors.transparent,
          spacing: 3,
          direction: SpeedDialDirection.up,
          // mini: tr,
          openCloseDial: controller.dialOpen.value,
          children: [
            SpeedDialChild(
              child: !controller.rmicons.value ? const Icon(Icons.work) : null,
              backgroundColor: Colors.red,
              foregroundColor: ColorConstant.whiteA700,
              label: 'Add Course',
              labelStyle: isTablet
                  ? const TextStyle(fontSize: 30)
                  : const TextStyle(fontSize: 14),
              onTap: () => {Get.toNamed(AppRoutes.addCourseScreen)},
            ),
            SpeedDialChild(
              child: !controller.rmicons.value
                  ? const Icon(Icons.brush_sharp)
                  : null,
              backgroundColor: Colors.deepOrange,
              foregroundColor: ColorConstant.whiteA700,
              labelStyle: isTablet
                  ? const TextStyle(fontSize: 30)
                  : const TextStyle(fontSize: 14),
              label: 'Add Announcement',
              onTap: () => {Get.toNamed(AppRoutes.addAnnouncementScreen)},
            ),
          ],
        ),
      ),
    );
  }
}
