import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:itu_geo/core/constant/constants.dart';
import 'package:itu_geo/core/utils/color_constant.dart';
import 'package:itu_geo/core/utils/size_utils.dart';
import 'package:itu_geo/routes/app_routes.dart';
import 'package:itu_geo/theme/app_decoration.dart';
import 'package:itu_geo/theme/app_style.dart';
import 'package:itu_geo/widgets/common_image_view.dart';

import 'course_create_success_controller.dart';

class CourseCreateSuccessScreen
    extends GetWidget<CourseCreateSuccessController> {
  final box = Hive.box(HiveKey.accountData);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniCenterDocked,
            floatingActionButton: MediaQuery.of(context).viewInsets.bottom == 0
                ? GestureDetector(
                    onTap: () => {
                      Get.offNamedUntil(
                          AppRoutes.dashboardScreen, (route) => false)
                    },
                    child: Container(
                      width: double.infinity,
                      height: getVerticalSize(60),
                      decoration: AppDecoration.gradientGreenA400Green700,
                      child: Center(
                          child: Text(
                        "Finish".tr,
                        style: AppStyle.txtUrbanistRomanBold16RedA702.copyWith(
                            color: Colors.white,
                            letterSpacing: 0.10,
                            fontSize: 18),
                      )),
                    ),
                  )
                : Container(),
            backgroundColor: ColorConstant.whiteA700,
            body: Padding(
              padding: getPadding(top: 200),
              child: Container(
                child: Column(
                  children: [
                    Center(
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: CommonImageView(
                          svgPath: "assets/images/success.svg",
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              "Group Invite Code",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "urbanist",
                                  fontSize: 24,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Center(
                            child: Text(
                              box.get(HiveKey.createdCourseCode)?.toString() ??
                                  "1111111",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: "urbanist",
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )));
  }
}
