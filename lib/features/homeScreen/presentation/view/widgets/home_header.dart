import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:graduation_project/core/utils/app_styles.dart';
import 'package:graduation_project/core/utils/app_texts.dart';

class HomeHeader extends StatelessWidget {
  final String userName;
  final VoidCallback? onProfileTap;

  const HomeHeader({super.key, required this.userName, this.onProfileTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppTexts.titleTeamio, style: AppStyles.white21bold),
            Text(AppTexts.welcomeMessage, style: AppStyles.white14medium),
          ],
        ),
        Row(
          children: [
            Icon(Icons.notifications, color: AppColors.whiteColor, size: 24.sp),
            SizedBox(width: 12.w),
            GestureDetector(
              onTap: onProfileTap,
              child: Icon(Icons.person, color: AppColors.whiteColor, size: 24.sp),
            ),
          ],
        ),
      ],
    );
  }
}
