import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/const%20Widgets/custom_button.dart';
import 'package:graduation_project/core/utils/app_styles.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_texts.dart';
import '../../../../../core/utils/app_images.dart';
import '../../../data/model/team_model.dart';

class BigInfoCard extends StatelessWidget {
  final TeamData team;
  final VoidCallback? onButtonPressed;

  const BigInfoCard({super.key, required this.team, this.onButtonPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35.r),
        image: const DecorationImage(
          image: AssetImage(AppImages.cardBackGround),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(15.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35.r),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.black.withOpacity(0.50),
              Colors.black.withOpacity(0.20),
              Colors.black.withOpacity(0.0),
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 8.h),
            Icon(Icons.people, color: AppColors.whiteColor, size: 45.sp),
            SizedBox(height: 12.h),
            Column(
              children: [
                Text('Team ${team.teamName ?? ''}', style: AppStyles.white21bold),
                SizedBox(height: 4.h),
                Text(team.createAt ?? '', style: AppStyles.white16medium),
              ],
            ),
            SizedBox(height: 12.h),
            CustomElevatedButton(
              text: AppTexts.startTalking,
              onPressed: onButtonPressed ?? () {},
              backgroundColor: Colors.white,
              textColor: Colors.black,
              height: 35.h,
              width: double.infinity,
              fontSize: 15.sp,
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }
}
