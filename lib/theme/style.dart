import 'package:flutter/material.dart';

import 'font_manager.dart';

TextStyle _getTextStyle(
    double fontSize, String fontFamily, FontWeight fontWeight, Color color) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: fontFamily,
    fontWeight: fontWeight,
    color: color,
  );
}

// Bricolage Grotesque
TextStyle getGrotesqueSemiBoldStyle40(
    {double fontSize = FontSize.s40, required Color color}) {
  return _getTextStyle(fontSize, FontBricolageGrotesque.fontFamily,
      FonttWeightManager.fontWeightBold, color);
}

// Sans Francisco
TextStyle getSansFranciscoRegular14(
    {double fontSize = FontSize.s14, required Color color}) {
  return _getTextStyle(fontSize, FontSansFrancisco.fontFamily,
      FonttWeightManager.fontWeightRegular, color);
}

TextStyle getSansFranciscoRegular16(
    {double fontSize = FontSize.s16, required Color color}) {
  return _getTextStyle(fontSize, FontSansFrancisco.fontFamily,
      FonttWeightManager.fontWeightRegular, color);
}

TextStyle getSansFranciscoRegular18(
    {double fontSize = FontSize.s18, required Color color}) {
  return _getTextStyle(fontSize, FontSansFrancisco.fontFamily,
      FonttWeightManager.fontWeightRegular, color);
}

TextStyle getSansFranciscoRegular28(
    {double fontSize = FontSize.s28, required Color color}) {
  return _getTextStyle(fontSize, FontSansFrancisco.fontFamily,
      FonttWeightManager.fontWeightRegular, color);
}

TextStyle getSansFranciscoRegular72(
    {double fontSize = FontSize.s72, required Color color}) {
  return _getTextStyle(fontSize, FontSansFrancisco.fontFamily,
      FonttWeightManager.fontWeightRegular, color);
}
