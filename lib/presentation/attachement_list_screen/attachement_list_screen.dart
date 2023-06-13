import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itu_geo/core/utils/color_constant.dart';
import 'package:itu_geo/core/utils/size_utils.dart';
import 'package:itu_geo/presentation/attachement_list_screen/attachement_list_controller.dart';
import 'package:itu_geo/theme/app_decoration.dart';
import 'package:itu_geo/widgets/app_bar/appbar_title.dart';
import 'package:itu_geo/widgets/app_bar/custom_app_bar.dart';

class AttachementListScreen extends GetWidget<AttachementListController> {
  final storageRef = FirebaseStorage.instance.ref();

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
                text: "Attachment List".tr,
                margin: getMargin(
                    // left: 16,
                    ),
              ),
            ),
            backgroundColor: ColorConstant.whiteA700,
            body: SingleChildScrollView(
                child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 400,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.isTeacher.value
                          ? controller.teacherPanelController.selectedCourseData
                              .value.documentRef.length
                          : controller.studentPanelController.courseData.value
                              .documentRef.length,
                      itemBuilder: (context, index) {
                        // ignore: avoid_print
                        var model = controller.isTeacher.value
                            ? controller.teacherPanelController
                                .selectedCourseData.value.documentRef[index]
                            : controller.studentPanelController.courseData.value
                                .documentRef[index];
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: GestureDetector(
                            onTap: () async {
                              var islandRef = storageRef.child(model);
                              var url = await islandRef
                                  .getDownloadURL()
                                  .then((value) => {print(value)});
                            },
                            child: Container(
                              decoration: AppDecoration.fillGray50,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                  ),
                ],
              ),
            ))));
  }
}
