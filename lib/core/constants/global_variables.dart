import 'package:flutter/material.dart';

class GlobalVariables {
  static late ThemeData appTheme;

  static void initialize(BuildContext context) {
    appTheme = Theme.of(context);
  }
}
