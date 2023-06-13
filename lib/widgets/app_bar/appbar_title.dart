import 'package:flutter/material.dart';
import 'package:itu_geo/core/utils/color_constant.dart';
import 'package:itu_geo/theme/app_style.dart';

// ignore: must_be_immutable
class AppbarTitle extends StatelessWidget {
  AppbarTitle({required this.text, this.margin, this.onTap});

  String text;

  EdgeInsetsGeometry? margin;

  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          onTap ?? {};
        },
        child: Padding(
          padding: margin ?? EdgeInsets.zero,
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: AppStyle.txtUrbanistRomanBold24.copyWith(
              color: ColorConstant.gray900,
            ),
          ),
        ),
      ),
    );
  }
}
