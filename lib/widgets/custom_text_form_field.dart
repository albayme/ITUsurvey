// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:itu_geo/core/utils/color_constant.dart';
import 'package:itu_geo/core/utils/size_utils.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {this.shape,
      this.padding,
      this.variant,
      this.fontStyle,
      this.alignment,
      this.width,
      this.label,
      this.labelStyle,
      this.margin,
      this.controller,
      this.focusNode,
      this.isObscureText = false,
      this.textInputAction = TextInputAction.next,
      this.maxLines,
      this.hintText,
      this.keyboardType,
      this.autovalidateMode,
      this.prefix,
      this.prefixConstraints,
      this.suffix,
      this.errMessage,
      this.suffixConstraints,
      this.validator});

  TextFormFieldShape? shape;

  TextFormFieldPadding? padding;

  TextFormFieldVariant? variant;

  TextInputType? keyboardType;

  TextFormFieldFontStyle? fontStyle;

  Alignment? alignment;

  double? width;

  EdgeInsetsGeometry? margin;

  TextEditingController? controller;

  FocusNode? focusNode;

  bool? isObscureText;

  TextInputAction? textInputAction;

  AutovalidateMode? autovalidateMode;

  int? maxLines;

  String? hintText;

  String? errMessage;

  String? label;
  TextStyle? labelStyle;

  Widget? prefix;

  BoxConstraints? prefixConstraints;

  Widget? suffix;

  BoxConstraints? suffixConstraints;

  FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: _buildTextFormFieldWidget(),
          )
        : _buildTextFormFieldWidget();
  }

  _buildTextFormFieldWidget() {
    return Container(
      width: getHorizontalSize(width ?? 0),
      margin: margin,
      child: TextFormField(
        keyboardType: keyboardType,
        autovalidateMode: autovalidateMode,
        controller: controller,
        focusNode: focusNode,
        style: _setFontStyle(),
        obscureText: isObscureText!,
        textInputAction: textInputAction,
        maxLines: maxLines ?? 1,
        decoration: _buildDecoration(),
        validator: validator,
      ),
    );
  }

  _buildDecoration() {
    return InputDecoration(
      label: Text(label ?? ""),
      labelStyle: labelStyle ?? TextStyle(color: ColorConstant.black900),
      hintText: hintText ?? "",
      hintStyle: TextStyle(),
      border: _setBorderStyle(),
      enabledBorder: _setBorderStyle(),
      focusedBorder: _setBorderStyle(),
      disabledBorder: _setBorderStyle(),
      prefixIcon: prefix,
      errorText: errMessage != "" && errMessage != null ? errMessage : null,
      prefixIconConstraints: prefixConstraints,
      suffixIcon: suffix,
      suffixIconConstraints: suffixConstraints,
      fillColor: _setFillColor(),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      filled: _setFilled(),
      isDense: true,
      contentPadding: _setPadding(),
    );
  }

  _setFontStyle() {
    switch (fontStyle) {
      case TextFormFieldFontStyle.UrbanistRegular14:
        return TextStyle(
          color: ColorConstant.black900,
          fontSize: getFontSize(
            14,
          ),
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w400,
        );
      case TextFormFieldFontStyle.UrbanistSemiBold16:
        return TextStyle(
          color: ColorConstant.black900,
          fontSize: getFontSize(
            16,
          ),
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w600,
        );
      case TextFormFieldFontStyle.UrbanistSemiBold20:
        return TextStyle(
          color: ColorConstant.black900,
          fontSize: getFontSize(
            20,
          ),
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w600,
        );
      case TextFormFieldFontStyle.UrbanistSemiBold16Black:
        return TextStyle(
          color: ColorConstant.black900,
          fontSize: getFontSize(
            16,
          ),
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w600,
        );
      case TextFormFieldFontStyle.UrbanistSemiBold16Black:
        return TextStyle(
          color: ColorConstant.black900,
          fontSize: getFontSize(
            16,
          ),
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w600,
        );
      default:
        return TextStyle(
          color: ColorConstant.gray900,
          fontSize: getFontSize(
            14,
          ),
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w600,
        );
    }
  }

  _setOutlineBorderRadius() {
    switch (shape) {
      case TextFormFieldShape.CircleBorder19:
        return BorderRadius.circular(
          getHorizontalSize(
            19.00,
          ),
        );
      case TextFormFieldShape.RoundedBorder12:
        return BorderRadius.circular(
          getHorizontalSize(
            12.00,
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

  _setBorderStyle() {
    switch (variant) {
      case TextFormFieldVariant.FillGray800:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: BorderSide.none,
        );
      case TextFormFieldVariant.purpleOpaue:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: BorderSide.none,
        );
      case TextFormFieldVariant.RoundedBlack:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: BorderSide(color: ColorConstant.black900),
        );
      default:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: BorderSide.none,
        );
    }
  }

  _setFillColor() {
    switch (variant) {
      case TextFormFieldVariant.FillGray800:
        return ColorConstant.gray800;
      case TextFormFieldVariant.purpleOpaue:
        return ColorConstant.purpleOpaue2;
      default:
        return ColorConstant.gray50;
    }
  }

  _setFilled() {
    switch (variant) {
      case TextFormFieldVariant.FillGray800:
        return true;
      default:
        return true;
    }
  }

  _setPadding() {
    switch (padding) {
      case TextFormFieldPadding.PaddingTB25:
        return getPadding(
          left: 20,
          top: 20,
          right: 20,
          bottom: 25,
        );
      case TextFormFieldPadding.PaddingTB21:
        return getPadding(
          left: 20,
          top: 20,
          right: 20,
          bottom: 21,
        );
      case TextFormFieldPadding.PaddingTB8:
        return getPadding(
          left: 7,
          top: 7,
          right: 7,
          bottom: 8,
        );
      case TextFormFieldPadding.PaddingT13:
        return getPadding(
          left: 8,
          top: 13,
          right: 8,
          bottom: 8,
        );
      default:
        return getPadding(
          left: 18,
          top: 22,
          right: 18,
          bottom: 18,
        );
    }
  }
}

enum TextFormFieldShape {
  RoundedBorder16,
  RoundedBorder12,
  CircleBorder19,
}

enum TextFormFieldPadding {
  PaddingTB25,
  PaddingT22,
  PaddingTB21,
  PaddingTB8,
  PaddingT13,
}

enum TextFormFieldVariant {
  FillGray50,
  FillGray800,
  Custom,
  purpleOpaue,
  RoundedBlack,
}

enum TextFormFieldFontStyle {
  UrbanistSemiBold14,
  UrbanistRegular14,
  UrbanistSemiBold16,
  UrbanistSemiBold16Black,
  UrbanistSemiBold24,
  UrbanistSemiBold20,
}
