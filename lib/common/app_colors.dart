import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color.fromRGBO(65, 60, 88, 1);
  static const Color accentColor = Color.fromRGBO(155, 29, 32, 1);
  static const Color rubyRed = Color.fromRGBO(155, 29, 32, 1);
  static const Color englishViolet = Color.fromRGBO(65, 60, 88, 1);
  static const Color lightCoral = Color.fromRGBO(238, 118, 116, 1);
  static const Color oliveGreen = Color.fromRGBO(187, 190, 100, 1);
  static const Color champagne = Color.fromRGBO(242, 231, 201, 1);
}

abstract class AppTextStyles {
  static const TextStyle defaultStyle = TextStyle(
    fontWeight: FontWeight.w400,
    color: AppColors.primaryColor,
    fontSize: 14,
  );

  static TextStyle word = defaultStyle.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 40,
  );

  static TextStyle heading = defaultStyle.copyWith(
    fontWeight: FontWeight.w800,
    fontSize: 24,
  );

  static TextStyle heavyHeading = defaultStyle.copyWith(
    fontWeight: FontWeight.w900,
    fontSize: 26,
  );

  static TextStyle subHeading = defaultStyle.copyWith(
    color: AppColors.champagne,
    fontSize: 20,
  );

  static TextStyle heavySubHeading = subHeading.copyWith(
    fontWeight: FontWeight.w800,
  );

  static TextStyle appBarText = defaultStyle.copyWith(
    fontWeight: FontWeight.w800,
    color: Colors.white,
    fontSize: 18,
  );

  static TextStyle mainMessageHeading = defaultStyle.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 32,
  );

  static TextStyle hyperlinkText = defaultStyle.copyWith(
    fontWeight: FontWeight.w800,
  );

  static TextStyle heavyBlackText = defaultStyle.copyWith(
    fontWeight: FontWeight.w800,
    color: Colors.black,
  );
}
