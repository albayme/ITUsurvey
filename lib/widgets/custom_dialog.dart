import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itu_geo/core/utils/color_constant.dart';
import 'package:itu_geo/core/utils/size_utils.dart';
import 'package:itu_geo/widgets/custom_button.dart';

class CustomDialog {
  CustomDialog(
      {this.fullScreen, this.content, this.alignment, this.showExitButton});

  Alignment? alignment;
  bool? showExitButton;
  bool? fullScreen;
  Widget? content;

  buildCustomDialog(BuildContext context) {
    return fullScreen == false
        ? showGeneralDialog(
            context: context,
            barrierDismissible: true,
            barrierLabel:
                MaterialLocalizations.of(context).modalBarrierDismissLabel,
            barrierColor: Colors.transparent,
            transitionDuration: const Duration(milliseconds: 200),
            pageBuilder: (BuildContext buildContext, Animation animation,
                Animation secondaryAnimation) {
              return Scaffold(
                body: content,
              );
            })
        : showGeneralDialog(
            context: context,
            barrierDismissible: true,
            barrierLabel:
                MaterialLocalizations.of(context).modalBarrierDismissLabel,
            barrierColor: Colors.transparent,
            transitionDuration: const Duration(milliseconds: 200),
            pageBuilder: (BuildContext buildContext, Animation animation,
                Animation secondaryAnimation) {
              return Scaffold(
                  body: Stack(
                children: [
                  content ?? Container(),
                  // Padding(
                  //   padding: const EdgeInsets.all(32.0),
                  //   child: Container(
                  //       height: MediaQuery.of(context).size.height,
                  //       padding: const EdgeInsets.all(10),
                  //       color: Colors.black.withOpacity(0.1),
                  //       width: double.infinity - 10,
                  //       child: content ?? Container()),
                  // ),
                  showExitButton == true
                      ? Padding(
                          padding: getPadding(top: 64, left: 18),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () => Get.back(),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.redAccent),
                                    child: Icon(
                                      Icons.close,
                                      size: 32,
                                      color: ColorConstant.whiteA700,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      : Container(),
                ],
              ));
            });
  }
}
