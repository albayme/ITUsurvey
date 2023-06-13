import 'package:flutter/material.dart';
import 'package:itu_geo/core/utils/color_constant.dart';
import 'package:itu_geo/widgets/common_image_view.dart';

// ignore: must_be_immutable
class AppbarImage extends StatelessWidget {
  AppbarImage(
      {required this.height,
      required this.width,
      this.color,
      this.imagePath,
      this.svgPath,
      this.margin,
      this.onTap});

  double height;

  double width;

  String? imagePath;

  String? svgPath;

  Color? color;

  EdgeInsetsGeometry? margin;

  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap!();
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: CommonImageView(
          svgPath: svgPath,
          imagePath: imagePath,
          color: color ?? ColorConstant.gray700,
          height: height,
          width: width,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
