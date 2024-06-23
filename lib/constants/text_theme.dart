import 'package:flutter/material.dart';

class AppTextTheme {
  static TextTheme text(BuildContext context) {
    final isPhone = MediaQuery.sizeOf(context).shortestSide < 550;

    return TextTheme(
      titleMedium: TextStyle(
        fontSize: isPhone ? 20 : 24,
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: TextStyle(
        fontSize: isPhone ? 14 : 18,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: TextStyle(
        fontSize: isPhone ? 12 : 16,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
