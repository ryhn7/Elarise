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
TextStyle getGrotesqueSemiBoldStyle24(
    {double fontSize = FontSize.s24, required Color color}) {
  return _getTextStyle(fontSize, FontBricolageGrotesque.fontFamily,
      FonttWeightManager.fontWeightBold, color);
}

TextStyle getGrotesqueSemiBoldStyle32(
    {double fontSize = FontSize.s32, required Color color}) {
  return _getTextStyle(fontSize, FontBricolageGrotesque.fontFamily,
      FonttWeightManager.fontWeightBold, color);
}

TextStyle getGrotesqueSemiBoldStyle40(
    {double fontSize = FontSize.s40, required Color color}) {
  return _getTextStyle(fontSize, FontBricolageGrotesque.fontFamily,
      FonttWeightManager.fontWeightBold, color);
}

TextStyle getGrotesqueSemiBoldStyle72(
    {double fontSize = FontSize.s72, required Color color}) {
  return _getTextStyle(fontSize, FontBricolageGrotesque.fontFamily,
      FonttWeightManager.fontWeightBold, color);
}

// Sans Francisco
TextStyle getSansFranciscoRegular14(
    {double fontSize = FontSize.s14, required Color color}) {
  return _getTextStyle(fontSize, FontSansFrancisco.fontFamily,
      FonttWeightManager.fontWeightRegular, color);
}

TextStyle getSansFranciscoSemiBold14(
    {double fontSize = FontSize.s14, required Color color}) {
  return _getTextStyle(fontSize, FontSansFrancisco.fontFamily,
      FonttWeightManager.fontWeightSemiBold, color);
}

TextStyle getSansFranciscoRegular16(
    {double fontSize = FontSize.s16, required Color color}) {
  return _getTextStyle(fontSize, FontSansFrancisco.fontFamily,
      FonttWeightManager.fontWeightRegular, color);
}

TextStyle getSansFranciscoMedium16(
    {double fontSize = FontSize.s16, required Color color}) {
  return _getTextStyle(fontSize, FontSansFrancisco.fontFamily,
      FonttWeightManager.fontWeightMedium, color);
}

TextStyle getSansFranciscoSemiBold16(
    {double fontSize = FontSize.s16, required Color color}) {
  return _getTextStyle(fontSize, FontSansFrancisco.fontFamily,
      FonttWeightManager.fontWeightSemiBold, color);
}

TextStyle getSansFranciscoBold16(
    {double fontSize = FontSize.s16, required Color color}) {
  return _getTextStyle(fontSize, FontSansFrancisco.fontFamily,
      FonttWeightManager.fontWeightBold, color);
}

TextStyle getSansFranciscoRegular18(
    {double fontSize = FontSize.s18, required Color color}) {
  return _getTextStyle(fontSize, FontSansFrancisco.fontFamily,
      FonttWeightManager.fontWeightRegular, color);
}

TextStyle getSansFranciscoMedium18(
    {double fontSize = FontSize.s18, required Color color}) {
  return _getTextStyle(fontSize, FontSansFrancisco.fontFamily,
      FonttWeightManager.fontWeightMedium, color);
}

TextStyle getSansFranciscoMedium20(
    {double fontSize = FontSize.s20, required Color color}) {
  return _getTextStyle(fontSize, FontSansFrancisco.fontFamily,
      FonttWeightManager.fontWeightMedium, color);
}

TextStyle getSansFranciscoSemiBold20(
    {double fontSize = FontSize.s20, required Color color}) {
  return _getTextStyle(fontSize, FontSansFrancisco.fontFamily,
      FonttWeightManager.fontWeightSemiBold, color);
}

TextStyle getSansFranciscoBold20(
    {double fontSize = FontSize.s20, required Color color}) {
  return _getTextStyle(fontSize, FontSansFrancisco.fontFamily,
      FonttWeightManager.fontWeightBold, color);
}

TextStyle getSansFranciscoExtraBold20(
    {double fontSize = FontSize.s20, required Color color}) {
  return _getTextStyle(fontSize, FontSansFrancisco.fontFamily,
      FonttWeightManager.fontWeightExtraBold, color);
}

TextStyle getSansFranciscoMedium24(
    {double fontSize = FontSize.s24, required Color color}) {
  return _getTextStyle(fontSize, FontSansFrancisco.fontFamily,
      FonttWeightManager.fontWeightMedium, color);
}

TextStyle getSansFranciscoSemiBold24(
    {double fontSize = FontSize.s24, required Color color}) {
  return _getTextStyle(fontSize, FontSansFrancisco.fontFamily,
      FonttWeightManager.fontWeightSemiBold, color);
}

TextStyle getSansFranciscoBold24(
    {double fontSize = FontSize.s24, required Color color}) {
  return _getTextStyle(fontSize, FontSansFrancisco.fontFamily,
      FonttWeightManager.fontWeightBold, color);
}

TextStyle getSansFranciscoSemiBold32(
    {double fontSize = FontSize.s32, required Color color}) {
  return _getTextStyle(fontSize, FontSansFrancisco.fontFamily,
      FonttWeightManager.fontWeightSemiBold, color);
}
