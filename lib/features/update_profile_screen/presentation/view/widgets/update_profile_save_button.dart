import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:graduation_project/core/utils/app_styles.dart';
import 'package:graduation_project/core/utils/app_texts.dart';

class UpdateProfileSaveButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const UpdateProfileSaveButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SizedBox(
        width: double.infinity,
        height: 50.h,
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.whiteColor,
            foregroundColor: AppColors.darkBlueColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.r),
            ),
            elevation: 0,
          ),
          child: isLoading
              ? SizedBox(
                  width: 22.r,
                  height: 22.r,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: AppColors.darkBlueColor,
                  ),
                )
              : Text(AppTexts.saveChanges, style: AppStyles.darkBlue16Bold),
        ),
      ),
    );
  }
}
