import 'package:flutter/material.dart';
import 'package:itu_geo/core/utils/color_constant.dart';
import 'package:itu_geo/core/utils/size_utils.dart';

class AppDecoration {
  static BoxDecoration get outlineBluegray1000f => BoxDecoration(
        color: ColorConstant.whiteA700,
        boxShadow: [
          BoxShadow(
            color: ColorConstant.blueGray1000f,
            spreadRadius: getHorizontalSize(
              2,
            ),
            blurRadius: getHorizontalSize(
              2,
            ),
            offset: Offset(
              0,
              -8,
            ),
          ),
        ],
      );
  static BoxDecoration get gradientOrangeA400OrangeA200 => BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(
            1,
            1,
          ),
          end: const Alignment(
            0,
            0,
          ),
          colors: [
            ColorConstant.orangeA400,
            ColorConstant.orangeA200,
          ],
        ),
      );

  static BoxDecoration get gradientRed700RedA702 => BoxDecoration(
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
            ColorConstant.red700,
            ColorConstant.redA702,
          ],
        ),
      );
  static BoxDecoration get gradientPurpleA700DeeppurpleA200 => BoxDecoration(
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
            ColorConstant.purpleA700,
            ColorConstant.deepPurpleA200,
          ],
        ),
      );

  static BoxDecoration get gradientGreenA400Green700 => BoxDecoration(
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
            ColorConstant.greenA701,
            ColorConstant.greenA700,
          ],
        ),
        // borderRadius: BorderRadiusStyle.roundedBorder12,
      );
  static BoxDecoration get gradientGreenA400Green700Rounded => BoxDecoration(
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
            ColorConstant.greenA701,
            ColorConstant.greenA700,
          ],
        ),
        borderRadius: BorderRadiusStyle.roundedBorder12,
      );

  static BoxDecoration get gradientGray300Gray400Rounded => BoxDecoration(
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
            ColorConstant.gray100,
            ColorConstant.gray50,
          ],
        ),
        borderRadius: BorderRadiusStyle.roundedBorder12,
      );

  static BoxDecoration get gradientRedA200PinkA100 => BoxDecoration(
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
            ColorConstant.red700,
            ColorConstant.redA202,
          ],
        ),
      );
  static BoxDecoration get outlineBluegray100 => BoxDecoration(
        color: ColorConstant.whiteA700,
        border: Border.all(
          color: ColorConstant.bluegray100,
          width: getHorizontalSize(
            1.00,
          ),
        ),
      );
  static BoxDecoration get fillGray52 => BoxDecoration(
        color: ColorConstant.gray52,
      );
  static BoxDecoration get fillBluegray500 => BoxDecoration(
        color: ColorConstant.bluegray500,
      );
  static BoxDecoration get txtFillGray800 => BoxDecoration(
        color: ColorConstant.gray800,
      );
  static BoxDecoration get fillGray50 => BoxDecoration(
        color: ColorConstant.gray50,
      );
  static BoxDecoration get fillGray802 => BoxDecoration(
        color: ColorConstant.gray802,
      );
  static BoxDecoration get fillCyan500 => BoxDecoration(
        color: ColorConstant.cyan500,
      );
  static BoxDecoration get fillTeal500 => BoxDecoration(
        color: ColorConstant.teal500,
      );
  static BoxDecoration get fillGray701 => BoxDecoration(
        color: ColorConstant.gray701,
      );
  static BoxDecoration get fillGray800 => BoxDecoration(
        color: ColorConstant.gray800,
      );
  static BoxDecoration get fillGray100 => BoxDecoration(
      color: ColorConstant.gray100,
      borderRadius: BorderRadiusStyle.circleBorder12);

  static BoxDecoration get roundedBlack => BoxDecoration(
        color: ColorConstant.whiteA700,
        border: Border.all(
          color: ColorConstant.black900,
          width: getHorizontalSize(
            1.20,
          ),
        ),
      );
  static BoxDecoration get outlineRedA700 => BoxDecoration(
        color: ColorConstant.whiteA700,
        border: Border.all(
          color: ColorConstant.redA700,
          width: getHorizontalSize(
            3.00,
          ),
        ),
      );
  static BoxDecoration get fillGray90099 => BoxDecoration(
        color: ColorConstant.gray90099,
      );
  static BoxDecoration get fillWhiteA700 => BoxDecoration(
        color: ColorConstant.whiteA700,
      );
  static BoxDecoration get fillGray501 => BoxDecoration(
        color: ColorConstant.gray50,
      );
  static BoxDecoration get outlineGray100 => BoxDecoration(
        color: ColorConstant.whiteA700,
        border: Border.all(
          color: ColorConstant.gray100,
          width: getHorizontalSize(
            1.00,
          ),
        ),
      );
  static BoxDecoration get txtFillRedA702 => BoxDecoration(
        color: ColorConstant.redA702,
      );
  static BoxDecoration get fillGreenA702 => BoxDecoration(
        color: ColorConstant.greenA702,
      );

  static BoxDecoration get fillGreenCircle => BoxDecoration(
      color: ColorConstant.greenA702,
      borderRadius: BorderRadiusStyle.circleBorder12);

  static BoxDecoration get fillGrayCircle => BoxDecoration(
      color: ColorConstant.gray400,
      borderRadius: BorderRadiusStyle.circleBorder12);

  static BoxDecoration get noneColorCircle12 =>
      BoxDecoration(borderRadius: BorderRadiusStyle.circleBorder12);
}

