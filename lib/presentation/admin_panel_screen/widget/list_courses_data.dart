import 'package:flutter/material.dart';
import 'package:itu_geo/core/utils/color_constant.dart';
import 'package:itu_geo/core/utils/size_utils.dart';
import 'package:itu_geo/models/course_model.dart';
import 'package:itu_geo/theme/app_style.dart';
import 'package:itu_geo/widgets/custom_dialog.dart';

// ignore: must_be_immutable
class ListCourseDataWidget extends StatelessWidget {
  ListCourseDataWidget(this.data);

  CourseData data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: getPadding(bottom: 10),
      child: GestureDetector(
        onTap: () => {
          CustomDialog(
                  content: Center(
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height,
                      padding: const EdgeInsets.all(10),
                      color: Colors.black.withOpacity(0.8),
                      child: Padding(
                        padding: getPadding(top: 64),
                        child: Padding(
                            padding: getPadding(
                                bottom: isDeviceTablet()
                                    ? getVerticalSize(48)
                                    : getVerticalSize(72)),
                            child: _buildDialogBody()),
                      ),
                    ),
                  ),
                  showExitButton: true)
              .buildCustomDialog(context)
        },
        child: Container(
          decoration: _buildDecoration(),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 4,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: getPadding(
                        left: 16,
                        top: 20,
                        bottom: 17,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: getPadding(
                              right: 10,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "${data.name}  ${data.lessonCode}",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtUrbanistRomanBold18,
                                ),
                                Text(
                                  data.code,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtUrbanistSemiBold14Gray700,
                                ),
                                Text(
                                  "email: ${data.code}",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtUrbanistSemiBold14Gray700,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildDecoration() {
    return BoxDecoration(
        color: ColorConstant.gray100,
        border: Border.all(
          color: ColorConstant.red50,
          width: getHorizontalSize(
            1.00,
          ),
        ),
        borderRadius: BorderRadius.circular(
          getHorizontalSize(
            10.00,
          ),
        ));
  }

  _buildDialogBody() {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Padding(
        padding: getPadding(top: 36, left: 12),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Name : ${data.name} ${data.name}",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: AppStyle.txtUrbanistRomanBold18,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Lesson Code : ${data.lessonCode}",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: AppStyle.txtUrbanistRomanBold18,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Tutor Id : ${data.teacherId}",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: AppStyle.txtUrbanistRomanBold18,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Is Active ? : ${data.isActive ? "yes" : "no"}",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: AppStyle.txtUrbanistRomanBold18,
                ),
              ),

              // Padding(
              //   padding: const EdgeInsets.all(12.0),
              //   child: Row(
              //     children: [
              //       data.isPending
              //           ? CustomButton(
              //               onTap: () => _approve(),
              //               width: 100,
              //               text: "Approve It",
              //             )
              //           : Container(),
              //     ],
              //   ),
              // )
            ]),
      ),
    );
  }
}
