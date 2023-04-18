import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:flutter/material.dart';

class DarkTheme implements IThemeSpec {
  final double height;
  final double width;
  const DarkTheme({
    required this.height,
    required this.width,
  });

  @override
  double get themeHeight => 844;

  @override
  double get themeWidth => 360;

  @override
  bool get isDarkTheme => true;

  @override
  Color get appBarBackgroundColor => Colors.black;

  @override
  Color get backgroundColor => const Color.fromARGB(255, 0, 0, 0);

  @override
  Color get secondaryTextColor => const Color.fromARGB(255, 114, 114, 114);

  @override
  Color get whiteColor => const Color.fromARGB(255, 255, 255, 255);

  @override
  Color get secondaryBackgroundColor => const Color.fromARGB(255, 51, 51, 51);

  @override
  Color get thirdBackgroundColor => const Color.fromARGB(255, 37, 37, 37);

  @override
  Color get bodyTextColor => const Color.fromARGB(255, 139, 137, 147);

  @override
  Color get arrowButtonBackgroundColor =>
      const Color.fromRGBO(192, 195, 201, 1);

  @override
  Color get appGreen => const Color.fromRGBO(77, 204, 143, 1);

  @override
  Color get backgroundCardColor => const Color.fromARGB(255, 26, 26, 26);

  @override
  Color get cardColor => const Color.fromARGB(255, 21, 27, 37);

  @override
  Color get ratingGrey => const Color.fromARGB(255, 178, 178, 178);

  @override
  Color get unratedGrey => const Color.fromARGB(255, 76, 76, 76);
  @override
  Color get errorRed => const Color.fromARGB(255, 194, 60, 60);

  @override
  Color get blue => const Color.fromARGB(255, 60, 152, 194);

  @override
  Color get greyBlue => const Color.fromARGB(255, 46, 93, 115);

  @override
  Color get black => const Color.fromARGB(255, 0, 0, 0);

  @override
  Color get greyArrowColor => const Color.fromARGB(255, 163, 163, 163);

  @override
  Color get gradientBlue => const Color.fromARGB(2, 0, 179, 227);

  @override
  Color get gradientBlue2 => const Color.fromARGB(0, 0, 179, 227);

  @override
  Color get buttonBlue => const Color.fromARGB(255, 0, 178, 227);

  @override
  Color get buttonRed => const Color.fromARGB(255, 249, 94, 94);

  @override
  Color get wcBlue => const Color(0xFF00B3E3);

  @override
  Color get sheetBackgroundColor => const Color.fromARGB(255, 21, 27, 37);

  @override
  Color get cardBlue => const Color.fromRGBO(0, 118, 226, 0.4);

  @override
  Color get chipBlue => const Color.fromRGBO(0, 132, 255, 0.2);

  @override
  Color get cardGreen => const Color.fromRGBO(10, 156, 85, 0.4);

  @override
  Color get cardGrey => const Color.fromRGBO(12, 53, 90, 1);

  @override
  Color get searchBigCardBG => const Color.fromRGBO(19, 27, 38, 1);

  @override
  Color get tabGrey => const Color.fromARGB(255, 41, 41, 41);

  @override
  TextStyle get headingTextStyle => TextStyle(
        // h5 -> headline
        fontFamily: fontName,
        fontSize: relativeTextSize(24),
        color: whiteColor,
        fontWeight: FontWeight.w600,
      );

  @override
  TextStyle get exploreCardTitle => TextStyle(
        // h5 -> headline
        fontFamily: fontName,
        fontSize: relativeTextSize(20),
        color: whiteColor,
        fontWeight: FontWeight.w300,
      );

  @override
  TextStyle get exploreCardTitleBold => TextStyle(
        // h5 -> headline
        fontFamily: fontName,
        fontSize: relativeTextSize(20),
        color: whiteColor,
        fontWeight: FontWeight.w700,
      );

  @override
  TextStyle get secondaryTextStyle1 => TextStyle(
        // h5 -> headline
        fontFamily: fontName,
        fontSize: relativeTextSize(10),
        color: secondaryTextColor,
      );

  @override
  TextStyle get secondaryTextStyle2 => TextStyle(
      // h5 -> headline
      fontFamily: fontName,
      fontSize: relativeTextSize(10),
      color: whiteColor,
      fontWeight: FontWeight.w500);

