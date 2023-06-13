import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itu_geo/core/utils/color_constant.dart';
import 'package:itu_geo/core/utils/size_utils.dart';
import 'package:itu_geo/presentation/announcement_list_screen/announcement_list_controller.dart';
import 'package:itu_geo/routes/app_routes.dart';
import 'package:itu_geo/theme/app_decoration.dart';
import 'package:itu_geo/widgets/app_bar/appbar_title.dart';
import 'package:itu_geo/widgets/app_bar/custom_app_bar.dart';

class AnnouncementListScreen extends GetWidget<AnnouncementListController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
              height: getVerticalSize(
                56.00,
              ),
              title: AppbarTitle(
                text: "Announcement List".tr,
                margin: getMargin(
                    // left: 16,
                    ),
              ),
            ),
            backgroundColor: ColorConstant.whiteA700,
            body: SingleChildScrollView(
                child: Obx(
              () => Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 400,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.isTeacher.value
                            ? controller
                                .teacherPanelController.announcementData.length
                            : controller
                                .studentPanelController.announcementData.length,
                        itemBuilder: (context, index) {
                          // ignore: avoid_print
                          var model = controller.isTeacher.value
                              ? controller.teacherPanelController
                                  .announcementData[index]
                              : controller.studentPanelController
                                  .announcementData[index];
                          return model.isActive == true
                              ? Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: GestureDetector(
                                    onTap: () => Get.toNamed(
                                        AppRoutes.detailAnnouncementScreen,
                                        arguments: model),
                                    child: Container(
                                      decoration: AppDecoration.fillGray50,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Text(
                                              "${index + 1}. ${model.description}",
                                              overflow: TextOverflow.ellipsis,
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
                                )
                              : Container();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ))));
  }
}
