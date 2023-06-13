import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:itu_geo/core/constant/constants.dart';
import 'package:itu_geo/core/firebase/analytic.dart';
import 'package:itu_geo/core/firebase/firestore.dart';
import 'package:itu_geo/core/hive/hive_data.dart';
import 'package:itu_geo/core/network/network_info.dart';
import 'package:itu_geo/core/utils/color_constant.dart';
import 'package:itu_geo/core/utils/image_constant.dart';
import 'package:itu_geo/core/utils/progress_dialog_utils.dart';
import 'package:itu_geo/core/utils/size_utils.dart';
import 'package:itu_geo/models/course_model.dart';
import 'package:itu_geo/models/user_model.dart';
import 'package:itu_geo/routes/app_routes.dart';
import 'package:itu_geo/theme/app_decoration.dart';
import 'package:itu_geo/theme/app_style.dart';
import 'package:itu_geo/widgets/common_image_view.dart';
import 'package:itu_geo/widgets/custom_button.dart';
import 'package:itu_geo/widgets/custom_text_form_field.dart';

import 'controller/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpScreen extends GetWidget<SignUpController> {
  var analytic = FirebaseAnalytic();
  final _network = Get.find<NetworkInfo>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniCenterDocked,
            floatingActionButton: MediaQuery.of(context).viewInsets.bottom == 0
                ? GestureDetector(
                    onTap: () => {signUp()},
                    child: Container(
                      width: double.infinity,
                      height: getVerticalSize(60),
                      decoration: AppDecoration.txtFillGray800,
                      child: Center(
                          child: Text(
                        "lbl_sign_up".tr,
                        style: AppStyle.txtUrbanistRomanBold16RedA702.copyWith(
                            letterSpacing: 0.10,
                            fontSize: 18,
                            color: Colors.white),
                      )),
                    ),
                  )
                : Container(),
            backgroundColor: ColorConstant.whiteA700,
            body: SingleChildScrollView(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                  Padding(
                      padding: getPadding(left: 28, top: 24, right: 28),
                      child: InkWell(
                          onTap: () {
                            onTapImgArrowleft();
                          },
                          child: CommonImageView(
                              svgPath: ImageConstant.imgArrowleft,
                              height: getVerticalSize(15.00),
                              width: getHorizontalSize(19.00)))),
                  Align(
                      alignment: Alignment.center,
                      child: Padding(
                          padding: getPadding(left: 24, top: 48, right: 24),
                          child: Text("msg_create_your_acc".tr,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtUrbanistRomanBold32))),
                  Obx(() => Padding(
                        padding: getPadding(top: 12),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: getPadding(left: 24, right: 12),
                                  child: CustomButton(
                                    onTap: () => controller.isTeacher(true),
                                    text: "Tutor",
                                    fontStyle: controller.isTeacher.value
                                        ? ButtonFontStyle.UrbanistRomanBold18
                                        : ButtonFontStyle
                                            .UrbanistRomanBold18Gray802,
                                    variant: controller.isTeacher.value
                                        ? ButtonVariant.OutlineGreen800
                                        : ButtonVariant.OutlineGray800,
                                    width: double.maxFinite,
                                  ),
                                )),
                            Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: getPadding(left: 12, right: 24),
                                  child: CustomButton(
                                    onTap: () => controller.isTeacher(false),
                                    text: "Student",
                                    fontStyle: !controller.isTeacher.value
                                        ? ButtonFontStyle.UrbanistRomanBold18
                                        : ButtonFontStyle
                                            .UrbanistRomanBold18Gray802,
                                    variant: !controller.isTeacher.value
                                        ? ButtonVariant.OutlineGreen800
                                        : ButtonVariant.OutlineGray800,
                                    width: double.maxFinite,
                                  ),
                                ))
                          ],
                        ),
                      )),
                  Obx(() => CustomTextFormField(
                      width: 380,
                      errMessage: controller.emailErrorMessage.value,
                      focusNode: FocusNode(),
                      controller: controller.statusDefaultController,
                      hintText: "lbl_email".tr,
                      margin: getMargin(left: 24, top: 46, right: 24),
                      padding: TextFormFieldPadding.PaddingTB25,
                      fontStyle: TextFormFieldFontStyle.UrbanistSemiBold20,
                      alignment: Alignment.center,
                      prefix: Container(
                          margin: getMargin(
                              left: 21, top: 22, right: 13, bottom: 22),
                          child: CommonImageView(
                              svgPath: ImageConstant.imgCheckmark)),
                      prefixConstraints: BoxConstraints(
                          minWidth: getSize(15.00),
                          minHeight: getSize(15.00)))),
                  Obx(() => CustomTextFormField(
                      width: 380,
                      errMessage: controller.emailErrorMessage.value,
                      focusNode: FocusNode(),
                      controller: controller.nameController,
                      hintText: "lbl_name".tr,
                      margin: getMargin(left: 24, top: 20, right: 24),
                      padding: TextFormFieldPadding.PaddingTB25,
                      fontStyle: TextFormFieldFontStyle.UrbanistSemiBold20,
                      alignment: Alignment.center,
                      prefix: Container(
                          margin: getMargin(
                              left: 21, top: 22, right: 13, bottom: 22),
                          child: CommonImageView(
                              svgPath: ImageConstant.imgCheckmark)),
                      prefixConstraints: BoxConstraints(
                          minWidth: getSize(15.00),
                          minHeight: getSize(15.00)))),
                  Obx(() => CustomTextFormField(
                      width: 380,
                      errMessage: controller.emailErrorMessage.value,
                      focusNode: FocusNode(),
                      controller: controller.surnameController,
                      hintText: "lbl_surname".tr,
                      margin: getMargin(left: 24, top: 20, right: 24),
                      padding: TextFormFieldPadding.PaddingTB25,
                      fontStyle: TextFormFieldFontStyle.UrbanistSemiBold20,
                      alignment: Alignment.center,
                      prefix: Container(
                          margin: getMargin(
                              left: 21, top: 22, right: 13, bottom: 22),
                          child: CommonImageView(
                              svgPath: ImageConstant.imgCheckmark)),
                      prefixConstraints: BoxConstraints(
                          minWidth: getSize(15.00),
                          minHeight: getSize(15.00)))),
                  Obx(() => CustomTextFormField(
                      width: 380,
                      errMessage: controller.passwordErrorMessage.value,
                      focusNode: FocusNode(),
                      controller: controller.statusDefaultOneController,
                      hintText: "lbl_password".tr,
                      margin: getMargin(left: 24, top: 20, right: 24),
                      padding: TextFormFieldPadding.PaddingTB25,
                      fontStyle: TextFormFieldFontStyle.UrbanistSemiBold20,
                      textInputAction: TextInputAction.done,
                      alignment: Alignment.center,
                      prefix: Container(
                          margin: getMargin(
                              left: 22, top: 21, right: 14, bottom: 21),
                          child:
                              CommonImageView(svgPath: ImageConstant.imgLock)),
                      prefixConstraints: BoxConstraints(
                          minWidth: getSize(16.00), minHeight: getSize(16.00)),
                      suffix: InkWell(
                          onTap: () {
                            controller.isShowPassword.value =
                                !controller.isShowPassword.value;
                          },
                          child: Container(
                              margin: getMargin(
                                  left: 30, top: 22, right: 21, bottom: 22),
                              child: CommonImageView(
                                  svgPath: controller.isShowPassword.value
                                      ? ImageConstant.imgDashboard
                                      : ImageConstant.imgDashboard))),
                      suffixConstraints: BoxConstraints(
                          minWidth: getHorizontalSize(16.00),
                          minHeight: getVerticalSize(14.00)),
                      isObscureText: !controller.isShowPassword.value)),
                  Obx(() => CustomTextFormField(
                      width: 380,
                      errMessage: controller.confirmPasswordErrorMessage.value,
                      focusNode: FocusNode(),
                      controller: controller.confirmPasswordController,
                      hintText: "lbl_confirm_password".tr,
                      margin: getMargin(left: 24, top: 20, right: 24),
                      padding: TextFormFieldPadding.PaddingTB25,
                      fontStyle: TextFormFieldFontStyle.UrbanistSemiBold20,
                      textInputAction: TextInputAction.done,
                      alignment: Alignment.center,
                      prefix: Container(
                          margin: getMargin(
                              left: 22, top: 21, right: 14, bottom: 21),
                          child:
                              CommonImageView(svgPath: ImageConstant.imgLock)),
                      prefixConstraints: BoxConstraints(
                          minWidth: getSize(16.00), minHeight: getSize(16.00)),
                      suffix: InkWell(
                          onTap: () {
                            controller.isShowPassword.value =
                                !controller.isShowPassword.value;
                          },
                          child: Container(
                              margin: getMargin(
                                  left: 30, top: 22, right: 21, bottom: 22),
                              child: CommonImageView(
                                  svgPath: controller.isShowPassword.value
                                      ? ImageConstant.imgDashboard
                                      : ImageConstant.imgDashboard))),
                      suffixConstraints: BoxConstraints(
                          minWidth: getHorizontalSize(16.00),
                          minHeight: getVerticalSize(14.00)),
                      isObscureText: !controller.isShowPassword.value)),
                  Obx(() => !controller.isTeacher.value
                      ? CustomTextFormField(
                          width: 380,
                          errMessage: controller.lessonCodeErrorMessage.value,
                          focusNode: FocusNode(),
                          controller: controller.lessonCodeController,
                          hintText: "Invite Code",
                          margin: getMargin(left: 24, top: 20, right: 24),
                          padding: TextFormFieldPadding.PaddingTB25,
                          fontStyle: TextFormFieldFontStyle.UrbanistSemiBold20,
                          alignment: Alignment.center,
                          prefix: Container(
                              margin: getMargin(
                                  left: 21, top: 22, right: 13, bottom: 22),
                              child: CommonImageView(
                                  svgPath: ImageConstant.imgUser16X11)),
                          prefixConstraints: BoxConstraints(
                              minWidth: getSize(15.00),
                              minHeight: getSize(15.00)))
                      : Container()),
                ]))));
  }

  _validateValue() {
    String email = controller.statusDefaultController.text;
    String password = controller.statusDefaultOneController.text;
    String passwordConfirm = controller.confirmPasswordController.text;

    bool isEmail = GetUtils.isEmail(email);
    bool validPass = false;

    if (password.length < 6) {
      controller.passwordErrorMessage("err_msg_pass_too_short".tr);
      validPass = false;
    } else if (password != passwordConfirm) {
      controller.confirmPasswordErrorMessage("err_msg_pass_not_match".tr);
      validPass = false;
    } else {
      validPass = true;
      controller.passwordErrorMessage("");
      controller.confirmPasswordErrorMessage("");
    }

    if (!isEmail) {
      controller.emailErrorMessage("err_msg_invalid_email".tr);
    } else {
      controller.emailErrorMessage("");
    }
    if (controller.isTeacher.value) {
      controller.lessonCodeErrorMessage.value = "";
    } else {
      if (controller.lessonCodeController.text.toString() == "" ||
          controller.lessonCodeController.text.toString().length != 6) {
        controller.lessonCodeErrorMessage.value =
            "Please enter lesson code (6 character)";
        validPass = false;
      } else {
        controller.lessonCodeErrorMessage.value = "";
      }
    }
    return validPass && isEmail;
  }

  onTapImgArrowleft() {
    Get.back();
  }

  signUp() async {
    if (!await _network.isConnected()) {
      onErrorFirebaseSignUpResponse("msg_network_err".tr);
    }
    {
      if (_validateValue()) {
        ProgressDialogUtils.showProgressDialog();
        if (!controller.isTeacher.value) {
          var code = controller.lessonCodeController.text.toString();
          var courses = await FireStore().getCourseDataByInviteCode(code.toUpperCase());
          if (courses.isNotEmpty) {
            final FirebaseAuth auth = FirebaseAuth.instance;
            await auth
                .createUserWithEmailAndPassword(
              email: controller
                  .statusDefaultController.text, // Bind email Controller
              password: controller
                  .statusDefaultOneController.text, // Bind password Controller
            )
                .then((firebaseSignUpUser) {
              if (firebaseSignUpUser.user != null) {
                onSuccessFirebaseSignUpResponse(firebaseSignUpUser, courses[0]);
              } else {
                onErrorFirebaseSignUpResponse("");
                ProgressDialogUtils.hideProgressDialog();
              }
            }).catchError((onError) {
              onErrorFirebaseSignUpResponse(onError);
              ProgressDialogUtils.hideProgressDialog();
            });
          } else {
            onErrorFirebaseSignUpResponse(
                "Dont find any group with this invite code");
            ProgressDialogUtils.hideProgressDialog();
          }
        } else {
          final FirebaseAuth auth = FirebaseAuth.instance;
          await auth
              .createUserWithEmailAndPassword(
            email: controller
                .statusDefaultController.text, // Bind email Controller
            password: controller
                .statusDefaultOneController.text, // Bind password Controller
          )
              .then((firebaseSignUpUser) {
            if (firebaseSignUpUser.user != null) {
              onSuccessFirebaseSignUpResponse(
                  firebaseSignUpUser, initialCourseData);
            } else {
              onErrorFirebaseSignUpResponse("");
              ProgressDialogUtils.hideProgressDialog();
            }
          }).catchError((onError) {
            onErrorFirebaseSignUpResponse(onError);
            ProgressDialogUtils.hideProgressDialog();
          });
        }
      }
    }
  }

  onSuccessFirebaseSignUpResponse(
      UserCredential firebaseSignUpUser, CourseData courseData) async {
    final box = Hive.box(HiveKey.accountData);
    box.put(HiveKey.userID, firebaseSignUpUser.user!.uid.toString());
    box.put(
        HiveKey.userEmail, controller.statusDefaultController.text.toString());
    analytic.setUser(firebaseSignUpUser.user!.uid.toString());
    analytic.registerEvent("firebase-mail");
    final userData = UserData(
        firebaseSignUpUser.user!.uid.toString(),
        controller.statusDefaultController.text.toString(),
        controller.nameController.text.toString(),
        controller.surnameController.text.toString(),
        controller.isTeacher.value ? "" : courseData.id,
        false,
        controller.isTeacher.value,
        true,
        true);
    await FireStore().createUser(userData);
    HiveData().setUserAuthData(userData);
    if (!controller.isTeacher.value) {
      var tmp = courseData.students;
      var waitTmp = courseData.waitingStudents;

      tmp.add(firebaseSignUpUser.user!.uid.toString());
      waitTmp.add(firebaseSignUpUser.user!.uid.toString());

      courseData.students = tmp;
      courseData.waitingStudents = waitTmp;
      await FireStore().updateCourse(courseData.id, courseData);
    }
    Get.back();
    await FirebaseAnalytics.instance.logSignUp(signUpMethod: "firebase-email");
    ProgressDialogUtils.hideProgressDialog();
  }

  onErrorFirebaseSignUpResponse(error) {
    Fluttertoast.showToast(
      msg: error,
    );
  }

  onTapTxtSignin() {
    Get.back();
  }
}
