import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itu_geo/core/utils/color_constant.dart';
import 'package:itu_geo/core/utils/size_utils.dart';
import 'package:itu_geo/models/announcement_model.dart';
import 'package:itu_geo/presentation/announcement_detail_screen/announcement_detail_controller.dart';
import 'package:itu_geo/theme/app_decoration.dart';
import 'package:itu_geo/widgets/app_bar/appbar_title.dart';
import 'package:itu_geo/widgets/app_bar/custom_app_bar.dart';
import 'package:itu_geo/widgets/custom_button.dart';
import 'package:itu_geo/widgets/custom_text_form_field.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AnnouncementDetailScreen extends GetWidget<AnnouncementDetailController> {
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
                text: "Announcement List".tr,
                margin: getMargin(
                    // left: 16,
                    ),
              ),
            ),
            backgroundColor: ColorConstant.whiteA700,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.maxFinite,
                      decoration: AppDecoration.fillGray100,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(controller.data.description),
                      ),
                    ),
                  ),
                  const Divider(),
                  const Text("Attachements"),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: false,
                      itemCount: controller.data.documentRef.length,
                      itemBuilder: (context, index) {
                        String? fullPath = controller.data.documentRef[index];
                        int start = fullPath!.lastIndexOf("/");
                        String name = fullPath.substring(start + 1);

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onDoubleTap: () async => await _launchURL(fullPath),
                            child: Container(
                              width: 100,
                              decoration: AppDecoration.fillGray52,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      name,
                                      style: const TextStyle(fontSize: 12),
                                      textAlign: TextAlign.center,
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
                  const Divider(),
                  Obx(() => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: AppDecoration.fillGray50,
                          child: Column(children: [
                            SizedBox(
                              height: 299,
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: controller.comments.value.length,
                                itemBuilder: (context, index) {
                                  AnnouncementComment model =
                                      controller.comments.value[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Container(
                                      decoration: AppDecoration
                                          .gradientOrangeA400OrangeA200
                                          .copyWith(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(4))),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  "sender : ",
                                                  style: TextStyle(
                                                      fontFamily: 'urbanist'),
                                                ),
                                              ),
                                              Text(
                                                "  ${model.senderName}",
                                                style: const TextStyle(
                                                    fontFamily: 'urbanist'),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                DateFormat('dd/MM/yyyy, HH:mm')
                                                    .format(
                                                        model.created.toDate()),
                                                style: const TextStyle(
                                                    color: Colors.grey),
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              model.comment,
                                              textAlign: TextAlign.left,
                                            ),
                                          )
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
                  Padding(
                    padding: getPadding(bottom: 25),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Obx(() => CustomTextFormField(
                              variant: TextFormFieldVariant.FillGray50,
                              width: double.maxFinite,
                              maxLines: 4,
                              label: "Comment".tr,
                              hintText: "Type your comment",
                              focusNode: FocusNode(),
                              errMessage: controller.commentErrorMessage.value,
                              controller: controller.commentController,
                              margin: getMargin(top: 2),
                              padding: TextFormFieldPadding.PaddingTB25,
                              fontStyle:
                                  TextFormFieldFontStyle.UrbanistSemiBold16,
                              alignment: Alignment.center,
                              // prefix: Container(
                              //     margin: getMargin(
                              //         left: 21, top: 22, right: 13, bottom: 22),
                              //     child: CommonImageView(
                              //         svgPath: ImageConstant.imgCheckmark)),
                              prefixConstraints: BoxConstraints(
                                  minWidth: getSize(10.00),
                                  minHeight: getSize(10.00)))),
                        ),
                        Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomButton(
                                  variant: ButtonVariant.FillGreen700,
                                  width: double.maxFinite,
                                  text: "Add".tr,
                                  shape: ButtonShape.RoundedBorder10,
                                  padding: ButtonPadding.PaddingAll16,
                                  fontStyle:
                                      ButtonFontStyle.ManropeBold16WhiteA700_1,
                                  onTap: () async =>
                                      {await controller.addComment()}),
                            ))
                      ],
                    ),
                  )
                ],
              ),
            )));
  }

  _launchURL(fullpath) async {
    final url = await storageRef.child(fullpath).getDownloadURL();
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _saveToLocal(String name, fullpath) async {
    final islandRef = storageRef.child(fullpath);

    try {
      const oneMegabyte = 1024 * 1024;
      final Uint8List? data = await islandRef.getData(oneMegabyte);
      if (data != null) {
        Uint8List imageInUnit8List = data; // store unit8List image here ;
        final tempDir = await getTemporaryDirectory();
        File file = await File('${tempDir.path}/aa.pdf').create();
        file.writeAsBytesSync(imageInUnit8List);
      }
      // Data for "images/island.jpg" is returned, use this as needed.
    } on FirebaseException catch (e) {
      // Handle any errors.
    }
  }
}
