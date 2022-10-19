import 'package:flutter/material.dart';

import '../Constants/colors.dart';

ThemeData appDefaultTheme() {
  return ThemeData(
    primaryColor: AppColors.kPrimaryColor,
    scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
    // primarySwatch: AppColors.kPrimaryColor,
    // fontFamily: 'Raleway',
    textTheme: ThemeData.light().textTheme.copyWith(
          bodySmall: const TextStyle(
            color: AppColors.black,
            fontSize: 12,
          ),
          bodyMedium: const TextStyle(
            color: AppColors.black,
            fontSize: 14,
          ),
          bodyLarge: const TextStyle(
            color: AppColors.black,
            fontSize: 16,
          ),
          titleMedium: const TextStyle(
            color: AppColors.black,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: const TextStyle(
            color: AppColors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
    appBarTheme: const AppBarTheme(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
    ),
  );
}
