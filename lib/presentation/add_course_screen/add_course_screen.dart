import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:itu_geo/core/utils/color_constant.dart';
import 'package:itu_geo/core/utils/file_upload_helper.dart';
import 'package:itu_geo/core/utils/size_utils.dart';
import 'package:itu_geo/presentation/add_course_screen/add_course_controller.dart';
import 'package:itu_geo/presentation/teacher_panel_screen/teacher_panel_controller.dart';
import 'package:itu_geo/routes/app_routes.dart';
import 'package:itu_geo/theme/app_decoration.dart';
import 'package:itu_geo/widgets/custom_button.dart';
import 'package:itu_geo/widgets/custom_text_form_field.dart';

class AddCourseScreen extends GetWidget<AddCourseController> {
  FileManager manager = FileManager();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => _onWillPop(context),
        child: SafeArea(
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                bottomNavigationBar: Container(
                    padding: getPadding(all: 24),
                    decoration: AppDecoration.outlineBluegray1000f,
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Obx(() => controller.activeCurrentStep.value == 4
                              ? CustomButton(
                                  variant: ButtonVariant.FillGreen700,
                                  width: double.maxFinite,
                                  text: "lbl_save".tr,
                                  shape: ButtonShape.RoundedBorder10,
                                  padding: ButtonPadding.PaddingAll16,
                                  fontStyle:
                                      ButtonFontStyle.ManropeBold16WhiteA700_1,
                                  onTap: () async => {await _submit()})
                              : CustomButton(
                                  width: double.maxFinite,
                                  text: "lbl_next".tr,
                                  shape: ButtonShape.RoundedBorder10,
                                  padding: ButtonPadding.PaddingAll16,
                                  fontStyle:
                                      ButtonFontStyle.ManropeBold16WhiteA700_1,
                                  onTap: () => {
                                        if (controller.activeCurrentStep.value <
                                            (stepList().length - 1))
                                          {
                                            controller
                                                .activeCurrentStep.value += 1
                                          },
                                        if (controller
                                                .activeCurrentStep.value ==
                                            2)
                                          {controller.calculatePinController()}
                                      }))
                        ])),
                backgroundColor: ColorConstant.whiteA700,
                body: Obx(
                  () => Container(
                    width: double.maxFinite,
                    child: Stepper(
                        controlsBuilder:
                            (BuildContext ctx, ControlsDetails dtl) {
                          return Row(
                            children: <Widget>[
                              TextButton(
                                onPressed: dtl.onStepContinue,
                                child: const Text(true ? '' : 'NEXT'),
                              ),
                              TextButton(
                                onPressed: dtl.onStepCancel,
                                child: const Text(true ? '' : 'CANCEL'),
                              ),
                            ],
                          );
                        },
                        // onStepContinue takes us to the next step
                        onStepContinue: () async {
                          if (controller.activeCurrentStep.value == 3) {
                            await _submit();
                          }
                          if (controller.activeCurrentStep.value <
                              (stepList().length - 1)) {
                            controller.activeCurrentStep.value += 1;
                          }
                          if (controller.activeCurrentStep.value == 2) {
                            controller.calculatePinController();
                          }
                        },

                        // onStepCancel takes us to the previous step
                        onStepCancel: () {
                          if (controller.activeCurrentStep.value == 0) {
                            return;
                          }

                          controller.activeCurrentStep.value -= 1;
                        },
                        elevation: 0,
                        // onStepTap allows to directly click on the particular step we want
                        onStepTapped: (int index) {
                          controller.activeCurrentStep.value = index;
                          if (controller.activeCurrentStep.value == 2) {
                            controller.calculatePinController();
                          }
                        },
                        margin: const EdgeInsets.all(0),
                        physics: const NeverScrollableScrollPhysics(),

                        // physics: const NeverScrollableScrollPhysics(),
                        type: StepperType.horizontal,
                        currentStep: controller.activeCurrentStep.value,
                        steps: stepList()),
                  ),
                ))));
  }

  List<Step> stepList() => [
        Step(
          isActive: controller.activeCurrentStep.value == 0 ? true : false,
          title: const Text(''),
          content: _step1(),
        ),
        Step(
            isActive: controller.activeCurrentStep.value == 1 ? true : false,
            title: const Text(''),
            content: _step2()),
        Step(
            isActive: controller.activeCurrentStep.value == 2 ? true : false,
            title: const Text(''),
            content: _step25()),
        Step(
            isActive: controller.activeCurrentStep.value == 3 ? true : false,
            title: const Text(''),
            content: _step3()),
        Step(
            isActive: controller.activeCurrentStep.value == 4 ? true : false,
            title: const Text(''),
            content: _step4())
      ];

  Widget _step1() {
    return Column(
      children: [
        Obx(() => CustomTextFormField(
            width: 380,
            focusNode: FocusNode(),
            errMessage: controller.courseNameErrorMessage.value,
            controller: controller.courseNameController,
            label: "lbl_course_name".tr,
            hintText: "course name",
            margin: getMargin(left: 24, top: 12, right: 24),
            padding: TextFormFieldPadding.PaddingTB25,
            fontStyle: TextFormFieldFontStyle.UrbanistSemiBold16,
            alignment: Alignment.center,
            // prefix: Container(
            //     margin: getMargin(
            //         left: 21, top: 22, right: 13, bottom: 22),
            //     child: CommonImageView(
            //         svgPath: ImageConstant.imgCheckmark)),
            prefixConstraints: BoxConstraints(
                minWidth: getSize(10.00), minHeight: getSize(10.00)))),
        Obx(() => CustomTextFormField(
            variant: TextFormFieldVariant.FillGray50,
            width: 380,
            label: "lbl_course_code".tr,
            hintText: "Course syllabus code",
            focusNode: FocusNode(),
            errMessage: controller.courseCodeErrorMessage.value,
            controller: controller.courseCodeController,
            margin: getMargin(left: 24, top: 8, right: 24),
            padding: TextFormFieldPadding.PaddingTB25,
            fontStyle: TextFormFieldFontStyle.UrbanistSemiBold16,
            alignment: Alignment.center,
            // prefix: Container(
            //     margin: getMargin(
            //         left: 21, top: 22, right: 13, bottom: 22),
            //     child: CommonImageView(
            //         svgPath: ImageConstant.imgCheckmark)),
            prefixConstraints: BoxConstraints(
                minWidth: getSize(10.00), minHeight: getSize(10.00)))),
        CustomTextFormField(
            variant: TextFormFieldVariant.FillGray50,
            width: 380,
            maxLines: 12,
            label: "lbl_course_description".tr,
            hintText: "course description",
            focusNode: FocusNode(),
            controller: controller.courseDescriptionController,
            margin: getMargin(left: 24, top: 8, right: 24),
            padding: TextFormFieldPadding.PaddingTB25,
            fontStyle: TextFormFieldFontStyle.UrbanistSemiBold16,
            alignment: Alignment.center,
            // prefix: Container(
            //     margin: getMargin(
            //         left: 21, top: 22, right: 13, bottom: 22),
            //     child: CommonImageView(
            //         svgPath: ImageConstant.imgCheckmark)),
            prefixConstraints: BoxConstraints(
                minWidth: getSize(10.00), minHeight: getSize(10.00))),
      ],
    );
  }

  Widget _step2() {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: SizedBox(
        height: 500,
        child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollState) {
              return true;
            },
            child: Stack(
              children: [
                // CustomImageView(svgPath: "assets/images/pin.svg",width: 100,),
                Obx(() => controller.toggle.value || !controller.toggle.value
                    ? GoogleMap(
                        // ignore: invalid_use_of_protected_member
                        markers:
                            Set<Marker>.of(controller.markers.value.values),

                        onTap: (argument) {
                          print(argument.longitude);
                        },
                        myLocationButtonEnabled: true,
                        myLocationEnabled: true,
                        mapType: MapType.terrain,
                        initialCameraPosition: const CameraPosition(
                          target: LatLng(41.102437, 29.020146),
                          zoom: 16.4746,
                        ),
                        onMapCreated: (GoogleMapController c) {
                          controller.mapC.complete(c);
                        },
                      )
                    : Container()),
                Padding(
                  padding: getPadding(bottom: 47),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/images/pin.svg',
                      height: 40,
                      width: 40,
                      fit: BoxFit.fitWidth,
                      // color: color,
                    ),
                  ),
                ),

                Padding(
                  padding: getPadding(bottom: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: GestureDetector(
                                onTap: () async => await _checkLocation(),
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: ColorConstant.yellowLikeBlack,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12))),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Check"),
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: GestureDetector(
                                onTap: () async => await _add(),
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: ColorConstant.yellowLikeBlack,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12))),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Add Pin"),
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: GestureDetector(
                                onTap: () async => await _goToPin(),
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: ColorConstant.yellowLikeBlack,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12))),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Go Pin"),
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.currentPosition.value[0].toString(),
                                textAlign: TextAlign.end,
                              ),
                              Text(
                                controller.currentPosition.value[1].toString(),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: CustomTextFormField(
                                width: double.maxFinite,
                                focusNode: FocusNode(),
                                controller: controller.latController,
                                label: "".tr,
                                maxLines: 2,
                                hintText: "lat",
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        signed: true, decimal: true),
                                margin: getMargin(left: 0, top: 0, right: 2),
                                padding: TextFormFieldPadding.PaddingT13,
                                shape: TextFormFieldShape.RoundedBorder16,
                                fontStyle:
                                    TextFormFieldFontStyle.UrbanistSemiBold16,
                                alignment: Alignment.topCenter,
                                // prefix: Container(
                                //     margin: getMargin(
                                //         left: 21, top: 22, right: 13, bottom: 22),
                                //     child: CommonImageView(
                                //         svgPath: ImageConstant.imgCheckmark)),
                                prefixConstraints: BoxConstraints(
                                    minWidth: getSize(10.00),
                                    minHeight: getSize(10.00)))),
                        Expanded(
                            flex: 1,
                            child: CustomTextFormField(
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        signed: true, decimal: true),
                                width: double.maxFinite,
                                focusNode: FocusNode(),
                                controller: controller.longController,
                                label: "".tr,
                                maxLines: 2,
                                hintText: "long",
                                margin: getMargin(left: 0, top: 0, right: 2),
                                padding: TextFormFieldPadding.PaddingT13,
                                shape: TextFormFieldShape.RoundedBorder16,
                                fontStyle:
                                    TextFormFieldFontStyle.UrbanistSemiBold16,
                                alignment: Alignment.topCenter,
                                // prefix: Container(
                                //     margin: getMargin(
                                //         left: 21, top: 22, right: 13, bottom: 22),
                                //     child: CommonImageView(
                                //         svgPath: ImageConstant.imgCheckmark)),
                                prefixConstraints: BoxConstraints(
                                    minWidth: getSize(10.00),
                                    minHeight: getSize(10.00)))),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget _step25() {
    return Container(
      height: 500,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.pinDetailsController.length,
        itemBuilder: (context, index) {
          // ignore: avoid_print
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: AppDecoration.roundedBlack,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              "lat :${controller.position.value[index][0]}\nlong :${controller.position.value[index][1]}"),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: CustomTextFormField(
                            width: double.maxFinite,
                            focusNode: FocusNode(),
                            controller: controller.pinDetailsController[index],
                            label: "Pin Special Name".tr,
                            margin: getMargin(top: 2, bottom: 2),
                            padding: TextFormFieldPadding.PaddingTB25,
                            fontStyle:
                                TextFormFieldFontStyle.UrbanistSemiBold16,
                            alignment: Alignment.center,
                            prefixConstraints: BoxConstraints(
                                minWidth: getSize(10.00),
                                minHeight: getSize(10.00))),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<bool> _onWillPop(BuildContext context) async {
    return (await Get.defaultDialog(
            actions: [
              GestureDetector(
                onTap: () => {
                  Get.back(),
                  Get.back(),
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(
                    fontStyle: ButtonFontStyle.UrbanistRomanBold16,
                    text: "lbl_yes".tr,
                    width: getHorizontalSize(75),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Get.back(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(
                    fontStyle: ButtonFontStyle.UrbanistRomanBold16,
                    text: "lbl_no".tr,
                    width: getHorizontalSize(75),
                  ),
                ),
              ),
            ],
            title: "",
            middleText: "msg_exit_add_course".tr,
            backgroundColor: ColorConstant.whiteA700,
            titleStyle: TextStyle(color: ColorConstant.black900),
            middleTextStyle: TextStyle(color: ColorConstant.black900),
            radius: 30)) ??
        false;
  }

  Future<void> _goToPin() async {
    if (controller.latController.text != "" &&
        controller.longController.text != "") {
      double lat = double.parse(controller.latController.text);
      double long = double.parse(controller.longController.text);

      CameraPosition kLake = CameraPosition(
        target: LatLng(lat, long),
        zoom: 16.4746,
      );

      final GoogleMapController cc = await controller.mapC.future;
      cc.animateCamera(CameraUpdate.newCameraPosition(kLake));
    }
  }

  Future<void> _add() async {
    final String markerIdVal = '${controller.markerIdCounter.value}';
    controller.markerIdCounter.value += 1;
    final MarkerId markerId = MarkerId(markerIdVal);
    var position = await getCenter();
    final Marker marker = Marker(
      onTap: () async => await controller.updateCurrentPosition(),
      markerId: markerId,
      position: position,
      infoWindow: InfoWindow(
          onTap: () {
            Get.defaultDialog(
                barrierDismissible: false,
                actions: [],
                title: "",
                content: SizedBox(
                  width: getHorizontalSize(500),
                  height: getVerticalSize(600),
                  child: _buildPinMoreInfoWidget(markerId),
                ),
                middleText: "msg_exit_quiz".tr,
                backgroundColor: ColorConstant.whiteA700,
                titleStyle: TextStyle(color: ColorConstant.black900),
                middleTextStyle: TextStyle(color: ColorConstant.black900),
                radius: 30);
          },
          title: markerIdVal,
          snippet: ''),
      // onTap: () => _onMarkerTapped(markerId),
      onDragEnd: (LatLng position) => print("gell"),
      // onDrag: (LatLng position) => _onMarkerDrag(markerId, position),
    );

    controller.markers.value[markerId] = marker;
    controller.toggle(!controller.toggle.value);
    updatePosition();
  }

  Future<LatLng> getCenter() async {
    // final GoogleMapController c = await controller.mapC.future;

    LatLngBounds visibleRegion = await controller.c.getVisibleRegion();
    LatLng centerLatLng = LatLng(
      (visibleRegion.northeast.latitude + visibleRegion.southwest.latitude) / 2,
      (visibleRegion.northeast.longitude + visibleRegion.southwest.longitude) /
          2,
    );

    return centerLatLng;
  }

  updatePosition() {
    var l = [];
    controller.markers.value.forEach((key, value) {
      l.add([value.position.latitude, value.position.longitude]);
    });
    controller.position.value = l;
  }

  Widget _step3() {
    return SizedBox(
      height: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
              .size
              .longestSide -
          200,
      child: Column(
        children: [
          Padding(
            padding: getPadding(bottom: 12),
            child: Row(
              children: [
                Expanded(
                    flex: 5,
                    child: GestureDetector(
                      onTap: () => manager.filePickerMethod(
                        15000000,
                        [
                          "png",
                          "jpeg",
                          "pdf",
                          "xml",
                          "doc",
                          "docx",
                          "zip",
                          "rar",
                          "jpg"

                        ],
                        getFiles: (p0) => controller.setAttachmentPath(p0),
                      ),
                      //     Get.toNamed(AppRoutes.addNewBoxScreen),
                      child: Padding(
                        padding: getPadding(left: 8),
                        child: Text(
                          "Add Attachment".tr,
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
          Expanded(
              flex: 1,
              child: Obx(
                () => GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 90 / 60,
                    crossAxisCount: 2,
                  ),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: false,
                  itemCount: controller.attachments.length,
                  itemBuilder: (context, index) {
                    String? model = controller.attachments.value[index];
                    int start = model!.lastIndexOf("/");
                    String name = model.substring(start + 1);

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 200,
                        decoration: AppDecoration.fillGray52,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                name,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )),
        ],
      ),
    );
  }

  Widget _step4() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                "Course Name : ${controller.courseNameController.text.toString()}"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                "Course Code : ${controller.courseCodeController.text.toString()}"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                "Course Description : ${controller.courseDescriptionController.text.toString()}"),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                "Number of attachment : ${controller.attachments.length.toString()}"),
          ),
          const Divider(),
          // ignore: prefer_const_constructors
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Center(child: Text("Pins")),
          ),
          SizedBox(
            height: 300,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.position.value.length,
              itemBuilder: (context, index) {
                // ignore: avoid_print
                var model = controller.position.value[index];
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    decoration: AppDecoration.roundedBlack,
                    child: Column(
                      children: [
                        Text("Lat: ${model[0]}"),
                        Text("Long: ${model[1]}"),
                        controller.pinDetailsController.length ==
                                controller.position.length
                            ? (controller.pinDetailsController.value[index]
                                        .text
                                        .toString() !=
                                    "")
                                ? Text(
                                    "Special Name: ${controller.pinDetailsController.value[index].text.toString()}")
                                : Container()
                            : Container(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  _submit() async {
    if (controller.validate()) {
      final teacherController = Get.find<TeacherPanelController>();
      await controller.createCourse();
      Get.offNamedUntil(AppRoutes.dashboardScreen, (route) => false);
      Get.toNamed(AppRoutes.createCourseSuccessScreen);
      await teacherController.updateCourseData();
    }
  }

  _checkLocation() async {
    await controller.updateCurrentPosition();
  }

  _buildPinMoreInfoWidget(MarkerId markerId) {
    return Column(
      children: [
        Expanded(
          flex: 6,
          child: Column(
            children: [
              CustomTextFormField(
                  width: double.maxFinite,
                  focusNode: FocusNode(),
                  controller: controller.pinCodeController,
                  label: "Pin Name (Optional)".tr,
                  hintText: "Enter pin specific code ",
                  margin: getMargin(left: 24, top: 12, right: 24),
                  padding: TextFormFieldPadding.PaddingTB25,
                  fontStyle: TextFormFieldFontStyle.UrbanistSemiBold16,
                  alignment: Alignment.center,
                  prefixConstraints: BoxConstraints(
                      minWidth: getSize(10.00), minHeight: getSize(10.00))),
              CustomTextFormField(
                  width: double.maxFinite,
                  focusNode: FocusNode(),
                  controller: controller.pinDescriptionController,
                  label: "Pin Description (Optional)".tr,
                  hintText: "Enter pin description",
                  margin: getMargin(left: 24, top: 12, right: 24),
                  padding: TextFormFieldPadding.PaddingTB25,
                  fontStyle: TextFormFieldFontStyle.UrbanistSemiBold16,
                  alignment: Alignment.center,
                  // prefix: Container(
                  //     margin: getMargin(
                  //         left: 21, top: 22, right: 13, bottom: 22),
                  //     child: CommonImageView(
                  //         svgPath: ImageConstant.imgCheckmark)),
                  prefixConstraints: BoxConstraints(
                      minWidth: getSize(10.00), minHeight: getSize(10.00))),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: getPadding(top: 24),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: CustomButton(
                        variant: ButtonVariant.FillGreen700,
                        width: double.maxFinite,
                        text: "lbl_save".tr,
                        shape: ButtonShape.RoundedBorder10,
                        padding: ButtonPadding.PaddingAll16,
                        fontStyle: ButtonFontStyle.ManropeBold16WhiteA700_1,
                        onTap: () async => {await _submit()}),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: CustomButton(
                        variant: ButtonVariant.FillGreen700,
                        width: double.maxFinite,
                        text: "lbl_save".tr,
                        shape: ButtonShape.RoundedBorder10,
                        padding: ButtonPadding.PaddingAll16,
                        fontStyle: ButtonFontStyle.ManropeBold16WhiteA700_1,
                        onTap: () async => {await _submit()}),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
