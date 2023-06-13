import 'package:get/get.dart';
import 'package:itu_geo/core/utils/color_constant.dart';
import 'package:itu_geo/core/utils/image_constant.dart';
import 'package:itu_geo/core/utils/size_utils.dart';
import 'package:itu_geo/theme/app_style.dart';
import 'package:itu_geo/widgets/common_image_view.dart';

import 'controller/splash_controller.dart';
import 'package:flutter/material.dart';

class SplashScreen extends GetWidget<SplashController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.whiteA700,
            body: Container(
                width: size.width,
                child: SingleChildScrollView(
                    child: Stack(
                  children: [
                    Container(
                        // decoration: AppDecoration.gradientPurpleA700DeeppurpleA200,
                        // width: double.infinity,height: 800,
                        // child: ClipRRect(
                        //     child: CommonImageView(
                        //         imagePath: ImageConstant.imageSplashBackground,
                        //         // height: d,
                        //         // width: getHorizontalSize(100.00),
                        //         fit: BoxFit.fill)),
                        ),
                    Center(
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                                padding:
                                    getPadding(left: 116, top: 270, right: 116),
                                child: ClipRRect(
                                    child: CommonImageView(
                                        imagePath: ImageConstant.imageLogo,
                                        height: getSize(100.00),
                                        width: getSize(100.00),
                                        fit: BoxFit.fill))),
                            Padding(
                                padding: getPadding(
                                    left: 50, top: 45, right: 50, bottom: 20),
                                child: Text("lbl_tunecast".tr,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle.txtUrbanistRomanBold48
                                        .copyWith(
                                            color: ColorConstant.black900))),
                          ]),
                    ),
                  ],
                )))));
  }
}
