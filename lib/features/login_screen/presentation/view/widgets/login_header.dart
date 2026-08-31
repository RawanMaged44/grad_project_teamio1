import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_images.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/app_texts.dart';

class LoginTitleSection extends StatelessWidget {
  const LoginTitleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 0.12.sh),
        Center(
          child: Container(
            width: 90.r,
            height: 90.r,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            padding: EdgeInsets.all(6.r),
            child: Image.asset(
              AppImages.logo,
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(height: 0.02.sh),
        Center(
          child: Text(AppTexts.welcomeBack, style: AppStyles.white28bold),
        ),
        SizedBox(height: 8.h),
        Center(
          child: Text(AppTexts.continueStatement, style: AppStyles.white16medium),
        ),
        SizedBox(height: 0.05.sh),
      ],
    );
  }
}
