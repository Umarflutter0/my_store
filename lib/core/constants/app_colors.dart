import 'package:flutter/material.dart';
import 'package:test/core/utils/app_utils.dart';

class AppColors {
  static const Color primary = Color(0xFF2196F3);
  static const Color background = Colors.white;
  static const Color whiteSecondary = Color(0xffF2F2F2);
  static const Color blackPrimary = Color(0xff0C0C0C);
  static const Color redPrimary = Color(0xffEE3C3C);
  static Color blackSecondary =
      AppUtils.getColorWithOpacity(color: blackPrimary, opacity: 0.5);
  static const Color rating = Color(0xFFFFC553);
  static const Color error = Colors.red;
}
