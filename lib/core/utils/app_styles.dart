import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class AppStyles {
  static TextStyle get darkBlue24Bold => TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.darkBlueColor,
      );

  static TextStyle get gray16medium => TextStyle(
        fontSize: 16.sp,
        color: AppColors.grayColor,
      );

  static TextStyle get gray14medium => TextStyle(
        fontSize: 14.sp,
        color: AppColors.grayColor,
      );

  static TextStyle get white14medium => TextStyle(
        fontSize: 14.sp,
        color: AppColors.whiteColor.withOpacity(0.8),
      );

  static TextStyle get white15medium => TextStyle(
        fontSize: 15.sp,
        color: AppColors.whiteColor.withOpacity(0.8),
      );

  static TextStyle get gray14bold => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.grayColor,
      );

  static TextStyle get darkBlue16Bold => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.darkBlueColor,
      );

  static TextStyle get darkBlue16medium => TextStyle(
        fontSize: 16.sp,
        color: AppColors.darkBlueColor,
      );

  static TextStyle get white21bold => TextStyle(
        fontSize: 21.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.whiteColor,
      );

  static TextStyle get white16bold => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.whiteColor,
      );

  static TextStyle get white16medium => TextStyle(
        fontSize: 16.sp,
        color: AppColors.whiteColor,
      );

  static TextStyle get white18bold => TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.whiteColor,
      );

  static TextStyle get white28bold => TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.whiteColor,
      );
}
