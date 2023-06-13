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
import 'package:itu_geo/routes/app_routes.dart';
import 'package:itu_geo/theme/app_style.dart';
import 'package:itu_geo/widgets/common_image_view.dart';
import 'package:itu_geo/widgets/custom_button.dart';
import 'package:itu_geo/widgets/custom_text_form_field.dart';

import 'controller/sign_in_controller.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignInScreen extends GetWidget<SignInController> {
  var analytic = FirebaseAnalytic();
  final _network = Get.find<NetworkInfo>();
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.whiteA700,
            body: SizedBox(
                width: size.width,
                child: SingleChildScrollView(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                      Align(
                          alignment: Alignment.center,
                          child: Padding(
                              padding: getPadding(left: 24, top: 72, right: 24),
                              child: Text("msg_login_to_your_a".tr,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtUrbanistRomanBold32))),
                      Obx(() => CustomTextFormField(
                          width: 380,
                          focusNode: FocusNode(),
                          errMessage: controller.emailErrorMessage.value,
                          controller: controller.statusDefaultController,
                          hintText: "lbl_email".tr,
                          margin: getMargin(left: 24, top: 31, right: 24),
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
                          margin: getMargin(left: 24, top: 24, right: 24),
                          padding: TextFormFieldPadding.PaddingTB25,
                          fontStyle: TextFormFieldFontStyle.UrbanistSemiBold20,
                          textInputAction: TextInputAction.done,
                          alignment: Alignment.center,
                          prefix: Container(
                              margin: getMargin(
                                  left: 22, top: 21, right: 14, bottom: 21),
                              child: CommonImageView(
                                  svgPath: ImageConstant.imgLock)),
                          prefixConstraints: BoxConstraints(
                              minWidth: getSize(16.00),
                              minHeight: getSize(16.00)),
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
                      CustomButton(
                          width: 380,
                          text: "lbl_sign_in".tr,
                          variant: ButtonVariant.GradientGray,
                          margin: getMargin(left: 24, top: 24, right: 24),
                          shape: ButtonShape.CircleBorder29,
                          padding: ButtonPadding.PaddingAll18,
                          fontStyle: ButtonFontStyle.UrbanistRomanBold24,
                          onTap: loginWithFirebase,
                          alignment: Alignment.center),
                      Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                              onTap: () {
                                onTapTxtSignup();
                              },
                              child: Padding(
                                  padding:
                                      getPadding(left: 24, top: 29, right: 24),
                                  child: Text("msg_create_new_account".tr,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtUrbanistSemiBold24
                                          .copyWith(letterSpacing: 0.20))))),
                    ])))));
  }

  onTapImgArrowleft() {
    Get.back();
  }

  _validateValue() {
    String email = controller.statusDefaultController.text;
    String password = controller.statusDefaultOneController.text;
    bool isEmail = GetUtils.isEmail(email);
    bool validPass = false;

    if (password.length < 6) {
      controller.passwordErrorMessage("err_msg_pass_too_short".tr);
      validPass = false;
    } else {
      validPass = true;
      controller.passwordErrorMessage("");
    }

    if (!isEmail) {
      controller.emailErrorMessage("err_msg_invalid_email".tr);
    } else {
      controller.emailErrorMessage("");
    }
    return validPass && isEmail;
  }

  loginWithFirebase() async {
    if (!await _network.isConnected()) {
      onErrorFirebaseSignInResponse("msg_network_err".tr);
    } else {
      if (_validateValue()) {
        ProgressDialogUtils.showProgressDialog();

        final FirebaseAuth auth = FirebaseAuth.instance;

        await auth
            .signInWithEmailAndPassword(
          email:
              controller.statusDefaultController.text, // Bind email Controller
          password: controller
              .statusDefaultOneController.text, // Bind password Controller
        )
            .then((firebaseSignInUser) {
          if (firebaseSignInUser.user != null) {
            onSuccessFirebaseSignInResponse(firebaseSignInUser);
          } else {
            onErrorFirebaseSignInResponse("msg_invalid_pass_or_email".tr);
            ProgressDialogUtils.hideProgressDialog();
          }
        }).catchError((onError) {
          onErrorFirebaseSignInResponse("msg_invalid_pass_or_email".tr);
          ProgressDialogUtils.hideProgressDialog();
        });
      }
    }
  }

  onSuccessFirebaseSignInResponse(UserCredential firebaseSignInUser) async {
    var userData =
        await FireStore().getUserById(firebaseSignInUser.user!.uid.toString());
    if (userData.isPending) {
      if (userData.isTeacher) {
        onErrorFirebaseSignInResponse(
            "Your account is still under review process!! Our admin will approve it as soon as possible.");
      } else {
        onErrorFirebaseSignInResponse(
            "Your account is still under review process!! Touch your teacher to approve it");
      }
      ProgressDialogUtils.hideProgressDialog();
      return;
    }
    HiveData().setUserAuthData(userData);
    final box = Hive.box(HiveKey.accountData);
    box.put(HiveKey.userID, firebaseSignInUser.user!.uid.toString());
    box.put(
        HiveKey.userEmail, controller.statusDefaultController.text.toString());
    Get.offAllNamed(AppRoutes.dashboardScreen);
    controller.setUser(controller.statusDefaultController.text.toString());
    analytic.setUser(firebaseSignInUser.user!.uid.toString());
    analytic.loginEvent("firebase-email");
    ProgressDialogUtils.hideProgressDialog();
  }

  onErrorFirebaseSignInResponse(String message) {
    Fluttertoast.showToast(msg: message);
  }

  onTapTxtSignup() {
    Get.toNamed(AppRoutes.signUpScreen);
  }
}
