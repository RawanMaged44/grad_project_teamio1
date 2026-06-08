import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final double fontSize;
  final double width;
  final double height;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double borderRadius;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.fontSize = 22,
    this.width = 250,
    this.height = 50,
    this.isLoading = false,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        minimumSize: Size(width, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius.r),
        ),
      ),
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? SizedBox(
              height: 20.r,
              width: 20.r,
              child: CircularProgressIndicator(
                color: textColor ?? Colors.white,
                strokeWidth: 2,
              ),
            )
          : Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: fontSize.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }
}
