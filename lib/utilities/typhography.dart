import 'package:flutter/material.dart';
import 'colors.dart';

class TStyle {
  static const TextStyle judul = TextStyle(
    fontFamily: 'MuseoModerno',
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle overline = TextStyle(
      fontWeight: FontWeight.w400, fontSize: 12, color: kColorDarkGrey);

  static const TextStyle caption = TextStyle(
      fontWeight: FontWeight.w400, fontSize: 12, color: kColorDarkGrey);

  static const TextStyle captionBlack = TextStyle(
      fontWeight: FontWeight.w400, fontSize: 10, color: kColorDarkGrey);

  static const TextStyle captionWhite = TextStyle(
      fontWeight: FontWeight.w400, fontSize: 10, color: kColorPureWhite);

  static const TextStyle button2 = TextStyle(
      fontWeight: FontWeight.w500, fontSize: 14, color: kColorDarkGrey);

  static const TextStyle textChat = TextStyle(
      fontWeight: FontWeight.w500, fontSize: 14, color: kColorPureWhite);

  static const TextStyle textChatItalic = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      color: kColorMediumGrey,
      fontStyle: FontStyle.italic);

  static const TextStyle button1 = TextStyle(
      fontWeight: FontWeight.w700, fontSize: 16, color: kColorDarkGrey);

  static const TextStyle body2 = TextStyle(
      fontWeight: FontWeight.w400, fontSize: 14, color: kColorDarkGrey);

  static const TextStyle body1 = TextStyle(
      fontWeight: FontWeight.w500, fontSize: 16, color: kColorDarkGrey);

  static const TextStyle subtitle2 = TextStyle(
      fontWeight: FontWeight.w400, fontSize: 16, color: kColorDarkGrey);

  static const TextStyle subtitle1 = TextStyle(
      fontFamily: 'MuseoModerno',
      fontWeight: FontWeight.w700,
      fontSize: 16,
      color: kColorDarkGrey);

  static const TextStyle headline4 = TextStyle(
      fontWeight: FontWeight.w700, fontSize: 22, color: kColorDarkGrey);

  static const TextStyle headline3 = TextStyle(
      fontWeight: FontWeight.w700, fontSize: 24, color: kColorDarkGrey);

  static const TextStyle headline2 = TextStyle(
      fontWeight: FontWeight.w700, fontSize: 28, color: kColorDarkGrey);

  static const TextStyle headline1 = TextStyle(
      fontWeight: FontWeight.w700, fontSize: 32, color: kColorDarkGrey);

  static const TextStyle w400 = TextStyle(fontWeight: FontWeight.w400);
  static const TextStyle w500 = TextStyle(fontWeight: FontWeight.w500);
  static const TextStyle w600 = TextStyle(fontWeight: FontWeight.w600);
  static const TextStyle w700 = TextStyle(fontWeight: FontWeight.w700);
}
