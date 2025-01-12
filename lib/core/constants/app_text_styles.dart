import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'app_colors.dart';

class AppTextStyles {
  static TextStyle h1({
    TextDecoration? decoration,
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    TextOverflow? overflow,
    Color? decorationColor,
  }) {
    return GoogleFonts.playfairDisplay(
      textStyle: TextStyle(
        fontSize: fontSize?.sp ?? 20.sp,
        fontWeight: fontWeight ?? FontWeight.w600,
        color: color ?? AppColors.blackPrimary,
        decoration: decoration ?? TextDecoration.none,
        decorationColor: decorationColor,
        overflow: overflow,
      ),
    );
  }

  static TextStyle h2({
    TextDecoration? decoration,
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    TextOverflow? overflow,
    Color? decorationColor,
    double? lineHeight,
  }) {
    return GoogleFonts.poppins(
      textStyle: TextStyle(
        fontSize: fontSize ?? 15.15.sp,
        fontWeight: fontWeight ?? FontWeight.w600,
        color: color ?? AppColors.blackPrimary,
        decoration: decoration ?? TextDecoration.none,
        decorationColor: decorationColor,
        overflow: overflow,
        height: lineHeight,
      ),
    );
  }

  static TextStyle b1({
    TextDecoration? decoration,
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    TextOverflow? overflow,
    Color? decorationColor,
  }) {
    return GoogleFonts.poppins(
      textStyle: TextStyle(
        fontSize: fontSize ?? 14.sp,
        fontWeight: fontWeight ?? FontWeight.w400,
        color: color ?? AppColors.blackPrimary,
        decoration: decoration ?? TextDecoration.none,
        decorationColor: decorationColor,
        overflow: overflow,
      ),
    );
  }
}
