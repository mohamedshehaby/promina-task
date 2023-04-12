import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'font_manager.dart';

TextStyle _getTextStyle({
  required double fontSize,
  required Color color,
  required FontWeight fontWeight,
}) {
  return GoogleFonts.balooThambi2(
    textStyle:
        TextStyle(fontSize: fontSize.sp, color: color, fontWeight: fontWeight),
  );
}

TextStyle getThinTextStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize: fontSize, color: color, fontWeight: FontWeightManager.thin);
}

TextStyle getExtraLightTextStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: FontWeightManager.extraLight);
}

TextStyle getLightTextStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize: fontSize, color: color, fontWeight: FontWeightManager.light);
}

TextStyle getRegularTextStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize: fontSize, color: color, fontWeight: FontWeightManager.regular);
}

TextStyle getMediumTextStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize: fontSize, color: color, fontWeight: FontWeightManager.medium);
}

TextStyle getSemiBoldTextStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize: fontSize, color: color, fontWeight: FontWeightManager.semiBold);
}

TextStyle getBoldTextStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize: fontSize, color: color, fontWeight: FontWeightManager.bold);
}

TextStyle getExtraBoldTextStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: FontWeightManager.extraBold);
}

TextStyle getBlackTextStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize: fontSize, color: color, fontWeight: FontWeightManager.black);
}