  @override
  TextStyle get secondaryWhiteTextStyle3 => TextStyle(
      // h5 -> headline
      fontFamily: fontName,
      fontSize: relativeTextSize(12),
      color: whiteColor,
      fontWeight: FontWeight.w400);
  @override
  TextStyle get secondaryGreenTextStyle4 => TextStyle(
      // h5 -> headline
      fontFamily: fontName,
      fontSize: relativeTextSize(12),
      color: appGreen,
      fontWeight: FontWeight.w400);

  @override
  TextStyle get titleTextStyle => TextStyle(
        // h5 -> headline
        fontFamily: fontName,
        fontSize: relativeTextSize(16),
        fontWeight: FontWeight.w500,
        color: whiteColor,
      );

  @override
  TextStyle get biggerTitleTextStyle => TextStyle(
        // h5 -> headline
        fontFamily: fontName,
        fontSize: relativeTextSize(18),
        //  fontSize: 20,

        fontWeight: FontWeight.w500,
        color: whiteColor,
      );

  @override
  TextStyle get secondaryTitleTextStyle => TextStyle(
        // h5 -> headline
        fontFamily: fontName,
        fontSize: relativeTextSize(16),
        fontWeight: FontWeight.w600,
        color: whiteColor,
      );

  @override
  TextStyle get bodyTextStyle => TextStyle(
        // h5 -> headline
        fontFamily: fontName,
        fontSize: relativeTextSize(12),
        fontWeight: FontWeight.w400,
        color: bodyTextColor,
      );
  @override
  TextStyle get whiteBodyTextStyle => TextStyle(
        // h5 -> headline
        fontFamily: fontName,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: whiteColor,
      );

  @override
  TextStyle get buttonTextStyle => TextStyle(
        // h5 -> headline
        fontFamily: fontName,
        fontSize: relativeTextSize(14),
        color: whiteColor,
        fontWeight: FontWeight.w700,
      );

  @override
  TextStyle get smallButtonTextStyle => TextStyle(
        // h5 -> headline
        fontFamily: fontName,
        fontSize: relativeTextSize(12),
        color: whiteColor,
        fontWeight: FontWeight.w700,
      );
  @override
  TextStyle get normalTextStyle => TextStyle(
        // h5 -> headline
        fontFamily: fontName,
        fontSize: relativeTextSize(14),
        color: whiteColor,
        fontWeight: FontWeight.w500,
      );
  @override
  TextStyle get normalTextStyle2 => TextStyle(
        // h5 -> headline
        fontFamily: fontName,
        fontSize: relativeTextSize(14),
        color: whiteColor,
        fontWeight: FontWeight.w600,
      );
  @override
  TextStyle get whiteBoldTextStyle => TextStyle(
        fontFamily: fontName,
        fontSize: relativeTextSize(12),
        color: whiteColor,
        fontWeight: FontWeight.w600,
      );
  @override
  TextStyle get titleTextExtraBold => TextStyle(
        // h5 -> headline
        fontFamily: fontName,
        fontSize: relativeTextSize(14),
        fontWeight: FontWeight.w700,
        color: whiteColor,
      );
  @override
  TextStyle get greyHeading => TextStyle(
        fontFamily: fontName,
        fontSize: relativeTextSize(12),
        color: whiteColor,
        fontWeight: FontWeight.w400,
      );

  @override
  TextStyle get whiteButtonTextStyle => TextStyle(
        fontFamily: fontName,
        fontSize: relativeTextSize(14),
        color: black,
        fontWeight: FontWeight.w600,
      );

  @override
  TextStyle get redButtonText => TextStyle(
        fontFamily: fontName,
        fontSize: relativeTextSize(14),
        color: buttonRed,
        fontWeight: FontWeight.w500,
      );

  @override
  double get imageBorderRadius => 20;

  @override
  String get fontName => 'GeneralSans';

  @override
  double get cardRadius => 16;

  @override
  double get buttonRadius => 12;

  @override
  double get wcIconSize => 20;

  @override
  double get vSmallRadius => 2;

  @override
  double get smallRadius => 4;

  @override
  RoundedRectangleBorder get cardShape => const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      );

  @override
  RoundedRectangleBorder get sheetCardShape => const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(24),
        ),
      );
  @override
  double relativeWidth(double w) => width * (w / themeWidth);

  @override
  double relativeHeight(double h) => height * (h / themeHeight);

  @override
  double relativeTextSize(double s) => height * (s / height);
}
