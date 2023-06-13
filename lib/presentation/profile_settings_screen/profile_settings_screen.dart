import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:itu_geo/core/firebase/firestore.dart';
import 'package:itu_geo/core/hive/hive_data.dart';
import 'package:itu_geo/core/utils/color_constant.dart';
import 'package:itu_geo/core/utils/image_constant.dart';
import 'package:itu_geo/core/utils/size_utils.dart';
import 'package:itu_geo/routes/app_routes.dart';
import 'package:itu_geo/theme/app_decoration.dart';
import 'package:itu_geo/theme/app_style.dart';
import 'package:itu_geo/widgets/app_bar/appbar_title.dart';
import 'package:itu_geo/widgets/app_bar/custom_app_bar.dart';
import 'package:itu_geo/widgets/common_image_view.dart';
import 'package:itu_geo/widgets/custom_button.dart';

import 'controller/profile_settings_controller.dart';
import 'package:flutter/material.dart';

class ProfileSettingsScreen extends GetWidget<ProfileSettingsController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.whiteA700,
        appBar: CustomAppBar(
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
          height: getSize(
            56.00,
          ),
          title: AppbarTitle(
            text: "lbl_profile".tr,
            margin: getMargin(
              left: 16,
            ),
          ),
        ),
        body: Obx(
          () => controller.loading.value
              ? Center(
                  child: CircularProgressIndicator(
                    color: ColorConstant.red700,
                  ),
                )
              : SizedBox(
                  width: size.width,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: getPadding(
                        left: 24,
                        right: 24,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: getPadding(
                              left: 2,
                              top: 29,
                              right: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: getPadding(
                                    bottom: 1,
                                  ),
                                  child: CommonImageView(
                                    svgPath: ImageConstant.imgClock21X22,
                                    height: getSize(
                                      22.00,
                                    ),
                                    width: getSize(
                                      22.00,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => _logout(),
                                  child: Padding(
                                    padding: getPadding(
                                      left: 22,
                                      top: 4,
                                    ),
                                    child: Text(
                                      "lbl_logout".tr,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle
                                          .txtUrbanistSemiBold18RedA202
                                          .copyWith(
                                        // fontSize:  16,
                                        letterSpacing: 0.20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          _buildDeleteAccount(),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildDeleteAccount() {
    return Padding(
      padding: getPadding(
        left: 2,
        top: 29,
        right: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: getPadding(
              bottom: 1,
            ),
            child: SizedBox(
              height: getSize(
                22.00,
              ),
              width: getSize(
                22.00,
              ),
              child: const Icon(
                Icons.delete_forever,
                color: Colors.redAccent,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => _deleteAccount(),
            child: Padding(
              padding: getPadding(
                left: 22,
                top: 4,
              ),
              child: Text(
                "lbl_delete_account".tr,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: AppStyle.txtUrbanistSemiBold18RedA202.copyWith(
                  letterSpacing: 0.20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _deleteAccount() {
    Get.defaultDialog(
        actions: [
          GestureDetector(
            onTap: () async => {
              await FireStore().removeAccount(),
              // TODO Add storage remove
              Get.offAllNamed(AppRoutes.signInScreen)
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                fontStyle: ButtonFontStyle.UrbanistRomanBold16,
                text: "lbl_yes".tr,
                width: getSize(75),
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
                width: getSize(75),
              ),
            ),
          ),
        ],
        title: "",
        middleText: "msg_delete_account".tr,
        backgroundColor: ColorConstant.whiteA700,
        titleStyle: TextStyle(color: ColorConstant.black900),
        middleTextStyle: TextStyle(color: ColorConstant.black900),
        radius: 30);
  }

  _logout() {
    Get.defaultDialog(
        actions: [
          GestureDetector(
            onTap: () => {
              Get.offAllNamed(AppRoutes.signInScreen),
              HiveData().removeUserAuthData()
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                fontStyle: ButtonFontStyle.UrbanistRomanBold16,
                text: "lbl_yes".tr,
                width: getSize(75),
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
                width: getSize(75),
              ),
            ),
          ),
        ],
        title: "",
        middleText: "msg_logout".tr,
        backgroundColor: ColorConstant.whiteA700,
        titleStyle: TextStyle(color: ColorConstant.black900),
        middleTextStyle: TextStyle(color: ColorConstant.black900),
        radius: 30);
  }
}
