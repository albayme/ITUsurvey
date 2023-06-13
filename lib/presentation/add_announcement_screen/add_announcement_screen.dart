import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itu_geo/core/utils/color_constant.dart';
import 'package:itu_geo/core/utils/file_upload_helper.dart';
import 'package:itu_geo/core/utils/size_utils.dart';
import 'package:itu_geo/presentation/add_announcement_screen/add_announcement_controller.dart';
import 'package:itu_geo/theme/app_decoration.dart';
import 'package:itu_geo/widgets/custom_button.dart';
import 'package:itu_geo/widgets/custom_text_form_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class AddAnnouncementScreen extends GetWidget<AddAnnouncementController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            bottomNavigationBar: CustomButton(
                variant: ButtonVariant.FillGreen700,
                width: double.maxFinite,
                text: "lbl_save".tr,
                shape: ButtonShape.RoundedBorder10,
                padding: ButtonPadding.PaddingAll16,
                fontStyle: ButtonFontStyle.ManropeBold16WhiteA700_1,
                onTap: () async => {await controller.createAnn()}),
            appBar: AppBar(
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
              title: const Center(
                  child: Text(
                "Add Announcement",
                style: TextStyle(color: Colors.black),
              )),
              backgroundColor: Colors.white,
            ),
            backgroundColor: ColorConstant.whiteA700,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: MultiSelectDialogField(
                      searchable: true,
                      title: const Text(""),
                      buttonText: const Text("Select course group"),
                      items: controller.teacherController.coursesData.value
                          .map((e) => MultiSelectItem(e.id, e.name))
                          .toList(),
                      listType: MultiSelectListType.LIST,
                      onConfirm: (values) {
                        controller.selectedCourse.value = values;
                      },
                    ),
                  ),
                  Obx(() => CustomTextFormField(
                      width: 380,
                      maxLines: 12,
                      focusNode: FocusNode(),
                      errMessage: controller.announcementErrorMessage.value,
                      controller: controller.announcementController,
                      label: "Announcument".tr,
                      hintText: "",
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
                          minWidth: getSize(10.00),
                          minHeight: getSize(10.00)))),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _buildAddAttachementWidget(),
                  )
                ],
              ),
            )));
  }

  Widget _buildAddAttachementWidget() {
    FileManager manager = FileManager();

    return SizedBox(
      height: 300,
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
}
