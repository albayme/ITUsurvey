// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:itu_geo/core/utils/color_constant.dart';
import 'package:itu_geo/core/utils/size_utils.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {this.shape,
      this.padding,
      this.variant,
      this.fontStyle,
      this.alignment,
      this.onTap,
      this.width,
      this.margin,
      this.prefixWidget,
      this.suffixWidget,
      this.text});

  ButtonShape? shape;

  ButtonPadding? padding;

  ButtonVariant? variant;

  ButtonFontStyle? fontStyle;

  Alignment? alignment;

  VoidCallback? onTap;

  double? width;

  EdgeInsetsGeometry? margin;

  Widget? prefixWidget;

  Widget? suffixWidget;

  String? text;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: _buildButtonWidget(),
          )
        : _buildButtonWidget();
  }

  _buildButtonWidget() {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: getHorizontalSize(width ?? 0),
        margin: margin,
        padding: _setPadding(),
        decoration: _buildDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            prefixWidget ?? const SizedBox(),
            Flexible(
              child: Text(
                // overflow: TextOverflow.fade,
                text ?? "",
                textAlign: TextAlign.center,
                style: _setFontStyle(),
              ),
            ),
            suffixWidget ?? const SizedBox(),
          ],
        ),
      ),
    );
  }

  _buildDecoration() {
    switch (variant) {
      case ButtonVariant.OutlineGreen800:
        return BoxDecoration(
            gradient: LinearGradient(
              // ignore: prefer_const_constructors
              begin: Alignment(
                1.0000000298023233,
                1.0000000298023233,
              ),
              end: const Alignment(
                1.1102230246251565e-16,
                0,
              ),
              colors: [
                ColorConstant.green300,
                ColorConstant.greenA400,
              ],
            ),
            borderRadius: _setBorderRadius());
      case ButtonVariant.GradientGreeen:
        return BoxDecoration(
            gradient: LinearGradient(
              // ignore: prefer_const_constructors
              begin: Alignment(
                1.0000000298023233,
                1.0000000298023233,
              ),
              end: const Alignment(
                1.1102230246251565e-16,
                0,
              ),
              colors: [
                ColorConstant.green300,
                ColorConstant.greenA400,
              ],
            ),
            borderRadius: _setBorderRadius());

      case ButtonVariant.GradientYellow:
        return BoxDecoration(
            gradient: LinearGradient(
              // ignore: prefer_const_constructors
              begin: Alignment(
                1.0000000298023233,
                1.0000000298023233,
              ),
              end: const Alignment(
                1.1102230246251565e-16,
                0,
              ),
              colors: [
                ColorConstant.yellowLikeBlack,
                ColorConstant.yellowLikeBlack,
              ],
            ),
            borderRadius: _setBorderRadius());
                  case ButtonVariant.GradientRed:
        return BoxDecoration(
            gradient: LinearGradient(
              // ignore: prefer_const_constructors
              begin: Alignment(
                1.0000000298023233,
                1.0000000298023233,
              ),
              end: const Alignment(
                1.1102230246251565e-16,
                0,
              ),
              colors: [
                ColorConstant.redA702,
                ColorConstant.red700,
              ],
            ),
            borderRadius: _setBorderRadius());
            case ButtonVariant.GradientBuyButton:
        return BoxDecoration(
            gradient: LinearGradient(
              // ignore: prefer_const_constructors
              begin: Alignment(
                1.0000000298023233,
                1.0000000298023233,
              ),
              end: const Alignment(
                1.1102230246251565e-16,
                0,
              ),
              colors: [
                ColorConstant.redA702,
                ColorConstant.red700,
              ],
            ),
            borderRadius: _setBorderRadius());
      case ButtonVariant.GradientGray:
        return BoxDecoration(
            gradient: LinearGradient(
              begin: const Alignment(
                1.0000000298023233,
                1.0000000298023233,
              ),
              end: const Alignment(
                1.1102230246251565e-16,
                0,
              ),
              colors: [
                ColorConstant.gray800,
                ColorConstant.gray802,
              ],
            ),
            borderRadius: _setBorderRadius());
      default:
        return BoxDecoration(
          color: _setColor(),
          border: _setBorder(),
          borderRadius: _setBorderRadius(),
        );
    }
  }

  _setPadding() {
    switch (padding) {
      case ButtonPadding.PaddingAll16:
        return getPadding(
          all: 17,
        );
      case ButtonPadding.PaddingAll18:
        return getPadding(
          all: 18,
        );
      case ButtonPadding.PaddingAll13:
        return getPadding(
          all: 13,
        );
      case ButtonPadding.PaddingAll21:
        return getPadding(
          all: 21,
        );
      default:
        return getPadding(
          all: 9,
        );
    }
  }

  _setColor() {
    switch (variant) {
      case ButtonVariant.FillGray600:
        return ColorConstant.gray600;

      case ButtonVariant.FillWhiteA700:
        return ColorConstant.whiteA700;
      case ButtonVariant.FillGray802:
        return ColorConstant.gray802;
      case ButtonVariant.FillGreen700:
        return ColorConstant.greenA701;
      case ButtonVariant.OutlineGray800:
      case ButtonVariant.OutlineGreen800:

      case ButtonVariant.OutlineGray802:
        return null;
      default:
        return ColorConstant.gray800;
    }
  }

  _setBorder() {
    switch (variant) {
      case ButtonVariant.OutlineGray800:
        return Border.all(
          color: ColorConstant.gray800,
          width: getHorizontalSize(
            2.00,
          ),
        );

      case ButtonVariant.OutlineGreen800:
        return Border.all(
          color: ColorConstant.greenA700,
          width: getHorizontalSize(
            2.00,
          ),
        );
      case ButtonVariant.OutlineGray802:
        return Border.all(
          color: ColorConstant.gray802,
          width: getHorizontalSize(
            2.00,
          ),
        );
      case ButtonVariant.FillGray800:
      case ButtonVariant.FillWhiteA700:
      case ButtonVariant.FillGray802:
        return null;
      case ButtonVariant.FillGreen700:
        return null;
      default:
        return null;
    }
  }

  _setBorderRadius() {
    switch (shape) {
      case ButtonShape.RoundedBorder10:
        return BorderRadius.circular(
          getHorizontalSize(
            10.00,
          ),
        );
      case ButtonShape.CircleBorder29:
        return BorderRadius.circular(
          getHorizontalSize(
            29.00,
          ),
        );
      case ButtonShape.RoundedBorder22:
        return BorderRadius.circular(
          getHorizontalSize(
            22.50,
          ),
        );
      case ButtonShape.Square:
        return BorderRadius.circular(0);
      case ButtonShape.BuyButtonCircle:
        return BorderRadius.circular(
          getHorizontalSize(
            12,
          ),
        );
      default:
        return BorderRadius.circular(
          getHorizontalSize(
            16.00,
          ),
        );
    }
  }

  _setFontStyle() {
    switch (fontStyle) {
      case ButtonFontStyle.ManropeBold16WhiteA700_1:
        return TextStyle(
          color: ColorConstant.whiteA700,
          fontSize: getFontSize(
            16,
          ),
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w700,
          height: getVerticalSize(
            1.38,
          ),
        );
      case ButtonFontStyle.BuyButtonFont:
        return TextStyle(
          color: ColorConstant.whiteA700,
          fontSize: getFontSize(
            24,
          ),
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w700,
        );

      case ButtonFontStyle.UrbanistRomanBold16Purple:
        return TextStyle(
          color: ColorConstant.purpleA700,
          fontSize: getFontSize(
            16,
          ),
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w700,
        );
      case ButtonFontStyle.UrbanistRomanBold16Green:
        return TextStyle(
          color: ColorConstant.greenA700,
          fontSize: getFontSize(
            16,
          ),
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w700,
        );
      case ButtonFontStyle.UrbanistRomanBold16:
        return TextStyle(
          color: ColorConstant.whiteA700,
          fontSize: getFontSize(
            16,
          ),
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w700,
        );
      case ButtonFontStyle.UrbanistRomanBold24:
        return TextStyle(
          color: ColorConstant.whiteA700,
          fontSize: getFontSize(
            24,
          ),
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w700,
        );
      case ButtonFontStyle.UrbanistRomanBold16Gray800:
        return TextStyle(
          color: ColorConstant.gray800,
          fontSize: getFontSize(
            16,
          ),
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w700,
        );
      case ButtonFontStyle.UrbanistSemiBold14Gray800:
        return TextStyle(
          color: ColorConstant.gray800,
          fontSize: getFontSize(
            14,
          ),
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w600,
        );
      case ButtonFontStyle.UrbanistRomanBold18:
        return TextStyle(
          color: ColorConstant.whiteA700,
          fontSize: getFontSize(
            18,
          ),
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w700,
        );
      case ButtonFontStyle.UrbanistSemiBold14RedA702:
        return TextStyle(
          color: ColorConstant.redA702,
          fontSize: getFontSize(
            14,
          ),
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w600,
        );
      case ButtonFontStyle.UrbanistRomanBold16Gray802:
        return TextStyle(
          color: ColorConstant.gray802,
          fontSize: getFontSize(
            16,
          ),
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w700,
        );
      case ButtonFontStyle.UrbanistRomanBold18Gray802:
        return TextStyle(
          color: ColorConstant.gray802,
          fontSize: getFontSize(
            18,
          ),
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w700,
        );
      default:
        return TextStyle(
          color: ColorConstant.whiteA700,
          fontSize: getFontSize(
            14,
          ),
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w600,
        );
    }
  }
}

enum ButtonShape {
  RoundedBorder10,
  Square,
  CircleBorder16,
  CircleBorder29,
  RoundedBorder22,
  BuyButtonCircle,
}

enum ButtonPadding {
  PaddingAll16,
  PaddingAll9,
  PaddingAll18,
  PaddingAll13,
  PaddingAll21,
}

enum ButtonVariant {
  FillGray800,
  OutlineGreen800,
  OutlineGray800,
  FillWhiteA700,
  OutlineGray802,
  FillGray802,
  FillGreen700,
  GradientGreeen,
  GradientGray,
  FillGray600,
  GradientBuyButton,
  GradientRed,
  GradientYellow,


}

enum ButtonFontStyle {
  UrbanistSemiBold14,
  UrbanistRomanBold16,
  UrbanistRomanBold16Purple,
  UrbanistRomanBold16Green,
  UrbanistRomanBold16Gray800,
  UrbanistSemiBold14Gray800,
  UrbanistRomanBold18,
  UrbanistSemiBold14RedA702,
  UrbanistRomanBold16Gray802,
  UrbanistRomanBold18Gray802,
  UrbanistRomanBold24,
  BuyButtonFont,
  ManropeBold16WhiteA700_1,
}