class BorderRadiusStyle {
  static BorderRadius customBorderTL40 = BorderRadius.only(
    topLeft: Radius.circular(
      getHorizontalSize(
        40.00,
      ),
    ),
    topRight: Radius.circular(
      getHorizontalSize(
        40.00,
      ),
    ),
  );

  static BorderRadius circleBorder125 = BorderRadius.circular(
    getHorizontalSize(
      125.00,
    ),
  );

  static BorderRadius txtCircleBorder19 = BorderRadius.circular(
    getHorizontalSize(
      19.00,
    ),
  );

  static BorderRadius txtRoundedBorder22 = BorderRadius.circular(
    getHorizontalSize(
      22.96,
    ),
  );

  static BorderRadius roundedBorder16 = BorderRadius.circular(
    getHorizontalSize(
      16.00,
    ),
  );

  static BorderRadius roundedBorder28 = BorderRadius.circular(
    getHorizontalSize(
      28.00,
    ),
  );

  static BorderRadius circleBorder24 = BorderRadius.circular(
    getHorizontalSize(
      24.00,
    ),
  );

  static BorderRadius circleBorder12 = BorderRadius.circular(
    getHorizontalSize(
      12.00,
    ),
  );

  static BorderRadius roundedBorder48 = BorderRadius.circular(
    getHorizontalSize(
      48.00,
    ),
  );

  static BorderRadius roundedBorder100 = BorderRadius.circular(
    getHorizontalSize(
      100.00,
    ),
  );

  static BorderRadius circleBorder40 = BorderRadius.circular(
    getHorizontalSize(
      40.00,
    ),
  );

  static BorderRadius roundedBorder12 = BorderRadius.circular(
    getHorizontalSize(
      12.00,
    ),
  );

  static BorderRadius roundedBorder32 = BorderRadius.circular(
    getHorizontalSize(
      32.00,
    ),
  );

  static BorderRadius roundedBorder127 = BorderRadius.circular(
    getHorizontalSize(
      127.55,
    ),
  );

  static BorderRadius circleBorder70 = BorderRadius.circular(
    getHorizontalSize(
      70.00,
    ),
  );

  static BorderRadius roundedBorder20 = BorderRadius.circular(
    getHorizontalSize(
      20.00,
    ),
  );

  static BorderRadius circleBorder61 = BorderRadius.circular(
    getHorizontalSize(
      61.15,
    ),
  );

  static BorderRadius customBorderTL60 = BorderRadius.only(
    topLeft: Radius.circular(
      getHorizontalSize(
        60.00,
      ),
    ),
    topRight: Radius.circular(
      getHorizontalSize(
        60.00,
      ),
    ),
  );

  static BorderRadius roundedBorder80 = BorderRadius.circular(
    getHorizontalSize(
      80.00,
    ),
  );
}
